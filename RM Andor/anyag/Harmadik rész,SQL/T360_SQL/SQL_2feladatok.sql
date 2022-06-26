-- Vendors query feladatok
	USE Vendors
-- Easy csoport feladatai
-- E1. feladat (10 pont)
	/* K�sz�ts c�mlist�t a sz�ll�t�kr�l (vendorokr�l) az al�bbi adatokkal:
		a.	BusinessEntityID, 
		b.	VendorName, 
		c.	Vendor c�me (Main office= 3-as AddressTypeID) az al�bbi form�ban: CountryName, StateProvinceCode, PostalCode, City, AddressLine1, AddressLine2
		d.	CreditRating (sz�vegesen: 1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average)
		e.	Rendezd a c�mlist�t a vendor nev�re. */
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

-- E2. feladat A kor�bbi 2-es feladat t�r�lve, mert a kontakt szem�lyek sz�let�snapj�t nem t�rolja az AdventureWorks, ez�rt a feladat nem megoldhat�. Bocs.

-- E3. feladat (10 pont) 
	/* List�zd ki azokat a forgalmazott (SellEndDate �res) term�keket, amelyek jelenleg egyetlen sz�ll�t�t�l sem rendelhet�k. 
		Megjelen�tend� mez�k: a term�k neve, term�ksz�ma (ProductNumber), lista�ra (ListPrice). Rendez�s a term�k nev�re t�rt�njen. */
	SELECT P.Name ProductName, P.ProductNumber, P.ListPrice, P.SellEndDate
	FROM Production.Product P
	WHERE P.ProductID NOT IN (SELECT ProductID FROM Purchasing.ProductVendor) AND P.SellEndDate IS NULL
	ORDER BY 1
	
-- E4. feladat (10 pont) 
	/* K�sz�ts list�t, amiben �ssze lehet vetni az egyes sz�ll�t�si m�dok (ShipMethod) eset�n a sz�ll�t�si k�lts�geket (Freight). 
	A sz�ll�t�i rendel�seket (PurchaseOrder) a sz�ll�t�si m�d (ShipMethod), azon bel�l �vente �s havonta (ShipDate alapj�n) kell �sszegezni. 
	A megjelen�tend� adatok:
		a.	A sz�ll�t�si m�d neve (Purchasing.ShipMethod.Name)
		b.	�v, h�nap
		c.	�sszes sz�ll�t�si k�lts�g (Freight)
		d.	�sszes term�kk�lts�g (SubTotal)
		e.	Az el�z� kett� alapj�n a sz�ll�t�si k�lts�g sz�zal�kos �rt�ke */
	SELECT SM.Name ShipMethodName, YEAR(POH.OrderDate) OrderYear, MONTH(POH.OrderDate) OrderMonth,
		SUM(POH.Freight), SUM(POH.SubTotal), SUM(POH.Freight) * 100 / SUM(POH.SubTotal) FreightPercent
	FROM Purchasing.PurchaseOrderHeader POH
	INNER JOIN Purchasing.ShipMethod SM ON POH.ShipMethodID = SM.ShipMethodID 
	GROUP BY SM.Name, YEAR(POH.OrderDate), MONTH(POH.OrderDate)
	ORDER BY 1, 2, 3
	GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Hard csoport feladatai
