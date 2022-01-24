-- Vendors query feladatok
	USE Vendors
-- Easy csoport feladatai
-- E1. feladat (10 pont)
	/* Készíts címlistát a szállítókról (vendorokról) az alábbi adatokkal:
		a.	BusinessEntityID, 
		b.	VendorName, 
		c.	Vendor címe (Main office= 3-as AddressTypeID) az alábbi formában: CountryName, StateProvinceCode, PostalCode, City, AddressLine1, AddressLine2
		d.	CreditRating (szövegesen: 1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average)
		e.	Rendezd a címlistát a vendor nevére. */
	SELECT V.BusinessEntityID VendorID, V.Name VendorName, CR.Name CountryName, SP.StateProvinceCode, 
		A.City, A.AddressLine1, A.AddressLine2,
		CHOOSE (V.CreditRating, 'Superior', 'Excellent', 'Above average', 'Average', 'Below average')
--		CASE V.CreditRating WHEN 1 THEN 'Superior' WHEN 2 THEN 'Excellent' WHEN 3 THEN 'Above average' 
--			WHEN 4 THEN 'Average' WHEN 5 THEN 'Below average' END CreditRatingName
	FROM Vendor V
	LEFT JOIN BusinessEntityAddress BEA ON V.BusinessEntityID = BEA.BusinessEntityID AND BEA.AddressTypeID = 3
	LEFT JOIN Address A ON BEA.AddressID = A.AddressID
	LEFT JOIN StateProvince SP ON A.StateProvinceID = SP.StateProvinceID
	LEFT JOIN CountryRegion CR ON SP.CountryRegionCode = CR.CountryRegionCode 
	ORDER BY 2

-- E2. feladat A korábbi 2-es feladat törölve, mert a kontakt személyek születésnapját nem tárolja az AdventureWorks, ezért a feladat nem megoldható. Bocs.

-- E3. feladat (10 pont) 
	/* Listázd ki azokat a forgalmazott (SellEndDate üres) termékeket, amelyek jelenleg egyetlen szállítótól sem rendelhetõk. 
		Megjelenítendõ mezõk: a termék neve, termékszáma (ProductNumber), listaára (ListPrice). Rendezés a termék nevére történjen. */
	SELECT P.Name ProductName, P.ProductNumber, P.ListPrice
	FROM Product P
	WHERE P.ProductID NOT IN (SELECT ProductID FROM ProductVendor) AND P.SellEndDate IS NULL
	ORDER BY 1
	
-- E4. feladat (10 pont) 
	/* Készíts listát, amiben össze lehet vetni az egyes szállítási módok (ShipMethod) esetén a szállítási költségeket (Freight). 
	A szállítói rendeléseket (PurchaseOrder) a szállítási mód (ShipMethod), azon belül évente és havonta (ShipDate alapján) kell összegezni. 
	A megjelenítendõ adatok:
		a.	A szállítási mód neve (Purchasing.ShipMethod.Name)
		b.	Év, hónap
		c.	Összes szállítási költség (Freight)
		d.	Összes termékköltség (SubTotal)
		e.	Az elõzõ kettõ alapján a szállítási költség százalékos értéke */
	SELECT SM.Name ShipMethodName, YEAR(POH.OrderDate) OrderYear, MONTH(POH.OrderDate) OrderMonth,
		SUM(POH.Freight), SUM(POH.SubTotal), SUM(POH.Freight) * 100 / SUM(POH.SubTotal) FreightPercent
	FROM PurchaseOrderHeader POH
	INNER JOIN ShipMethod SM ON POH.ShipMethodID = SM.ShipMethodID 
	GROUP BY SM.Name, YEAR(POH.OrderDate), MONTH(POH.OrderDate)
	ORDER BY 1, 2, 3
	GO
