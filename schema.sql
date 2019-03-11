pragma foreign_keys = off;

drop table if exists Team;
drop table if exists Clue;
drop table if exists Answer;

create table Team
(
	idTeam integer primary key,
	name text unique not null,
	pass text unique not null
);

create table Clue
(
	idClue integer primary key,
	clue text not null,
	correct text not null
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

INSERT INTO Clue (clue, correct) VALUES('Onde esta o X?', 'donabea;bea' );
INSERT INTO Clue (clue, correct) VALUES('Decifra isto: wieofwje', 'xau' );
INSERT INTO Clue (clue, correct) VALUES('Quem é aquela pessoa?', 'vidal' );
INSERT INTO Clue (clue, correct) VALUES('27+23', '50' );


INSERT INTO Answer (answ, idTeam, idClue) VALUES('donabea', 1, 1 );
INSERT INTO Answer (answ, idTeam, idClue) VALUES('auditorio', 2, 1 );
INSERT INTO Answer (answ, idTeam, idClue) VALUES('naosei', 1, 2 );

