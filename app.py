from flask import Flask, request, g, redirect, url_for, flash, render_template, abort
from flask_login import LoginManager, UserMixin, current_user, login_user, login_required
import hashlib
import sqlite3
import os


app = Flask(__name__, static_url_path='')
app.config.from_object(os.environ['APP_SETTINGS'])
app.secret_key = 'super secret key'

app.qr_salt ='EBEC'

login_manager = LoginManager(app)

UPLOAD_FOLDER = os.path.dirname(os.path.abspath(__file__)) + '/uploads/'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


#DB

DATABASE = 'db.db'

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db


def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

def ansforteam(name):

    if(name == None):
        return []

    idteam = get_user(name, id=True)

    if(idteam == None):
        return []
    
    idteam = idteam[0]

    query = 'SELECT answ, valid, correct, clue from Answer INNER JOIN Clue ON Clue.idclue = Answer.idclue where idteam = (?)'
    cur = get_db().execute(query, (idteam, )).fetchall()

    print(idteam)

    answs = []

    for ans in cur:

        is_good = see_answer_correct(ans[0], ans[2]) or ans[1] == 1

        answs.append([ans[3], is_good])

    return answs


def get_user(user, id=False):
    cur = get_db().cursor()
    if id:
        cur.execute('SELECT idteam, name, pass, admin FROM team WHERE name=(?)', (user, ))
    else:
        cur.execute('SELECT name, pass, admin FROM team WHERE name=(?)', (user, ))
    return cur.fetchone()

def getAllTeams():
    cur = get_db().cursor()
    teams = []
    for user in query_db('select name, pass from Team'):
        teams.append(user)
    return teams


def see_answer_correct(ans, correct):
    parsed_correct = []
    
    corrects = correct.split(';')

    for corr in corrects:
        parsed_correct.append(corr.lower().strip().replace(' ', ''))

    if((ans.lower().strip().replace(' ', '')) in parsed_correct):
        print('correct {}, ans {}, got True'.format(correct, ans ))
        return True


    print('correct {}, ans {}, got FALSE'.format(correct, ans ))
    return False


def getTeamsScore():
    querry = 'Select name, answ, clue, correct, valid FROM Answer inner join Clue on clue.idClue = Answer.idClue INNER JOIN team on Answer.idTeam=Team.idTeam'
    results = query_db(querry)

    teams_board = {}
    
    teams = query_db('Select Name from Team')

    for team in teams:
        teams_board[team[0]] = 0



    for res in results:

        team = res[0]
        answ = res[1]
        clue = res[2]   
        correct = res[3]


        valid = res[4]
        
        if(valid == 1 or see_answer_correct(answ, correct)):
            if team in teams_board:
                teams_board[res[0]] += 1


    teams_board.pop('admin', None)

    return teams_board

def getAllClues():
    cur = get_db().cursor()
    clues = []
    for clue in query_db('select * from Clue'):
        clues.append(clue)
    return clues

def getAllAnswers():
    cur = get_db().cursor()
    answers = []
    for ans in query_db('select * from Answer'):
        answers.append(ans)
    return answers

def getClue(id):
    clues = getAllClues()
    for clue in clues:
        if(clue[0] == id):
            return clue
    return None

def answerExists(idTeam, idClue):
    cur = get_db().cursor()
    res = query_db('select * from Answer where idTeam=(?) and idClue=(?)', (idTeam, idClue))
    if(len(res) == 0):
        return None
    return res[0]

def insertAnswer(answ, idclue, team_log, team_pass):
    user = get_user(team_log, id=True)
    if user is None:
        return None
    if team_pass != user[2]:
        return 'Bad Password'
    cur = get_db().cursor()

    old_answer = answerExists(user[0], idclue)
    if(old_answer is not None):
        cur.execute('UPDATE Answer set answ = (?), valid = 0 WHERE idTeam=(?) and idclue=(?) ;', (answ, user[0], idclue, ))
        get_db().commit()
        return 0
    else:
        cur.execute('INSERT INTO Answer (answ, idTeam, idClue) VALUES(?, ?, ?);', (answ, user[0], idclue, ))
        get_db().commit()
        print('Inserted Answered for team {}, ans {}'.format(team_log, answ))
        return 0

def makeAnswerCorrect(idTeam, idClue):
    old_answer = answerExists(idTeam, idClue)
    cur = get_db().cursor()
    if(old_answer is not None):
        cur.execute('UPDATE Answer set valid = 1 WHERE idTeam=(?) and idclue=(?) ;', (idTeam, idClue, ))
        get_db().commit()
        return 0
    return 1


#/DB


#User

class User(UserMixin):
    def __init__(self, name, id, active=True, admin=False):
        self.name = name
        self.id = id
        self.active = active
        self.admin = admin

    def is_active(self):
        # Here you should write whatever the code is
        # that checks the database if your user is active
        return self.active

    def is_anonymous(self):
        return False

    def is_authenticated(self):
        return True

    def is_admin(self):
        return self.admin