-- Hard csoport feladatai
-- H1. feladat (15 pont) 
	/* Listázd ki a termékeket és a szállítókat úgy, hogy minden egyes termékhez csak egy szállító jelenjen meg. 
	   Csak az aktív szállítókat vedd figyelembe (ActiveFlag=1). 
	   Ha egy termékhez nincs szállító, akkor az eredményben a szállító résznél NULL jelenik meg minden oszlopban. 
	   Ha több szállító is lenne egy termékhez, akkor a szállító által ajánlott StandardPrice döntsön 
	   (nyilván úgy, hogy a legolcsóbb árú vendor legyen feltüntetve az adott terméknél). 
	   A megjelenítendõ mezõk:
			a)	Vendor kódja (BusinessEntityID) és neve (Name)
			b)	A termék kódja (ProductID), neve (Name) és termékszáma (ProductNumber)
			c)	A vendor által adott ár (StandardPrice)
	   Rendezés: a termék neve. */
	SELECT VendorID, VendorName, ProductID, ProductName, ProductNumber, StandardPrice
	FROM (
	SELECT V.BusinessEntityID VendorID, V.Name VendorName, P.ProductID, P.Name ProductName, P.ProductNumber, PV.StandardPrice,
		ROW_NUMBER() OVER(PARTITION BY P.ProductID ORDER BY PV.StandardPrice) ItemNo
	FROM Product P
	LEFT JOIN ProductVendor PV ON P.ProductID = PV.ProductID
	LEFT JOIN Vendor V ON PV.BusinessEntityID = V.BusinessEntityID AND V.ActiveFlag = 1) X
	WHERE ItemNo = 1
	ORDER BY ProductName 

-- H2. feladat (15 pont) 
	/* Gyûjtsd ki egy paraméterként megadott nap vevõi rendelései alapján azt, hogy melyik termékbõl hány darabra van szükség. 
	   A kigyûjtött adatok alapján készíts egy szállítói rendelés ajánlást azokról a termékekrõl, ahol van szállító. 
	   Ha esetleg a rendelni kívánt mennyiség nincs a MinOrderQty és a MaxOrderQty között, akkor a WarningMsg oszlopban jelenjen meg, 
	   hogy „Túl kevés mennyiség”, illetve „Túl sok mennyiség”.
	   Megjelenítendõ adatok:
			a)	A termék kódja (ProductID), neve (Name) és termékszáma (ProductNumber)
			b)	Vendor kódja (BusinessEntityID) és neve (Name)
			c)	Rendelni kívánt darabszám
			d)	A vendor által adott ár (StandardPrice)
			e)	A vevõi rendelés alapján kalkulált átlagár
			f)	Az adott tétel profitja (illetve vesztesége) a darabszámot is figyelembe véve
			g)	Mikorra ér ide (AverageLeadTime alapján)
			h)	WarningMsg: Mennyiségi problémák üzenete, illetve vendor nélkül a „Gyártás szükséges” üzenet
	   Rendezés: a termék nevére */

	DECLARE @ActDate date = '20130921'
	; WITH DailyQty AS
	(SELECT ProductID, SUM(SOD.OrderQty) TotalQty, SUM(SOD.LineTotal) / SUM(SOD.OrderQty) AvgPrice
	 FROM SalesOrderDetail SOD
	 INNER JOIN SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID 
	 WHERE SOH.DueDate = @ActDate
	 GROUP BY ProductID)
	SELECT P.ProductID, P.Name ProductName, P.ProductNumber, V.BusinessEntityID VendorID, V.Name VendorName, 
		D.TotalQty, D.AvgPrice,	PV.StandardPrice, D.TotalQty * (D.AvgPrice - PV.StandardPrice) Profit, PV.AverageLeadTime,
		PV.MinOrderQty, PV.MaxOrderQty,
		CASE WHEN D.TotalQty < PV.MinOrderQty THEN 'Túl kevés mennyiség'
			 WHEN D.TotalQty > PV.MaxOrderQty THEN 'Túl sok mennyiség'
			 WHEN PV.ProductID IS NULL THEN 'Gyártás szükséges' END WarningMsg
	FROM Product P
	INNER JOIN DailyQty D ON P.ProductID = D.ProductID 
	LEFT JOIN ProductVendor PV ON P.ProductID = PV.ProductID
	LEFT JOIN Vendor V ON PV.BusinessEntityID = V.BusinessEntityID AND V.ActiveFlag = 1

