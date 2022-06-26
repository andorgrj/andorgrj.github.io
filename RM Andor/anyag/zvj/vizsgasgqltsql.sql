CREATE DATABASE World COLLATE Hungarian_CI_AI 

USE World

CREATE TABLE Kontinens (

    id INT IDENTITY(1,1)  PRIMARY KEY,

    Nev VARCHAR(100)

);


CREATE TABLE Orszag (

    id INT IDENTITY(1,1) PRIMARY KEY,

    Nev VARCHAR(100)

);

GO


INSERT INTO Kontinens (Nev) VALUES ('Afrika')

INSERT INTO Kontinens (Nev) VALUES ('Amerika')

INSERT INTO Kontinens (Nev) VALUES ('Antarktisz')

INSERT INTO Kontinens (Nev) VALUES ('Arktisz')

INSERT INTO Kontinens (Nev) VALUES ('Ausztrália')

INSERT INTO Kontinens (Nev) VALUES ('Ázsia')

INSERT INTO Kontinens (Nev) VALUES ('Európa')

GO


INSERT INTO Orszag (Nev) VALUES ('Kína')

INSERT INTO Orszag (Nev) VALUES ('Mexikó')

INSERT INTO Orszag (Nev) VALUES ('India')

INSERT INTO Orszag (Nev) VALUES ('Belgium')

GO


ALTER TABLE Orszag

ADD KontinensId INT NULL

GO

ALTER TABLE Orszag

ADD CONSTRAINT FK_Kontinens_id FOREIGN KEY (KontinensId)

    REFERENCES Kontinens(id);

GO

UPDATE Orszag 

SET KontinensId = 2 WHERE id = 2


UPDATE Orszag 

SET KontinensId = 5 WHERE id = 1


UPDATE Orszag 

SET KontinensId = 5 WHERE id = 3


UPDATE Orszag 

SET KontinensId = 6 WHERE id = 4
GO

SELECT k.Nev "Kontinens", o.Nev "Ország név" FROM Kontinens k

LEFT JOIN Orszag o on k.id = o.KontinensId
GO

CREATE LOGIN Worldreader 

   WITH PASSWORD = 'Password987!'
GO

CREATE USER Worldreader FOR LOGIN Worldreader
GO

ALTER ROLE db_datareader ADD MEMBER Worldreader
GO

USE master
GO

DROP LOGIN Worldreader
GO

DROP DATABASE World
GO

-------------------------------------------------------------------------------------------

T-SQL adminisztrációs feladat
Készítsd el az alábbi feladat T-SQL scriptjét. A script sorról-sorra futatva:
- a. Létrehoz egy adatbázist 'World' néven, Hungarian_CI_AI nyelvi beállítással, és aztán használja is 2 pont
- b. Hozdd létre az alábbi táblákat 3 pont
Kontinens: ('Afrika'),('Amerika'),('Antarktisz'),('Arktisz'),('Ausztrália'),('Ázsia'),('Európa')
Orszag: ('Kína'),('Mexikó'),('India'),('Belgium')
amellyek tartalmaznak egy egyedi azonosítót mint elsődleges kulcs és egy Nev 100 karakter adatot.
- c. Módosítsd úgy a táblákat, hogy létrehozol közöttük egy kapcsolatot úgy, hogy 1 kontinenshez több ország is tarthozhat. 3 pont
- d. Készítsd el hozzá az összekapcsolt lekérdezést amelyben szerepel az kontinens neve és az ország neve úgy hogy azokat a kontinenseket is jelenítse meg a lekérdezés amelyhez nem tartozik ország 3 pont
- e. Hozz létre egy szerver logint 'Worldreader' néven 'Password987!' jelszóval 1 pont
- f. Hozz léte egy felhasználót az adatbázishoz ugyanazon a néven a loginból 1 pont
- g. Az új felhasználó csak olvasni tudja az adatbázist. 2 pont
- h. Készíts egy differneciális mentést az adatbázisról a 'C:\DBBackup' könyvtárba WorldBackup.bak fálba. 3 pont
- i. Töröld az adatbázist és a szerver logint 2 pont
Összesen 20 pont

-----------------------------------------------------------------------------------------

CREATE DATABASE pelda

on PRIMARY(
    name = data ,
    Filename = 'c:\database\pelda.mdf'
)

LOG on (
    NAME = log ,
    Filename = 'd:\database\b.ldf'
)
COLLATE Hungarian_CI_AS

