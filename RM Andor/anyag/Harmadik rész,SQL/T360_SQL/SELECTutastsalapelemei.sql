-- A logikai v�grehajt�si sorrendb�l fakad� k�vetkezm�nyek: 
-- A SELECT k�s�bb hozza l�tre a Revenue aliast, ez�rt nem lehet kor�bban a WHERE-ben hivatkozni r�:
/*SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE Revenue > 1000*/

-- A korrekt szintaxis: listaár és standard költség közötti külömbség meghaladja az ezer dollárt
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE P.ListPrice - P.StandardCost > 1000

-- Ha le akarjuk rendezni az eredményt a jövedelem mezőre, akkor az ORDER BY-ban már felhasználhatjuk a Revenue mezőt,
-- mert az ORDER BY a SELECT után jön logikailag
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE P.ListPrice - P.StandardCost > 1000
ORDER BY Revenue DESC

-- Változó feltétel SELECT
DECLARE @RedProducts varchar(1000) = ''
SELECT @RedProducts += ', ' + CAST(P.ProductID AS varchar(10))
FROM Production.Product P
WHERE P.Color = 'Red'
SET @RedProducts = STUFF(@RedProducts,1,2,'')
SELECT @RedProducts

-- 2017-es korszerűsített megvalósítás
DECLARE @RedProducts2 varchar(1000) = ''
SELECT STRING_AGG(P.ProductID, ',')
FROM Production.Product P
WHERE P.Color = 'Red'

