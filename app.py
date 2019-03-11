from flask import Flask, request, g
import sqlite3
import os

app = Flask(__name__, static_url_path='')
app.config.from_object(os.environ['APP_SETTINGS'])


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

def getAllTeams():
    cur = get_db().cursor()
    teams = []
    for user in query_db('select name, pass from Team'):
        teams.append(user)
    return teams

@app.route('/')
def hello_world():
    print( getAllTeams() )
    return app.send_static_file('index.html')
