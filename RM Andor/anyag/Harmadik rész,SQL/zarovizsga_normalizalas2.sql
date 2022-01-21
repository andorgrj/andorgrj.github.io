USE ExamSajat
-- ------------------------------------------------------------------------------

-- 2. Feladat 
-- Adott az alábbi nem normalizált tábla (NonNormalMovie)
-- Hozd 3. normál formába és készítsd el a megfelelõ táblákat hozzá
-- Minden táblán legyen elsõdleges kulcs (Primary key), kivéve az esetleges kapocsolótáblákon 
-- 12 pont
-- Készítsd el az idegen kulcs (Foreign key) - elsõdleges kulcs párokat (5 pont)
-- Készítsd el a kész táblák összekapcsolt lekérdezését (4 pont)
-- Összesen: 20 pont

CREATE TABLE NonNormalMovie (
	FilmTitle nvarchar(50),
	Actor nvarchar(200),
	Genre nvarchar(200)
)
INSERT INTO NonNormalMovie VALUES
('Remény rabjai','Tim Robbins, Morgan Freeman','Dráma'),
('Nagy ugrás','Tim Robbins, Paul Newman','Dráma, Vigjáték'),
('A nagy balhé','Paul Newman, Robert Redford','Dráma, Vígjáték, Krimi')

SELECT * FROM NonNormalMovie

-- Javítókulcs:
-- 2 pont - Észreveszi az N:M kapcsolatot és kiemeli (Film - Actor)
-- 2 pont - Észreveszi az N:M kapcsolatot és kiemeli (Film - Genre)
-- 1 pont/jó tábla - Elkészíti a táblákat - táblánként 1 pont
-- 2 pont - A táblákban van elsõdleges kulcs
-- 5 pont - Elkészíti az idegen kulcsokat
-- 4 pont - Elkészití az összekapcsolt lekérdezést

-- Megoldás adatfeltöltéssel

CREATE TABLE Film (
	FilmID INT IDENTITY(1,1),
	Title NVARCHAR(50),
	CONSTRAINT PK_FilmID PRIMARY KEY (FilmID)
)
INSERT INTO Film (Title) VALUES ('Remény rabjai'),('Nagy ugrás'),('A nagy balhé')

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
INSERT INTO Genre (Genre) VALUES ('Dráma'),('Vígjáték'),('Krimi')

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



