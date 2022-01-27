-- DB l�trehoz�sa
CREATE DATABASE DemoDB 

-- DB t�rl�s
-- DROP DATABASE DemoDB

-- DB v�ltoztat�s
-- ALTER DATABASE DemoDB

USE DemoDB
-- -------------------------------------------
-- alap
CREATE TABLE Elsotabla (
	ElsotablaID int,
	Nev nvarchar(20),
	Suly float,
	Ido Datetime
)

DROP TABLE Elsotabla

-- Megszor�t�sok
-- NOT NULL, DEFAULT, UNIQUE, CHECK

CREATE TABLE Elsotabla (
	ElsotablaID int not null,
	Nev nvarchar(20),
	Suly float,
	Ido Datetime,
	Egyediertek int UNIQUE,
	Alap int DEFAULT 20,
	Ertek int,
	CHECK (Ertek > 5),
	CHECK (YEAR(Ido) > 1900)
)

-- --------------------------------------------
-- t�bla els�dleges kulccsal
CREATE TABLE Elsotabla (
	ElsotablaID int,
	Nev nvarchar(20),
	Suly float,
	Ido Datetime

	CONSTRAINT PK_Elsotabla PRIMARY KEY (ElsotablaID)	
)
-- -----------------------------------------------------


-- ------------------------------------------------
-- t�bla automatikusan n�vekv� els�dleges kulccsal
CREATE TABLE Elsotabla (
	ElsotablaID int IDENTITY (1000,1), -- az identity használatával növeli a kulcsot, (1,1 jelenti, hogy mennyitől kezdődik a számozás ás mennyivel nő)
	Nev nvarchar(20),
	Suly float,
	Ido Datetime

	CONSTRAINT PK_Elsotabla PRIMARY KEY (ElsotablaID)	
)

CREATE TABLE Elsotabla (
	ElsotablaID int IDENTITY (1,1),
	Nev nvarchar(20),
	Suly float,
	Ido Datetime

	CONSTRAINT PK_Elsotabla PRIMARY KEY (ElsotablaID)	
)

-- t�bl�k �sszekapcsol�sa idegen kulcsokkal 1:N kapcsolat

CREATE TABLE Elsotabla (
	ElsotablaID int IDENTITY (1,1),
	Nev nvarchar(20),
	Suly float,
	Ido Datetime,
	MasodiktablaID int

	CONSTRAINT PK_Elsotabla PRIMARY KEY (ElsotablaID)	
)

CREATE TABLE Masodiktabla (
	MasodiktablaID int IDENTITY (1,1),
	Diagnozis nvarchar(20),
	
	CONSTRAINT PK_Masodiktabla PRIMARY KEY (MasodiktablaID)	
)

ALTER TABLE Elsotabla
	ADD CONSTRAINT FK_Elsotabla_Masodiktabla 
		FOREIGN KEY (MasodiktablaID) REFERENCES Masodiktabla (MasodiktablaID)

-- ----------------------------------------------------------------------------

CREATE TABLE Elsotabla (
	ElsotablaID int IDENTITY (1,1),
	Nev nvarchar(20),
	Suly float,
	Ido Datetime

	CONSTRAINT PK_Elsotabla PRIMARY KEY (ElsotablaID)	
)

INSERT INTO Elsotabla (Nev,Suly,Ido)
	VALUES	('Probababa3','28.7','2022-01-10'),
			('Probababa1','23.5','2021-11-30'),
			('Probababa2','31.2','2021-12-29')

CREATE TABLE Masodiktabla (
	MasodiktablaID int IDENTITY (1,1),
	Etelek nvarchar (20)

	CONSTRAINT PK_Masodiktabla PRIMARY KEY (MasodiktablaID)
)
INSERT INTO Masodiktabla VALUES ('Brokkoli'), ('Spen�t'), ('Gumicukor')


CREATE TABLE NMTabla (
	ElsotablaID int,
	MasodiktablaID int,
)

ALTER TABLE NMTabla
ADD CONSTRAINT FK_Elsotabla_NMTabla FOREIGN KEY (ElsotablaID) REFERENCES Elsotabla (ElsotablaID),
	CONSTRAINT FK_Masodiktabl_NMTabla FOREIGN KEY (MasodiktablaID) REFERENCES Masodiktabla (MasodiktablaID)


INSERT INTO NMTabla VALUES
	(1,2),(1,3),(2,1),(2,3),(3,1),(3,2),(3,3)

Select * from Elsotabla
Select * from Masodiktabla

SELECT ET.*, MT.Etelek FROM Elsotabla ET
JOIN NMTabla NMT ON ET.ElsotablaID = NMT.ElsotablaID
JOIN Masodiktabla MT ON NMT.MasodiktablaID = MT.MasodiktablaID
WHERE ET.Nev = 'Probababa1'

-- -----------------------------------------------------------------------------

SELECT ET.*, MT.Diagnozis FROM Elsotabla ET
JOIN Masodiktabla MT ON ET.MasodiktablaID = MT.MasodiktablaID


INSERT INTO Elsotabla (ElsotablaID,Nev,Suly,Ido)
	VALUES (1,'Probababa1','23.4','2021-11-30')

INSERT INTO Elsotabla (Nev,Suly,Ido)
	VALUES ('Probababa1','23.5','2021-11-30')

DELETE FROM Elsotabla WHERE ElsotablaID = 1000

INSERT INTO Elsotabla (Nev,Suly,Ido)
	VALUES	('Probababa4','33.2','2021-12-29')

INSERT INTO Elsotabla (Nev,Suly,Ido,MasodiktablaID)
	VALUES	('Probababa4','33.2','2021-12-29',1)

INSERT INTO Elsotabla (Nev,Suly,Ido)
	VALUES	('Probababa3','28.7','2022-01-10'),
			('Probababa1','23.5','2021-11-30'),
			('Probababa2','31.2','2021-12-29')

INSERT INTO Elsotabla (ElsotablaID,Nev,Suly,Ido)
	VALUES (1002,'Probababa1','23.4','2021-11-30')

INSERT INTO Elsotabla VALUES (null, null, null)

SELECT * FROM Elsotabla -- ORDER BY ElsotablaID DESC

INSERT INTO Masodiktabla VALUES ('norm�lis'),('sov�ny'),('tuls�lyos')

SELECT * FROM Masodiktabla

UPDATE Elsotabla SET MasodiktablaID = 1 WHERE ElsotablaID = 1
UPDATE Elsotabla SET MasodiktablaID = 2 WHERE ElsotablaID = 2
UPDATE Elsotabla SET MasodiktablaID = 3 WHERE ElsotablaID = 3

DROP TABLE Elsotabla, Masodiktabla

-- ---------------------------------
-- t�bla kapcsolat t�pusok
1:1 
1:N
N:1 
N:M - kapcsol�t�bl�t k�sz�t�nk hozz
-- ----------------------------------

CREATE TABLE NonNormalMovie (
	FilmTitle nvarchar(50),
	Actor nvarchar(200),
	Genre nvarchar(200)
)
INSERT INTO NonNormalMovie VALUES
('Rem�ny rabjai','Tim Robbins, Morgan Freeman','Dr�ma'),
('Nagy ugr�s','Tim Robbins, Paul Newman','Dr�ma, Vigj�t�k'),
('A nagy balh�','Paul Newman, Robert Redford','Dr�ma, V�gj�t�k, Krimi')

SELECT * FROM NonNormalMovie


Select NEWID()