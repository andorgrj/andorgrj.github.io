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

SELECT ET.*, MT.Diagnozis FROM Elsotabla ET
JOIN Masodiktabla MT ON ET.MasodiktablaID = MT.MasodiktablaID


INSERT INTO Elsotabla (Nev,Suly,Ido)
	VALUES	('Probababa3','28.7','2022-01-10'),
			('Probababa1','23.5','2021-11-30'),
			('Probababa2','31.2','2021-12-29')


SELECT * FROM Elsotabla -- ORDER BY ElsotablaID DESC

INSERT INTO Masodiktabla VALUES ('normális'),('sovány'),('tulsúlyos')

SELECT * FROM Masodiktabla

UPDATE Elsotabla SET MasodiktablaID = 1 WHERE ElsotablaID = 1
UPDATE Elsotabla SET MasodiktablaID = 2 WHERE ElsotablaID = 2
UPDATE Elsotabla SET MasodiktablaID = 3 WHERE ElsotablaID = 3

SELECT * FROM Elsotabla