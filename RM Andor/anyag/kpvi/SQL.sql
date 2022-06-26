


----------------------

SQL 1. feladat

SELECT PM.NAME AS "Termékmodell neve", P.PRODUCTID AS "Termék azonosítója", P.NAME AS "Termék neve", P.LISTPRICE AS "Termék listaára"
    FROM Production.Product P
    JOIN Production.ProductModel PM ON P.ProductModelID = PM.ProductModelID
    WHERE PM.NAME LIKE '%road%'
    ORDER BY PM.NAME, P.NAME


SQL 3. feladat

SELECT P.ProductID "Termék kódja", P.Name "Termék neve", 
    MIN (PCPCOD.UnitPrice) "Legalacsonyabb egységár", MAX (PCPCOD.UnitPrice) "Legmagasabb egységár", AVG (PCPCOD.UnitPrice) "Átlag egységár",
    AVG (PCPCOD.UnitPrice) - MIN (PCPCOD.UnitPrice) "Különbözet"
  FROM Production.Product P
  JOIN Purchasing.PurchaseOrderDetail PCPCOD ON P.ProductID = PCPCOD.ProductID
  GROUP BY P.ProductID, P.Name
  ORDER BY P.Name

----------------------------------

EZ A SAJÁT!!!!képesítő!!

CREATE DATABASE Storage
ON
( NAME = Storage_data,
    FILENAME = 'C:\Storage_data - Storage_data.mdf',
    SIZE = 64MB)
LOG ON
( NAME = Storage_log,
    FILENAME = 'C:\Storage_log - Storage_log.ldf',
    SIZE = 24MB) ;
GO
USE Storage

ALTER DATABASE [Storage] SET RECOVERY SIMPLE ;

CREATE TABLE Polc (

    PK_PolcID INT IDENTITY(1,1)  PRIMARY KEY,

    Nev VARCHAR(50)
);


CREATE TABLE Termek (

    PK_TermekID INT IDENTITY(1,1) PRIMARY KEY,

    Nev VARCHAR(50)
);

GO

INSERT INTO Polc (Nev) VALUES ('A1')
INSERT INTO Polc (Nev) VALUES ('A2')
INSERT INTO Polc (Nev) VALUES ('A3')

GO


INSERT INTO Termek (Nev) VALUES ('Szőnyeg')
INSERT INTO Termek (Nev) VALUES ('Lavor')
INSERT INTO Termek (Nev) VALUES ('Csavarhúzó')
INSERT INTO Termek (Nev) VALUES ('Porszívó')

GO


ALTER TABLE Polc

ADD TermekId INT NULL

GO

ALTER TABLE Polc

ADD CONSTRAINT FK_Termek_id FOREIGN KEY (TermekId)

    REFERENCES Termek(id);

GO

UPDATE Termek 

SET TermekId = 1 WHERE id = 4


UPDATE Termek 

SET TermekId = 2 WHERE id = 3


UPDATE Termek

SET TermekId = 3 WHERE id = 2


UPDATE Orszag 

SET TermekId = 4 WHERE id = 1
GO

SELECT T.NEV "Termék", P.NEV "Polc név" FROM Termek

LEFT JOIN Polc on P.id = TermekId = PK_PolcID
GO


CREATE LOGIN raktaros 

   WITH PASSWORD = 'Password1337!'
GO

CREATE USER raktaros FOR LOGIN Storage
GO

ALTER ROLE db_datareader ADD MEMBER Storage
GO

USE master
GO

USE master;  
ALTER DATABASE Storage SET RECOVERY FULL;  
GO  
  
BACKUP DATABASE Storage  
  TO DISK = 'C:\DBBackup\Storage_save.bak'   
  WITH FORMAT;  
GO  

DROP LOGIN raktaros
GO

DROP DATABASE Storage
GO