-- K�rj�k le a 10 legnagyobb �sszeg� v�s�rl�s adatait a
--  Sales.SalesOrderHeader t�bl�b�l
SELECT TOP 10 SOH.*
FROM Sales.SalesOrderHeader SOH
ORDER BY SOH.TotalDue DESC
GO

-- Ugyanaz, de v�ltoz� megad�si lehet�s�ggel:
DECLARE @N int = 10
SELECT TOP(@N) SOH.*
FROM Sales.SalesOrderHeader SOH
ORDER BY SOH.TotalDue DESC
GO

-- Az el�z�h�z hasonl� feladat, de a legmagasabb 10% j�jj�n le:
DECLARE @N int = 10
SELECT TOP(@N) PERCENT SOH.*
FROM Sales.SalesOrderHeader SOH
ORDER BY SOH.TotalDue DESC

-- K�r�nk 1000 sort a t�bl�b�l random
SELECT SOH.*
FROM Sales.SalesOrderHeader SOH 
TABLESAMPLE(1000 ROWS)
-- �rdekes de itt hiba lenne egyes sz�mban megadni a ROW-t:
-- TABLESAMPLE(1000 ROW)

-- Nocsak nem pont annyit kaptunk, �s minden fut�sn�l m�s a darabsz�m.
-- Ha t�nyleg 1000 kell pontosan, akkor k�rj�nk egy kicsit t�bbet, �s TOP 1000
SELECT TOP 1000 SOH.*
FROM Sales.SalesOrderHeader SOH 
TABLESAMPLE(2000 ROWS)

-- Ha egy p�rszor szeretn�nk, hogy pontosan ugyanaz a halmaz j�jj�n vissza,
-- akkor kell a REPETABLE(n), ahol 'n' a darbsz�m
SELECT TOP 1000 SOH.*
FROM Sales.SalesOrderHeader SOH 
TABLESAMPLE(2000 ROWS) REPEATABLE(10)
GO

-- Kliens rendszerek kiszolg�l�s�n�l gyakori ig�ny, hogy p�ld�ul az 5. lap
-- tartalm�t adjuk vissza, �s egy lap mondjuk 20 sor.
SELECT P.* 
FROM Production.Product P
ORDER BY P.Name
OFFSET 100 ROWS FETCH NEXT 20 ROWS ONLY
-- Itt laz�bb volt az 'alkot�', mert egyes sz�mban is elfogadja a ROW-t b�rmelyik helyen a kett�b�l:
-- OFFSET 100 ROW FETCH NEXT 20 ROW ONLY

Jelenítsd meg a SalesOrderHeader táblából az OrderDate alapján csökkenő, a SalesOrderID alapján növekvő sorrendbe rendezett 15 legfelső rendelés azonosítóját (SalesOrderID), időpontját (OrderDate), az ügyfél és az értékesítő azonosítóját (CustomerID, SalesPersonID)! 

SELECT TOP 15 SOH.SalesOrderID, SOH.OrderDate, SOH.CustomerID, SOH.SalesOrderID
	FROM Sales.SalesOrderHeader SOH
	ORDER BY SOH.OrderDate DESC, SOH.SalesOrderID;