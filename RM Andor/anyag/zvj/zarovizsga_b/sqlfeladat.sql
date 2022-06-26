1. feladat

SELECT PSC.Name, P.ProductID, P.Name, P.ListPrice
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE PSC.Name like '%bike%'

Készíts listát azokról a termék alkategóriákról (Production.ProductSubcategory tábla) és a hozzájuk tartozó termékekről (Production.Product tábla), amelyeknél a termék alkategória nevében szerepel a „bike” szó
A megjelenítendő mezők:
- Termék alkategória neve (ProductSubcategory.Name)
- Termék azonosítója (Product.ProductID)
- Termék neve (Product.Name)
- Termék listaára (Product.ListPrice)
A listát az alkategória nevére, azon belül a termék nevére rendezd!

2. 

SELECT P.ProductID 'Termék kódja', P.Name 'Termék neve', COUNT(SOD.OrderQty) 'Összes vásárolt darabszám', SUM(SOD.LineTotal) 'Teljes összeg'
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P
ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID, P.Name
ORDER BY P.Name

Készíts egy forgalmi összesítést a Sales.SalesOrderDetail tábla alapján a piros színű (Color = ’Red’) termékekről. A megjelenítendő mezők:
- Termék kódja (ProductID)
- Termék neve (Product.Name)
- Összes vásárolt darabszám (SalesOrderDetail.OrderQty)
- Teljes összeg (SalesOrderDetail.LineTotal))
Rendezd a listát a termék nevére!

3.

select p.ProductID "Termék kódja", p.Name "Termék neve", min (sod.unitprice) "Legalacsonyabb egységár", max (sod.unitprice) "Legmagasabb egységár", 
max (sod.unitprice) - min (sod.unitprice) "Különbözet"
from Production.Product P
join Sales.SalesOrderDetail SOD
on p.ProductID = sod.ProductID
group by p.ProductID, p.Name
order by [Termék neve]

Készíts lekérdezést, ami megjeleníti a vevői rendeléstételekben (Sales.SalesOrderDetail) szereplő termékeket (SalesOrderDetail.ProductID) a termék nevével együtt, és a legalacsonyabb, valamint a legmagasabb egységárat, ami előfordult. A megjelenítendő mezők:
- Termék kódja (ProductID),
- Termék neve (Production.Product táblából a Name oszlop)
- Legalacsonyabb egységár (SalesOrderDetail.UnitPrice alapján)
- Legmagasabb egységár (SalesOrderDetail.UnitPrice alapján)
- Az előző két oszlop különbsége
Az eredmény legyen a termék nevére rendezve!




CREATE DATABASE Sales
ON
( NAME = Sales_dat,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\saledat.mdf',
    SIZE = 10MB)
LOG ON
( NAME = Sales_log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\salelog.ldf',
    SIZE = 5MB) ;
GO
USE WebShop



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



T-SQL adminisztrációs feladat
1. feladat
Hozz létre egy Webshop nevű adatbázist az alábbi beállításokkal és haszáld is: 5 pont
- Adatbázis neve: Webshop
- Recovery model: FULL
- Induló adatbázis file: c:\DATABASE\DB\Webshop.mdf
- méret: 64 MByte
- Induló log file: c:\DATABASE\Logs\Webshop.ldf
- méret: 24 MByte