USE ExamSajat
-- ------------------------------------------------------------------------------

-- 2. Feladat 
-- Adott az al�bbi nem normaliz�lt t�bla (NonNormalMovie)
-- Hozd 3. norm�l form�ba �s k�sz�tsd el a megfelel� t�bl�kat hozz�
-- Minden t�bl�n legyen els�dleges kulcs (Primary key), kiv�ve az esetleges kapocsol�t�bl�kon 
-- 12 pont
-- K�sz�tsd el az idegen kulcs (Foreign key) - els�dleges kulcs p�rokat (5 pont)
-- K�sz�tsd el a k�sz t�bl�k �sszekapcsolt lek�rdez�s�t (4 pont)
-- �sszesen: 20 pont

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

-- Jav�t�kulcs:
-- 2 pont - �szreveszi az N:M kapcsolatot �s kiemeli (Film - Actor)
-- 2 pont - �szreveszi az N:M kapcsolatot �s kiemeli (Film - Genre)
-- 1 pont/j� t�bla - Elk�sz�ti a t�bl�kat - t�bl�nk�nt 1 pont
-- 2 pont - A t�bl�kban van els�dleges kulcs
-- 5 pont - Elk�sz�ti az idegen kulcsokat
-- 4 pont - Elk�szit� az �sszekapcsolt lek�rdez�st

-- Megold�s adatfelt�lt�ssel

CREATE TABLE Film (
	FilmID INT IDENTITY(1,1),
	Title NVARCHAR(50),
	CONSTRAINT PK_FilmID PRIMARY KEY (FilmID)
)
INSERT INTO Film (Title) VALUES ('Rem�ny rabjai'),('Nagy ugr�s'),('A nagy balh�')

CREATE TABLE Actor (
	ActorID INT IDENTITY(1,1),
	Name NVARCHAR(50),
	CONSTRAINT PK_ActorID PRIMARY KEY (ActorID)
)
INSERT INTO Actor (Name) VALUES ('Tim Robbins'),('Morgan Freeman'),('Paul Newman'),('Robert Redford')

CREATE TABLE Genre (
	GenreID INT IDENTITY(1,1),
	Genre NVARCHAR(20),
	CONSTRAINT PK_GenreID PRIMARY KEY (GenreID)
)
INSERT INTO Genre (Genre) VALUES ('Dr�ma'),('V�gj�t�k'),('Krimi')

CREATE TABLE FilmGenre (
	FilmID INT,
	GenreID INT
)
INSERT INTO FilmGenre VALUES (1,1),(2,1),(2,2),(3,1),(3,2),(3,3)

CREATE TABLE FilmActor (
	FilmID INT,
	ActorID INT
)

INSERT INTO FilmActor VALUES (1,1),(1,2),(2,1),(2,3),(3,3),(3,4)
Delete from FilmActor 

ALTER TABLE FilmGenre 
	ADD CONSTRAINT FK_Genre_FilmGenre FOREIGN KEY (GenreID) REFERENCES Genre (GenreID),
		CONSTRAINT FK_Film_FilmGenre FOREIGN KEY (FilmID) REFERENCES Film (FilmID)

ALTER TABLE FilmActor 
	ADD CONSTRAINT FK_Actor_FilmActor FOREIGN KEY (ActorID) REFERENCES Actor (ActorID),
		CONSTRAINT FK_Film_FilmActor FOREIGN KEY (FilmID) REFERENCES Film (FilmID)

SELECT F.Title, A.Name, G.Genre FROM Film F
INNER JOIN FilmActor FA ON F.FilmID = FA.FilmID
INNER JOIN Actor A ON A.ActorID = FA.ActorID
INNER JOIN FilmGenre FG ON F.FilmID = FG.FilmID
INNER JOIN Genre G ON G.GenreID = FG.GenreID

-- DROP TABLE FilmActor
-- DROP TABLE FilmGenre
-- DROP TABLE Genre
-- DROP TABLE Film
-- DROP TABLE Actor
-- DROP TABLE NonNormalMovie



