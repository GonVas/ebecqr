pragma foreign_keys = off;

drop table if exists Team;
drop table if exists Clue;
drop table if exists Answer;

create table Team
(
	idTeam integer primary key,
	name text unique not null,
	pass text unique not null,

	admin integer default 0
);

create table Clue
(
	idClue integer primary key,
	clue text not null,
	correct text not null,
	special text
);

create table Answer
(
	idAnswer integer primary key,

	answ text not null,

	valid integer default 0,

	idTeam integer not null,
	idClue integer not null,

	Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,

	constraint clue_fkey foreign key (idClue) references Clue,
	constraint team_fkey foreign key (idTeam) references Team

);


#seeding with some examples

#INSERT INTO Team (name, pass) VALUES('Equipa top', 'ola' );
#INSERT INTO Team (name, pass) VALUES('Genericos', 'ola1' );
#INSERT INTO Team (name, pass) VALUES('Maus', 'ola2' );


INSERT INTO Team (name, pass) VALUES('our neck his back', 'crack');
INSERT INTO Team (name, pass) VALUES('Outlanders', 'caixote');
INSERT INTO Team (name, pass) VALUES('Electricae', 'eletro');
INSERT INTO Team (name, pass) VALUES('Name this Group', 'quadro');
INSERT INTO Team (name, pass) VALUES('Queria TD', 'ripcs');
INSERT INTO Team (name, pass) VALUES('Os Socios', 'computador');
INSERT INTO Team (name, pass) VALUES('Problem Solvers', 'solvingp');
INSERT INTO Team (name, pass) VALUES('Cheese wolves', 'caes');
INSERT INTO Team (name, pass) VALUES('NaLutaPor1CT', 'credito');
INSERT INTO Team (name, pass) VALUES('Ena Pa 1999', '19145');
INSERT INTO Team (name, pass) VALUES('La Matilha', 'buelobos');
INSERT INTO Team (name, pass) VALUES('One Big HOAX', 'insidejob');
INSERT INTO Team (name, pass) VALUES('DexterityTeam', 'destros');
INSERT INTO Team (name, pass) VALUES('Capisce', 'casaco');
INSERT INTO Team (name, pass) VALUES('Enlighten', '15821');
INSERT INTO Team (name, pass) VALUES('MakeItWorth', 'milhoes');

#TD
INSERT INTO Team (name, pass) VALUES('PUROS', 'pureza');
INSERT INTO Team (name, pass) VALUES('Blank', 'vazio');
INSERT INTO Team (name, pass) VALUES('New Folder', 'mkdir');
INSERT INTO Team (name, pass) VALUES('MecGyvers', 'engenhosos');
INSERT INTO Team (name, pass) VALUES('Os Gordos Overseas', 'magros');
INSERT INTO Team (name, pass) VALUES('Nonsense', 'livros'); 
INSERT INTO Team (name, pass) VALUES('Mini-Natas', 'pasteis');
INSERT INTO Team (name, pass) VALUES('The Widlarizers', 'bosque');
INSERT INTO Team (name, pass) VALUES('Gibraltar', 'espanha');
INSERT INTO Team (name, pass) VALUES('ElJuego98', 'caderno');
INSERT INTO Team (name, pass) VALUES('3mais1', 'daquatro');
INSERT INTO Team (name, pass) VALUES('Os Marretas', 'fitacola');
INSERT INTO Team (name, pass) VALUES('Mecos', 'banho');
INSERT INTO Team (name, pass) VALUES('EleCtro TEAM', 'jardim');
INSERT INTO Team (name, pass) VALUES('Walky Talky', 'whatsapp');
INSERT INTO Team (name, pass) VALUES('Circuito Aberto', 'fechado');
INSERT INTO Team (name, pass) VALUES('Big Mec', 'whopper');
INSERT INTO Team (name, pass) VALUES('Robotic Generation', 'robots');
INSERT INTO Team (name, pass) VALUES('We Matter', 'cadeira');
INSERT INTO Team (name, pass) VALUES('Ebelc', 'carta');
INSERT INTO Team (name, pass) VALUES('Processo', 'nomeenorme');
INSERT INTO Team (name, pass) VALUES('Hackers at Porto', 'hackers');
INSERT INTO Team (name, pass) VALUES('Entalpia de Pavor', 'medoo');
INSERT INTO Team (name, pass) VALUES('Carro Vassoura', 'lixeiro');
INSERT INTO Team (name, pass) VALUES('Televida', 'parede'); 
INSERT INTO Team (name, pass) VALUES('Fundo do Barril 2', 'nortada');
INSERT INTO Team (name, pass) VALUES('Jaime', 'jaimejaime');
INSERT INTO Team (name, pass) VALUES('Turtle Light', 'crocodilo');
INSERT INTO Team (name, pass) VALUES('Glorious Basterds', 'janela');
INSERT INTO Team (name, pass) VALUES('Nosgenios', 'acentos');
INSERT INTO Team (name, pass) VALUES('Massa com esparguete', 'arroz');
INSERT INTO Team (name, pass) VALUES('Os Porta Paletes',  'madeira');
INSERT INTO Team (name, pass) VALUES('Bambolinas', 'garrafa');
INSERT INTO Team (name, pass) VALUES('Udjiuva', 'vinho');
INSERT INTO Team (name, pass) VALUES('HeadMasters', 'sudo');
INSERT INTO Team (name, pass) VALUES('ViTec', 'random');
INSERT INTO Team (name, pass) VALUES('La Div', 'modulo');
INSERT INTO Team (name, pass) VALUES('Confia Bro', 'confes');
INSERT INTO Team (name, pass) VALUES('Sherlock Ohms', 'resistencia');
INSERT INTO Team (name, pass) VALUES('RIP Super2000', 'mbway');


