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

	constraint clue_fkey foreign key (idClue) references Clue,
	constraint team_fkey foreign key (idTeam) references Team

);


#seeding with some examples

INSERT INTO Team (name, pass) VALUES('Equipa top', 'ola' );
INSERT INTO Team (name, pass) VALUES('Genericos', 'ola1' );
INSERT INTO Team (name, pass) VALUES('Maus', 'ola2' );

INSERT INTO Clue (clue, correct) VALUES('Quais as empresas que estiveram presentes na sessão de networking?', 'Claranet;Agap2IT;Celfocus' );
INSERT INTO Clue (clue, correct) VALUES('Quantas edições da EBEC já existiram no Porto?', '10' );
INSERT INTO Clue (clue, correct, special) VALUES('Como é que cortas um bolo cilíndrico em 8 fatias iguais apenas com 3 cortes? Faz um desenho numa folha de papel e submete-o.', 'vidal', 'image');
INSERT INTO Clue (clue, correct) VALUES('Resolve este puzzle e submete a captura de ecrã no código QR ','50' );
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

