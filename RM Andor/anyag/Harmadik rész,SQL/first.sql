SELECT - extracts data from a database
UPDATE - updates data in a database
DELETE - deletes data from a database
INSERT INTO - inserts new data into a database
CREATE DATABASE - creates a new database
ALTER DATABASE - modifies a database
CREATE TABLE - creates a new table
ALTER TABLE - modifies a table
DROP TABLE - deletes a table
CREATE INDEX - creates an index (search key)
DROP INDEX - deletes an index

DISTINCT    - SELECT different values 

---------------------------------------------------------------------

USE Demo

DROP TABLE TableDemo2

CREATE TABLE DemoTabla2 (
	Sorszam int
)

USE AdventureWorks2019
SELECT * FROM [Production].[Product]

SELECT *
FROM Production.Product as P					-> as P a táblázat hosszú neve rövidítve
WHERE P.Color = 'RED' OR P.Color = 'Black';
WHERE (P.Color = 'RED' OR P.Color = 'Black') AND P.ListPrice > 1000;
WHERE P.Name LIKE '%Washer%' OR P.Name = 'Flat Washer 2';

SELECT *
FROM Production.Product as P
WHERE P.SellStartDate >= '2010-01-01T00:00:00.000'  -> szabványos formátuma az időlekérdezésnek
AND P.SellStartDate <= '2012-12-31T23:59:59.000';

SELECT *
FROM Production.Product as P
WHERE YEAR(P.SellStartDate) = 2013;
WHERE MONTH(P.SellStartDate) = 5;
WHERE DAY(P.SellStartDate) = 30;

SELECT P.Name, P.Color
FROM Production.Product as P
WHERE P.Color = 'Red' OR P.Color = 'Black';
több szín felsorolása
WHERE P.Color IN ('Red', 'Black', 'Green');

SELECT P.Name, P.Color, P.ListPrice
FROM Production.Product as P
WHERE P.Color IN ('Red','Black');
AND P.ListPrice BETWEEN 1000 AND 2000;

--------------------------------------------------------------------------------

SELECT P.Name, P.Color
FROM Production.Product as P
WHERE P.Color <> 'Red';

SELECT P.Name, P.Color
FROM Production.Product as P
WHERE P.Color = 'Red' OR P.Color = 'Black';
több szín felsorolása
WHERE P.Color IN ('Red', 'Black', 'Green');

SELECT P.Name, P.Color, P.ListPrice
FROM Production.Product as P
WHERE P.Color IN ('Red','Black');
	AND P.ListPrice BETWEEN 1000 AND 2000;

----------------------------------------------------------------------------------