INSERT INTO Clue (clue, correct) VALUES('Quantos anos tem a Universidade do Porto (numero de anos)', '107;107 anos');
INSERT INTO Clue (clue, correct) VALUES('Quantas edições da EBEC já existiram no Porto?', '10' );
INSERT INTO Clue (clue, correct, special) VALUES('Como é que cortas um bolo cilíndrico em 8 fatias iguais apenas com 3 cortes? Faz um desenho numa folha de papel e submete-o.', 'vidal', 'image');
INSERT INTO Clue (clue, correct, special) VALUES('Resolve este puzzle e submete a captura de ecrã no código QR ','50', 'image' );
INSERT INTO Clue (clue, correct) VALUES('h jhtpuov kl abypt. ceasar.jpg', 'A caminho de Turim' );
INSERT INTO Clue (clue, correct) VALUES('Qual a experiência da Celfocus? ', 'Digital Transformation;Fixed-mobile convergence;digital TV;one net;mobile office;oss offer;digital employee portal;analytics' );
INSERT INTO Clue (clue, correct) VALUES('Quais são os os domains of expertise da Celfocus', 'BSS;OSS IoT;Unnified Comms;Digital TV' );

INSERT INTO Answer (answ, idTeam, idClue) VALUES('donabea', 1, 1 );
INSERT INTO Answer (answ, idTeam, idClue) VALUES('auditorio', 2, 1 );
INSERT INTO Answer (answ, idTeam, idClue) VALUES('naosei', 1, 2 );



INSERT INTO Team (name, pass, admin) VALUES('admin', 'ebecadmin2019', 1);


########################################################
#   #TEAM               #LOGIN             #PASS       #
########################################################

#CS
#Our neck, his back | our neck his back | crack
#Outlanders |  Outlanders | caixote
#Electricae | Electricae | eletro
#Name this Group | Name this Group | quadro
#Queria TD | Queria TD | ripcs
#Os Sócios | Os Socios | computador
#Problem Solvers | Problem Solvers | solvingp
#Cheese wolves | Cheese wolves | caes
#NaLutaPor1CT | NaLutaPor1CT | credito
#Ena Pá 1999 | Ena Pa 1999 | 19145
#La Matilha | La Matilha | buelobos
#One big HOAX | One Big HOAX | insidejob
#DexterityTeam | DexterityTeam | destros
#Capisce | Capisce | casaco
#Enlighten | Enlighten | 15821
#MakeItWorth | MakeItWorth | milhoes

#TD
#PUROS | PUROS | pureza
#* Blank * | Blank | vazio
#New Folder | New Folder | mkdir
#MecGyvers | MecGyvers | engenhosos
#Os Gordos: Overseas | Os Gordos Overseas | magros
#Nonsense | Nonsense | livros 
#Mini-Natas | Mini-Natas | pasteis
#The Widlarizers | The Widlarizers | bosque
#Gibraltar | Gibraltar | espanha
#ElJuego98 | ElJuego98 | caderno
#3+1 | 3mais1 | daquatro
#Os Marretas | Os Marretas | fitacola
#Mec'os | Mecos | banho
#EleCtro TEAM | EleCtro TEAM | jardim
#Walky Talky | Walky Talky | whatsapp
#Circuito Aberto | Circuito Aberto | fechado
#Big Mec | Big Mec | whopper
#Robotic Generation | Robotic Generation | robots
#We Matter | We Matter | cadeira
#Ebelc | Ebelc | carta
#Processo estocástico ergódico | Processo | nomeenorme
#Hackers at Porto | Hackers at Porto | hackers
#Entalpia de Pavor | Entalpia de Pavor | medoo
#Carro Vassoura | Carro Vassoura | lixeiro
#Televida | Televida | parede 
#Fundo do Barril 2 | Fundo do Barril 2 | nortada
#Jaime | Jaime | jaimejaime
#Turtle Light | Turtle Light | crocodilo
#Glorious Basterds | Glorious Basterds | janela
#Nosgênios | Nosgenios | acentos
#Massa com esparguete | Massa com esparguete | arroz
#Os Porta Paletes | Os Porta Paletes | madeira
#Bambolinas | Bambolinas | garrafa
#Udjiuva | Udjiuva | vinho
#HeadMasters | HeadMasters | sudo
#ViTec | ViTec | random
#La Div | La Div | modulo
#Confia Bro | Confia Bro | confes
#Sherlock Ohms | Sherlock Ohms | resistencia
#RIP Super2000 | RIP Super2000 | mbway