-- H1. feladat (15 pont) 
	/* List�zd ki a term�keket �s a sz�ll�t�kat �gy, hogy minden egyes term�khez csak egy sz�ll�t� jelenjen meg. 
	   Csak az akt�v sz�ll�t�kat vedd figyelembe (ActiveFlag=1). 
	   Ha egy term�khez nincs sz�ll�t�, akkor az eredm�nyben a sz�ll�t� r�szn�l NULL jelenik meg minden oszlopban. 
	   Ha t�bb sz�ll�t� is lenne egy term�khez, akkor a sz�ll�t� �ltal aj�nlott StandardPrice d�nts�n 
	   (nyilv�n �gy, hogy a legolcs�bb �r� vendor legyen felt�ntetve az adott term�kn�l). 
	   A megjelen�tend� mez�k:
			a)	Vendor k�dja (BusinessEntityID) �s neve (Name)
			b)	A term�k k�dja (ProductID), neve (Name) �s term�ksz�ma (ProductNumber)
			c)	A vendor �ltal adott �r (StandardPrice)
	   Rendez�s: a term�k neve. */
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
	/* Gy�jtsd ki egy param�terk�nt megadott nap vev�i rendel�sei alapj�n azt, hogy melyik term�kb�l h�ny darabra van sz�ks�g. 
	   A kigy�jt�tt adatok alapj�n k�sz�ts egy sz�ll�t�i rendel�s aj�nl�st azokr�l a term�kekr�l, ahol van sz�ll�t�. 
	   Ha esetleg a rendelni k�v�nt mennyis�g nincs a MinOrderQty �s a MaxOrderQty k�z�tt, akkor a WarningMsg oszlopban jelenjen meg, 
	   hogy �T�l kev�s mennyis�g�, illetve �T�l sok mennyis�g�.
	   Megjelen�tend� adatok:
			a)	A term�k k�dja (ProductID), neve (Name) �s term�ksz�ma (ProductNumber)
			b)	Vendor k�dja (BusinessEntityID) �s neve (Name)
			c)	Rendelni k�v�nt darabsz�m
			d)	A vendor �ltal adott �r (StandardPrice)
			e)	A vev�i rendel�s alapj�n kalkul�lt �tlag�r
			f)	Az adott t�tel profitja (illetve vesztes�ge) a darabsz�mot is figyelembe v�ve
			g)	Mikorra �r ide (AverageLeadTime alapj�n)
			h)	WarningMsg: Mennyis�gi probl�m�k �zenete, illetve vendor n�lk�l a �Gy�rt�s sz�ks�ges� �zenet
	   Rendez�s: a term�k nev�re */

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
		CASE WHEN D.TotalQty < PV.MinOrderQty THEN 'T�l kev�s mennyis�g'
			 WHEN D.TotalQty > PV.MaxOrderQty THEN 'T�l sok mennyis�g'
			 WHEN PV.ProductID IS NULL THEN 'Gy�rt�s sz�ks�ges' END WarningMsg
	FROM Product P
	INNER JOIN DailyQty D ON P.ProductID = D.ProductID 
	LEFT JOIN ProductVendor PV ON P.ProductID = PV.ProductID
	LEFT JOIN Vendor V ON PV.BusinessEntityID = V.BusinessEntityID AND V.ActiveFlag = 1

-- 3. feladat (15 pont)
	/* K�sz�ts list�t arr�l, hogy a sz�ll�t� fel� elk�ld�tt rendel�sekben (PurchaseOrder) az egyes keresked�k (SalesPersonID) �ves bont�sban 
	   h�ny olyan rendel�st vettek fel, amiben legal�bb egy komponens szerepelt (azaz volt benne Components kateg�ri�j� term�k).
	   (Az eredeti feladatki�r�sban bicikli szerepelt, de az adatok alapj�n egyetlen biciklit sem rendelnek sz�ll�t�kt�l, 
	   hanem maguk gy�rtj�k a sz�ll�t�kt�l beszerzett komponensek �sszeszerel�s�vel.)
	   Az el��ll�tand� oszlopok:
			a)	BusinessEntityID (PurchaseOrderHeader.SalesPersonID alapj�n)
			b)	PersonName (a LastName, FirstName �s a MiddleName alapj�n)
			c)	�v (OrderDate alapj�n),
			d)	Sz�ll�t�i rendel�sek darabsz�ma */
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
	/* K�sz�ts lek�rdez�st, ami keresked�nk�nt (SalesPersonID), term�kkateg�ri�nk�nt, azon bel�l �vente adja �ssze 
	   a sz�ll�t�i rendel�sek �rt�k�t (PurchaseOrderDetail.LineTotal alapj�n). 
	   K�l�n szeretn�k l�tni a magasabbra rangsorolt vendorok (CreditRating<=2) �s az alacsonyabbra rangsorolt vendorok (CreditRating>2) rendel�seit.
	   A megjelen�tend� mez�k:
			a)	BusinessEntityID (PurchaseOrderHeader.SalesPersonID alapj�n)
			b)	PersonName (a LastName, FirstName �s a MiddleName alapj�n)
			c)	�v (OrderDate alapj�n),
			d)	Term�kkateg�ria neve,
			e)	Jobb sz�ll�t�k (CreditRating<=2) rendel�si �rt�ke (LineTotal)
			f)	Gyeng�bb sz�ll�t�k (CreditRating>2) rendel�si �rt�ke (LineTotal)
			g)	Teljes forgalom � a CreditRating-t�l f�ggetlen�l */
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