@login_manager.user_loader
def load_user(id):
    # 1. Fetch against the database a user by `id` 
    # 2. Create a new object of `User` class and return it.
    u = get_user(id)

    if u is None:
        return None
    
    return User(u[0], u[1], active=True, admin=u[2])


@app.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return main_page()
    form = request.form


    if get_user(form['user']) is None:
        return main_page()

    passw = get_user(form['user'])[1]


    user = load_user(form['user'])

    if user is None or passw != form['pass']:
        flash('Invalid username or password')
        return main_page()

    login_user(user, remember=form)
    g.user = user
    print('User logedin in {}'.format(g.user))
    return main_page()

#/User

#QR


def build_rain_table(len=25):
    hash_func = hashlib.md5()
    table = {}
    for i in range(0, len):
        hash = hashlib.md5(app.qr_salt.encode() +  bytes(i)).hexdigest()
        table[hash] = i
    return table


@app.route('/qr/<qr_hashed>')
def qr_code_path(qr_hashed):
    rt_table = build_rain_table()
    if qr_hashed not in rt_table:
        return abort(404)
    else:
        clue_pk = rt_table[qr_hashed]
        clue_db = getClue(int(clue_pk))
        clue = {}
        clue['id'] = '/qr_f/'+ qr_hashed
        clue['text'] = clue_db[1]

        print(clue['text'])

        show_image = None
        if('jpg' in clue['text'].split(' ')[-1]):
            print('Found image clue')
            show_image = clue['text'].split(' ')[-1]
            clue['text'] = clue['text'].rsplit(' ', 1)[0]


        #clue['specials'] = [{'type':'text', 'name':'special', 'id':123, 'placeholder':'SPECIAL THING'}]
        #specials = clue['specials'] 
        specials = clue_db[3]
        print(specials == None)
        return render_template('qr_get.html', clue=clue, special=specials, show_image=show_image)


@app.route("/qr_f/<qr_hashed>", methods=["GET", "POST"])
def qr_submit_form(qr_hashed):
    table = build_rain_table()

    print(request)

    if 'file' not in request.files:
        answer = request.form['answer']
        print('No file part')
    else:
        answer = 'photo'
        file = request.files['file']
        # if user does not select file, browser also
        # submit a empty part without filename
        if file.filename == '':
            print('No selected file')
            return abort(404)

        if file and allowed_file(file.filename):
            filename = 'qr_'+str(table[qr_hashed])+'_'+request.form['user']
            save_file = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(save_file)

    print('QR HASGED: ' + str( table[qr_hashed]))
    response = insertAnswer(answer, table[qr_hashed], request.form['user'], request.form['pass'])
    if(response == 'Bad Password'):
        print('Got a Bad Pass')
        return 'Incorrect Password or Login, please try again'
    if(response == 0):
        return redirect(url_for('hello_world'))
    else:
        return abort(404)
    
#/QR

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS



@app.before_request
def load_users():
    if current_user.is_authenticated:
        g.user = current_user.get_id() # return username in get_id()
    else:
        g.user = 'None' # or 'some fake value', whatever


def main_page():
    teams_scores = getTeamsScore() 
    
    name = None
    if(g.user != 'None'):
        name = g.user.name

    return render_template('index.html', user=g.user, teams_scores=sorted(teams_scores.items(), key=lambda x: x[1], reverse=True), clues=ansforteam(name))


@app.route('/')
def hello_world():
    return main_page()




'''
{'a8656e9c0687561e85c1f723eb111b6f': 0, '03ecf189a20280455a8308ff309bfd88': 1, 'd49f65ea11e24b1abe027871d2761bc8': 2, 'd17dbaba2f81014be4c50f0b08d32afe': 3, '2d6beea5c3eb2606c70cb42983968782': 4, 'de38a6fe281c908ccaf377f5a321b7ac': 5, 'ee07c88fe652914a39f0c57ca649c47e': 6, 'a5e742d0c710bdfb2c11c0142aa0fe59': 7, '9b1ef7efa1f385e794babafca8c57754': 8, '1abc003ce69c65239be68a6a0dbb8394': 9, '7b84cd569cd7eeaf23e96c874661a15d': 10, '860a7b64a585de3713a0f6f8eaca239d': 11, '3bea2fe6fadb9b7e20486edb14b63364': 12, 'bf78a93171a7a133f180e678dc31db12': 13, 'c979c6695253f38a15efd271d2f72f96': 14, '1885abfcf78715f139eaf43691a57d5f': 15, 'f075d835d10d80fb352cf26c4ec42bb8': 16, 'e4aabecd2aa1b8cc5d79c4da0591bee2': 17, 'dfb2d73a35226cc5cd81ba6880ab416b': 18, '3db30cd9ed59ac837ff6cc308d476f62': 19, '92a989d08bf9284ac616cd3e48a3a421': 20, '6d19ba337f300260077e30f8e2f46e4f': 21, 'a605cf49c77ceed7d9ba4db347d29431': 22, 'd6ecf82542da20a4f081e3ce18d3b005': 23, 'bd895a7faaebee011ae901ac964c2cae': 24}

'''