-- 3. feladat (15 pont)
	/* Készíts listát arról, hogy a szállító felé elküldött rendelésekben (PurchaseOrder) az egyes kereskedõk (SalesPersonID) éves bontásban 
	   hány olyan rendelést vettek fel, amiben legalább egy komponens szerepelt (azaz volt benne Components kategóriájú termék).
	   (Az eredeti feladatkiírásban bicikli szerepelt, de az adatok alapján egyetlen biciklit sem rendelnek szállítóktól, 
	   hanem maguk gyártják a szállítóktól beszerzett komponensek összeszerelésével.)
	   Az elõállítandó oszlopok:
			a)	BusinessEntityID (PurchaseOrderHeader.SalesPersonID alapján)
			b)	PersonName (a LastName, FirstName és a MiddleName alapján)
			c)	Év (OrderDate alapján),
			d)	Szállítói rendelések darabszáma */
	SELECT CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName) PersonName, YEAR(SOH.OrderDate), 
		COUNT(DISTINCT SOH.PurchaseOrderID) NoOfComponentsOrders
	FROM PurchaseOrderDetail SOD
	INNER JOIN PurchaseOrderHeader SOH ON SOD.PurchaseOrderID = SOH.PurchaseOrderID 
	INNER JOIN Person E ON SOH.EmployeeID = E.BusinessEntityID 
	INNER JOIN Product P ON SOD.ProductID = P.ProductID
	INNER JOIN ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID
	WHERE S.ProductCategoryID = 2
	GROUP BY YEAR(SOH.OrderDate), CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName)
	ORDER BY 1,2

-- 4. feladat (15 pont)
	/* Készíts lekérdezést, ami kereskedõnként (SalesPersonID), termékkategóriánként, azon belül évente adja össze 
	   a szállítói rendelések értékét (PurchaseOrderDetail.LineTotal alapján). 
	   Külön szeretnék látni a magasabbra rangsorolt vendorok (CreditRating<=2) és az alacsonyabbra rangsorolt vendorok (CreditRating>2) rendeléseit.
	   A megjelenítendõ mezõk:
			a)	BusinessEntityID (PurchaseOrderHeader.SalesPersonID alapján)
			b)	PersonName (a LastName, FirstName és a MiddleName alapján)
			c)	Év (OrderDate alapján),
			d)	Termékkategória neve,
			e)	Jobb szállítók (CreditRating<=2) rendelési értéke (LineTotal)
			f)	Gyengébb szállítók (CreditRating>2) rendelési értéke (LineTotal)
			g)	Teljes forgalom – a CreditRating-tõl függetlenül */
	SELECT E.BusinessEntityID PersonID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName) PersonName,
		C.Name CategoryName, YEAR(SOH.OrderDate) DueYear,
		SUM(IIF(V.CreditRating <= 2, SOD.LineTotal, NULL)) SalesBV,
		SUM(IIF(V.CreditRating > 2, SOD.LineTotal, NULL)) SalesPV,
		SUM(SOD.LineTotal) TotalSales
	FROM PurchaseOrderDetail SOD
	INNER JOIN PurchaseOrderHeader SOH ON SOD.PurchaseOrderID = SOH.PurchaseOrderID
	INNER JOIN Vendor V ON SOH.VendorID = V.BusinessEntityID  
	INNER JOIN Person E ON SOH.EmployeeID = E.BusinessEntityID 
	INNER JOIN Product P ON SOD.ProductID = P.ProductID
	LEFT JOIN ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID
	LEFT JOIN ProductCategory C ON S.ProductCategoryID = C.ProductCategoryID 
	GROUP BY E.BusinessEntityID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName), C.Name, YEAR(SOH.OrderDate)
	ORDER BY 2, 3, 4
