SELECT SOH.CustomerID AS SCID, PE.BusinessEntityID AS BEID FROM Sales.SalesOrderHeader SOH
	LEFT JOIN Person.Person PE ON SOH.CustomerID = PE.BusinessEntityID

SELECT SOH.CustomerID AS ID FROM Sales.SalesOrderHeader SOH

INTERSECT
--UNION ALL

SELECT PE.BusinessEntityID AS ID FROM Person.Person PE
ORDER BY ID


-- A Production.Product tábla tartalma alapján add vissza a lehetséges színeket az alábbi feltételekkel:
SELECT Color From Production.Product

--  *        Ahol a Color üres, ott a 'No color' jelenjen meg.
SELECT COALESCE(PR.Color, 'No Color') FROM Production.Product AS PR GROUP BY PR.Color;


SELECT COALESCE(PR.Color, 'No Color') AS COLORS, COUNT(PR.ProductID) AS 'Number of Products' FROM Production.Product AS PR GROUP BY PR.Color;

SELECT PR.Color AS COLORS, COUNT(PR.ProductID) AS 'Number of Products' FROM Production.Product AS PR;

--  *        Legyen egy olyan sor is, aminek a tartalma 'All color'

SELECT 'All Color' Color
UNION ALL
SELECT COALESCE(Color, 'No Color') FROM Production.Product
ORDER BY Color

SELECT 'All colors' AS COLORS, COUNT(PR.ProductID) AS 'Number of Products' FROM Production.Product AS PR
UNION ALL
SELECT COALESCE(PR.Color, 'No Color') AS COLORS, COUNT(PR.ProductID) AS 'Number of Products' FROM Production.Product AS PR GROUP BY PR.Color
UNION ALL
SELECT PR.Color AS COLORS, COUNT(PR.ProductID) AS 'Number of Products' FROM Production.Product AS PR WHERE PR.Color IS NOT NULL GROUP BY PR.Color;


SELECT Color FROM
(SELECT 'All color' Color
UNION ALL
SELECT DISTINCT COALESCE(P.Color, 'No color') Color
FROM Production.Product P) X
ORDER BY IIF(Color IN ('All color', 'No color'),1,2), 1