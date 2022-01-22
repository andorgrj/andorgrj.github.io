-- A logikai v�grehajt�si sorrendb�l fakad� k�vetkezm�nyek: 
-- A SELECT k�s�bb hozza l�tre a Revenue aliast, ez�rt nem lehet kor�bban a WHERE-ben hivatkozni r�:
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE Revenue > 1000

-- A korrekt szintaxis:
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE P.ListPrice - P.StandardCost > 1000

-- Ha le akarjuk rendezni az eredm�nyt a j�vedelem mez�re, akkor az ORDER BY-ban m�r felhaszn�lhatjuk a Revenue mez�t,
-- mert az ORDER BY a SELECT ut�n j�n logikailag
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE P.ListPrice - P.StandardCost > 1000
ORDER BY Revenue DESC

-- V�ltoz� felt�lt� SELECT
DECLARE @RedProducts varchar(1000) = ''
SELECT @RedProducts += ', ' + CAST(P.ProductID AS varchar(10))
FROM Production.Product P
WHERE P.Color = 'Red'
SET @RedProducts = STUFF(@RedProducts,1,2,'')
SELECT @RedProducts

-- 2017-es korszer�s�tett megval�s�t�s
DECLARE @RedProducts2 varchar(1000) = ''
SELECT STRING_AGG(P.ProductID, ',')
FROM Production.Product P
WHERE P.Color = 'Red'

