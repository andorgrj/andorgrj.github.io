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
COALESCE - első olyan értéket adja vissza ami nem null

DISTINCT    - SELECT different values 

Name as 		- más nevet lehet neki adni
<> 				- nem egyenlő
!=				- nem egyenlő
>=				- nagyobb vagy egyenlő
<=				- kisebb vagy egyenlő
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
	WHERE P.Name LIKE '%Washer%' OR P.Name = 'Flat Washer%';
	WHERE P.Name LIKE '%Washer%'                    -> %-al adott szövegrészre kereshetünk rá LIKE kell elé, nem egyenlőségjellel
	WHERE P.Name LIKE '%Washer%' 
	WHERE P.Name LIKE '_lat Washer%'

SELECT *
	FROM Production.Product as P
	WHERE P.SellStartDate >= '2010-01-01T00:00:00.000'  -> szabványos formátuma az időlekérdezésnek ISO
	AND P.SellStartDate <= '2012-12-31T23:59:59.000';

SELECT *
	FROM Production.Product as P
	WHERE YEAR(P.SellStartDate) = 2013;
	WHERE MONTH(P.SellStartDate) = 5;
	WHERE DAY(P.SellStartDate) = 30;

SELECT P.Name, P.Color
	FROM Production.Product as P
	WHERE P.Color = 'Red' OR P.Color = 'Black';
	WHERE P.Color IN ('Red', 'Black', 'Green');   -> több szín felsorolása

SELECT P.Name, P.Color, P.ListPrice
	FROM Production.Product as P
	WHERE P.Color IN ('Red','Black');
	AND P.ListPrice BETWEEN 1000 AND 2000;


SELECT P.Name, P.Color
	FROM Production.Product as P
	WHERE P.Color = 'Red';

WHERE P.Color = 'Red' OR P.Color <> 'Red'

WHERE P.Color IS NULL; 						- nullás sorokat adja vissza
WHERE P.Color IS NOT NULL; 					- nem nullás sorokat adja vissza

SELECT P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue 
	FROM Production.Product P
	WHERE P.ListPrice - P.StandardCost > 1000
	ORDER BY Revenue DESC;

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

SELECT P.SalesOrderID, P.DueDate, P.CustomerID, P.TotalDue
	FROM Sales.SalesOrderHeader P
	WHERE P.DueDate >= '20130101' AND P.DueDate < '20130401';