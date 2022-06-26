SELECT CONCAT(P.FirstName+ ' ', P.LastName) AS CustomerName, SOH.TotalDue AS TotalOrder, SOH.CustomerID
	FROM Sales.SalesOrderHeader SOH
	JOIN Person.Person P
		ON P.BusinessEntityID = SOH.CustomerID
	WHERE SOH.DueDate BETWEEN '20120401' AND '20131231'
	ORDER BY SOH.CustomerID DESC;


SELECT CONCAT(P.FirstName+' ',P.LastName) AS CustomerName, SUM(SOH.TotalDue) AS TotalOrder -- enyém
	FROM Sales.SalesOrderHeader AS SOH
	JOIN Person.Person AS P
		ON SOH.CustomerID = P.BusinessEntityID
	WHERE SOH.OrderDate BETWEEN '20120401' AND '20131231'
	GROUP BY CONCAT(P.FirstName+' ', P.LastName);

SELECT *
	FROM Person.Person;

SELECT *
	FROM Sales.SalesOrderHeader;


SELECT CONCAT(PP.FirstName+' ', PP.LastName) AS CustomerName, SUM(SOH.TotalDue) AS TotalOrder    -- M
    FROM Sales.SalesOrderHeader AS SOH
    JOIN Person.Person AS PP ON SOH.CustomerID = PP.BusinessEntityID
    WHERE SOH.OrderDate BETWEEN '2012-04-01' AND '2013-12-31'
    GROUP BY PP.FirstName, PP.LastName;

USE AdventureWorks2019;

SELECT CONCAT(PP.FirstName+' ', PP.LastName) AS CustomerName, SUM(SOH.TotalDue) AS TotalOrder  -- M2
    FROM Sales.SalesOrderHeader AS SOH
    JOIN Person.Person AS PP ON SOH.CustomerID = PP.BusinessEntityID
    WHERE SOH.OrderDate BETWEEN '2012-04-01' AND '2013-12-31'
    GROUP BY CONCAT(PP.FirstName+' ', PP.LastName)


SELECT CONCAT(P.FirstName,' ',P.LastName) AS CustomerName, SUM(SOH.TotalDue) AS TotalOrder   -- ba
FROM Person.Person AS P
JOIN Sales.Customer AS C ON P.BusinessEntityID = C.PersonID
JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID = SOH.CustomerID
WHERE SOH.OrderDate BETWEEN '2012-04-01' AND '2013-12-31'
GROUP BY CONCAT(P.FirstName,' ',P.LastName)
ORDER BY TotalOrder DESC;


SELECT SOH.CustomerID, COUNT(SOH.CustomerID) AS 'Vásárlások száma',
		SOD.ProductID, SUM(SOD.OrderQty) AS 'Vásárolt mennyiség'
	FROM Sales.SalesOrderHeader SOH
	INNER JOIN Sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderID = SOD.SalesOrderID
	GROUP BY SOH.CustomerID, SOD.ProductID
	ORDER BY 4 DESC;



/*A lekérdezésben:
A Person.Person táblát a BusinessEntityID - CustomerID segítségével kösd a Sales.SalesOrderHeader táblához, úgy hogy azok a megrendelések is jelenjenek meg amikhez nincs adat a Person.Person táblában.
A Production.Product táblát a ProductID - ProuductID segítségével kösd a Sales.SalesOrderDetail táblához, úgy hogy azok a megrendelések is jelenjenek meg amikhez nincs adat a Production.Product táblában.
A Sales.SalesOrderHeader táblát a Sales.SalesOrderDetail táblával idegen kulcsával kösd össze. A tábláknak adj alias nevet a lekérdezésben.

A lekérdezés tartalmazza a

A megrendelés számát SalesOrderID
A vevő keresztnevét Person.Person.Firstname, 'N/A' értékkel ha NULL Keresztnév néven
A vevő vezetéknevét Person.Person.Lastname, 'N/A' értékkel ha NULL Vezetéknév néven
Az megrendelés dátumát 3 külön oszlopban (Év, hónap, nap) OrderDate Év, Hónap, Nap néven
A termék nevét Name Terméknév néven
A termég színét Color Szin néven
A rendelt darabszámot OrderQty Mennyiség néven
Az egységárat UnitPrice Egységár néven
Számított mezőként a darabszam * egységár 45%-al csökkentett értékét Profit néven
oszlopokat.

Készíts a lekérdezésből egy View-t SalesOrderProfit néven*/

SELECT SOD.SalesOrderID, coalesce(pp.FirstName, 'N/A') AS Keresztnév, coalesce(pp.lastname, 'N/A') AS Vezetéknév, YEAR(SOH.OrderDate) AS Év,
		MONTH(SOH.OrderDate) AS Hónap, DAY(SOH.OrderDate) AS Nap, P.Name AS Terméknév, P.Color AS Szín, SOD.OrderQty AS Mennyiség,
		SOD.UnitPrice AS Egységár, (SOD.OrderQty*SOD.UnitPrice*0.55) AS Profit
	FROM Production.Product AS P
	LEFT JOIN Sales.SalesOrderDetail AS SOD 
		ON P.ProductID = SOD.ProductID
	INNER JOIN Sales.SalesOrderHeader AS SOH 
		ON SOD.SalesOrderID = SOH.SalesOrderID
	LEFT JOIN Person.Person AS PP 
		ON SOH.CustomerID = PP.BusinessEntityID


SELECT SOD.SalesOrderID, COALESCE(PP.FirstName, 'N/A') AS Keresztnév, COALESCE(PP.LastName, 'N/A') AS Vezetéknév, 
        YEAR(SOH.OrderDate) AS Év, MONTH(SOH.OrderDate) AS Hónap, DAY(SOH.OrderDate) AS Nap,
        PD.Name AS Terméknév, PD.Color AS Szín, SOD.OrderQty AS Mennyiség, SOD.UnitPrice AS Egységár,
        SOD.OrderQty * SOD.UnitPrice * (1-0.45) AS Profit
    FROM Sales.SalesOrderHeader SOH
    JOIN Sales.SalesOrderDetail SOD 
		ON SOD.SalesOrderID = SOH.SalesOrderID
    LEFT JOIN Production.Product PD 
		ON PoP.ProductID = SOD.ProductID
    LEFT JOIN Person.Person PP 
		ON PP.BusinessEntityID = SOH.CustomerID


/*CREATE VIEW SalesOrderProfit AS*/



/*Kérdezd le, hogy 1 vevő hányszor vásárolt, termékenként a vásárolt darabszámot összesítve.

Készítsd el a SalesOrderHeader és SalesOrderDetail tábláinak összkapcsolt lekérdezését.
A Sales.SalesOrderHeader táblát a Sales.SalesOrderDetail táblával idegen kulcsával kösd össze.
A vásárolt mennyiséget a SalesOrderDetail.OrderQty oszlop tartalmazza

A lekérdezés tartalmazza a
- CustomerID
- 'Vásárlások száma'
- ProductID
- 'Vásárolt mennyiség'

oszlopokat.
Rendezd a lekérdezést a vásárolt mennyiség szerint csökkenő sorrendbe*/

SELECT SOH.CustomerID, COUNT(SOH.CustomerID) AS VásárlásokSzáma, SOD.ProductID, SUM(SOD.OrderQty) AS VásároltMennyiség
	FROM Sales.SalesOrderHeader AS SOH
	JOIN Sales.SalesOrderDetail AS SOD 
		ON SOH.SalesOrderID = SOD.SalesOrderID
	GROUP BY SOH.CustomerID, SOD.ProductID
	ORDER BY SUM(SOD.OrderQty) DESC;