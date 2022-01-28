-- Piros színű termékek
SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Color = 'Red'

-- Piros, kék és sárga termékek
SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Color = 'Red' OR P.Color = 'Blue' or p.cOLOR = 'Yellow'

SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Color IN ('Red', 'Blue', 'Yellow')

-- Adott időszakban történt vásárlások
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate BETWEEN '20130101' AND '20130331'

SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'

-- LIKE predik�tum használata
SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Name LIKE 'Socks%'

SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Name LIKE '%Socks%'

-- Egyszerű rendezés: vevőre, azon belül rendelésszámra
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'
ORDER BY SOH.CustomerID, SOH.SalesOrderID

SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'
ORDER BY 3, 1

-- Csökkenő sorrendű rendezés: elől álljanak a nagyobb vásárlási összegek:
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'
ORDER BY SOH.TotalDue DESC

