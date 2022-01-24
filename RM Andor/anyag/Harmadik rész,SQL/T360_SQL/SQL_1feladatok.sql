-- Employees Query feladatok
	USE Employees
-- Easy csoport feladatai
-- E1. feladat (10 pont)
	/* Készíts listát az alkalmazottakról az alábbi adatokkal:
		a.	BusinessEntityID, 
		b.	PersonName (a LastName, FirstName és a MiddleName alapján), 
		c.	EmailAddress, 
		d.	PhoneNumber (PhoneType.Name), például 181-555-0156 (Work).
		e.	Rendezd a címlistát az alkalmazott nevére. */
	SELECT E.BusinessEntityID, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) PersonName,
		EA.EmailAddress, CONCAT(PP.PhoneNumber, ' (', PT.Name, ')') PhoneNumber    
	FROM Employee E
	INNER JOIN Person P ON E.BusinessEntityID = P.BusinessEntityID 
	INNER JOIN EmailAddress EA ON E.BusinessEntityID = EA.BusinessEntityID 
	INNER JOIN PersonPhone PP ON E.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN PhoneNumberType PT ON PP.PhoneNumberTypeID = PT.PhoneNumberTypeID 
	ORDER BY PersonName

-- E2. feladat (10 pont)
	/* Kik azok az alkalmazottak, akiknek ma van a születésnapjuk. Megjelenítendõ mezõk:
		a.	BusinessEntityID
		b.	PersonName (a LastName, FirstName és a MiddleName alapján)
		c.	BirthDate
		d.	A lista az alkalmazott nevére legyen rendezve. */
	SELECT E.BusinessEntityID, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) PersonName, E.BirthDate 
	FROM Employee E
	INNER JOIN Person P ON E.BusinessEntityID = P.BusinessEntityID
	WHERE MONTH(GETDATE()) = MONTH(E.BirthDate) AND DAY(GETDATE()) = DAY(E.BirthDate)
	ORDER BY PersonName

-- E3. feladat (7 pont) 
	/* Listázd ki azokat az alkalmazottakat, akik több részlegnél (Department) is dolgoztak. 
	   Csak a BusinessEntityID és a PersonName jelenjen meg a listában – a személy nevére rendezve. */
	SELECT P.BusinessEntityID, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) PersonName
	FROM Person P
	WHERE P.BusinessEntityID IN
		(SELECT BusinessEntityID
		 FROM EmployeeDepartmentHistory
		 GROUP BY BusinessEntityID
		 HAVING COUNT(1) > 1)

-- E4. feladat (8 pont)
	/* Listázd ki azokat az alkalmazottakat, akik jelenleg egyedüliként dolgoznak egy részleg (Department) egy mûszakjában (Shift). 
	   A BusinessEntityID, a PersonName, a Department és a Shift neve (Day, Evening vagy Night) jelenjen meg a listában – a személy nevére rendezve.*/
	SELECT MIN(P.BusinessEntityID), MIN(CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName)) PersonName,
		D.Name DepartmentName, S.Name ShiftName
	FROM Person P
	INNER JOIN EmployeeDepartmentHistory EDH ON P.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN Department D ON EDH.DepartmentID = D.DepartmentID
	INNER JOIN Shift S ON EDH.ShiftID = S.ShiftID 
	GROUP BY D.Name, S.Name
	HAVING COUNT(1) = 1

-- Hard csoport feladatai
-- H1. feladat (10 pont) 
	/* Készíts listát az egyes részlegek és mûszakok személyi összetételérõl – az egyes alkalmazottak nevét vesszõvel elválasztva. 
	Csak azokat az alkalmazottakat vedd figyelembe, akik egy paraméterként megadott napon aktívak voltak. 
	A paraméter alapértelmezett értéke a mai nap legyen. 
	A Department, a Shift neve (Reggel, Este vagy Éjszaka), valamint az alkalmazottak nevei jelenjenek meg a listában – 
	a Department nevére és a Shift.StartTime-ra rendezve. */
	DECLARE @ActDate date = SYSDATETIME()
	SELECT D.Name DepartmentName, S.Name ShiftName, 
		STRING_AGG(CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName),',') PersonName
	FROM Person P
	INNER JOIN EmployeeDepartmentHistory EDH ON P.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN Department D ON EDH.DepartmentID = D.DepartmentID
	INNER JOIN Shift S ON EDH.ShiftID = S.ShiftID 
	WHERE @ActDate BETWEEN EDH.StartDate AND COALESCE(EDH.EndDate,'99991231')
	GROUP BY D.Name, S.Name

-- H2. feladat (10 pont) 
	/* Készíts listát arról, hogy az egyes kereskedõk éves bontásban hány olyan rendelést vettek fel, amiben legalább egy 
	bicikli szerepelt (azaz volt benne Bikes kategóriájú termék). 
	Az elõállítandó oszlopok:
		a.	BusinessEntityID (SalesOrderHeader.SalesPersonID alapján)
		b.	PersonName (a LastName, FirstName és a MiddleName alapján)
		c.	Év (DueDate alapján),
		d.	Rendelések darabszáma */
	SELECT CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName) PersonName, YEAR(SOH.DueDate), 
		COUNT(DISTINCT SOH.SalesOrderID) NoOfBikeOrders
	FROM SalesOrderDetail SOD
	INNER JOIN SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	INNER JOIN Person E ON SOH.SalesPersonID = E.BusinessEntityID 
	INNER JOIN Product P ON SOD.ProductID = P.ProductID
	INNER JOIN ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID
	WHERE S.ProductCategoryID = 1
	GROUP BY YEAR(SOH.DueDate), CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName)
	ORDER BY 1,2
	
