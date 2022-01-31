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