-- H3. feladat (12 pont)
	/* Készíts listát az egyes kereskedõk viszonteladók felé történõ értékesítésérõl havi bontásban. 
	Viszonteladó az, akinek a SalesOrderHeader táblában szereplõ CustomerID adata alapján a Customer táblában a StoreID ki van töltve. 
	Az alábbi adatok jelenjenek meg a listában:
		a.	BusinessEntityID (SalesOrderHeader.SalesPersonID alapján)
		b.	PersonName (a LastName, FirstName és a MiddleName alapján)
		c.	Év és hónap (DueDate alapján),
		d.	Forgalom SalesOrderHeader.SubTotal alapján
		e.	Eltérés az adott kereskedõ elõzõ havi forgalmához képest. */
	;WITH Sales AS 
		(SELECT E.BusinessEntityID PersonID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName) PersonName, 
			YEAR(SOH.DueDate) DueYear, MONTH(SOH.DueDate) DueMonth, SUM(SOH.SubTotal) TotalSales
		 FROM SalesOrderHeader SOH
		 INNER JOIN Person E ON SOH.SalesPersonID = E.BusinessEntityID
		 INNER JOIN Customer C ON SOH.CustomerID = C.CustomerID
		 WHERE C.StoreID IS NOT NULL
		 GROUP BY E.BusinessEntityID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName), 
			YEAR(SOH.DueDate), MONTH(SOH.DueDate))
	SELECT S.PersonID, S.PersonName, S.DueYear, S.DueMonth, S.TotalSales, SE.TotalSales PrevMonthTotalSales,
		S.TotalSales - COALESCE(SE.TotalSales,0) TotalSalesDiff
	FROM Sales S
	LEFT JOIN Sales SE ON S.PersonID = SE.PersonID AND 
		S.DueYear*100 + S.DueMonth - IIF(S.DueMonth=1,89,1) = SE.DueYear*100 + SE.DueMonth
	ORDER BY 2, 3, 4

-- H4. feladat (8 pont)
	/* Egészítsd ki az elõzõ lekérdezést a SalesOrderHeader.BillToAddressID adatból kiindulva az országgal. 
	   Így tehát minden kereskedõ, minden országára, azon belül évre és hónapra jelenjenek meg az adatok. */
	;WITH Sales AS 
		(SELECT CR.Name CountryName, E.BusinessEntityID PersonID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName) PersonName, 
			YEAR(SOH.DueDate) DueYear, MONTH(SOH.DueDate) DueMonth, SUM(SOH.SubTotal) TotalSales
		 FROM SalesOrderHeader SOH
		 INNER JOIN Address A ON SOH.BillToAddressID = A.AddressID
		 INNER JOIN StateProvince SP ON A.StateProvinceID = SP.StateProvinceID
		 INNER JOIN CountryRegion CR ON SP.CountryRegionCode = CR.CountryRegionCode 
		 INNER JOIN Person E ON SOH.SalesPersonID = E.BusinessEntityID 
		 GROUP BY CR.Name, E.BusinessEntityID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName), 
			YEAR(SOH.DueDate), MONTH(SOH.DueDate))
	SELECT S.CountryName, S.PersonID, S.PersonName, S.DueYear, S.DueMonth, S.TotalSales, SE.TotalSales PrevMonthTotalSales,
		S.TotalSales - COALESCE(SE.TotalSales,0) TotalSalesDiff
	FROM Sales S
	LEFT JOIN Sales SE ON S.PersonID = SE.PersonID AND S.CountryName = SE.CountryName AND
		S.DueYear*100 + S.DueMonth - IIF(S.DueMonth=1,89,1) = SE.DueYear*100 + SE.DueMonth
	ORDER BY 1, 3, 4

-- H5. feladat (15 pont) 
	/* Készíts lekérdezést, ami kereskedõnként (SalesPersonID), termékkategóriánként, azon belül évente adja össze 
	   a forgalom értékét (SalesOrderDetail.LineTotal alapján). 
	   Külön szeretnék látni a kedvezménnyel eladott forgalmat (SpecialOfferID>1) és a kedvezmény nélkül eladott forgalmat (SpecialOfferID=1). 
	   A megjelenítendõ mezõk:
			a.	BusinessEntityID (SalesOrderHeader.SalesPersonID alapján)
			b.	PersonName (a LastName, FirstName és a MiddleName alapján)
			c.	Termékkategória neve,
			d.	Év (DueDate alapján),
			e.	Kedvezmény nélküli (SpecialOfferID=1) forgalom (LineTotal)
			f.	Kedvezményes (SpecialOfferID>1) forgalom (LineTotal)
			g.	Teljes forgalom – a SpecialOfferID-tõl függetlenül */
	SELECT E.BusinessEntityID PersonID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName) PersonName,
		C.Name CategoryName, YEAR(SOH.DueDate) DueYear,
		SUM(IIF(SOD.SpecialOfferID = 1, SOD.LineTotal, NULL)) NormalSales,
		SUM(IIF(SOD.SpecialOfferID > 1, SOD.LineTotal, NULL)) ActionSales,
		SUM(SOD.LineTotal) TotalSales
	FROM SalesOrderDetail SOD
	INNER JOIN SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	INNER JOIN Person E ON SOH.SalesPersonID = E.BusinessEntityID 
	INNER JOIN Product P ON SOD.ProductID = P.ProductID
	LEFT JOIN ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID
	LEFT JOIN ProductCategory C ON S.ProductCategoryID = C.ProductCategoryID 
	GROUP BY E.BusinessEntityID, CONCAT(E.LastName, ' ' + E.MiddleName, ', ' + E.FirstName), C.Name, YEAR(SOH.DueDate)
	ORDER BY 2, 3, 4

