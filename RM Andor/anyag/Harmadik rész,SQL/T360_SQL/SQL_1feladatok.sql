-- Employees Query feladatok
	USE Employees
-- Easy csoport feladatai
-- E1. feladat (10 pont)
	/* K�sz�ts list�t az alkalmazottakr�l az al�bbi adatokkal:
		a.	BusinessEntityID, 
		b.	PersonName (a LastName, FirstName �s a MiddleName alapj�n), 
		c.	EmailAddress, 
		d.	PhoneNumber (PhoneType.Name), p�ld�ul 181-555-0156 (Work).
		e.	Rendezd a c�mlist�t az alkalmazott nev�re. */
	SELECT E.BusinessEntityID, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) PersonName,
		EA.EmailAddress, CONCAT(PP.PhoneNumber, ' (', PT.Name, ')') PhoneNumber    
	FROM Employee E
	INNER JOIN Person P ON E.BusinessEntityID = P.BusinessEntityID 
	INNER JOIN EmailAddress EA ON E.BusinessEntityID = EA.BusinessEntityID 
	INNER JOIN PersonPhone PP ON E.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN PhoneNumberType PT ON PP.PhoneNumberTypeID = PT.PhoneNumberTypeID 
	ORDER BY PersonName

-- E2. feladat (10 pont)
	/* Kik azok az alkalmazottak, akiknek ma van a sz�let�snapjuk. Megjelen�tend� mez�k:
		a.	BusinessEntityID
		b.	PersonName (a LastName, FirstName �s a MiddleName alapj�n)
		c.	BirthDate
		d.	A lista az alkalmazott nev�re legyen rendezve. */
	SELECT E.BusinessEntityID, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) PersonName, E.BirthDate 
	FROM Employee E
	INNER JOIN Person P ON E.BusinessEntityID = P.BusinessEntityID
	WHERE MONTH(GETDATE()) = MONTH(E.BirthDate) AND DAY(GETDATE()) = DAY(E.BirthDate)
	ORDER BY PersonName

-- E3. feladat (7 pont) 
	/* List�zd ki azokat az alkalmazottakat, akik t�bb r�szlegn�l (Department) is dolgoztak. 
	   Csak a BusinessEntityID �s a PersonName jelenjen meg a list�ban � a szem�ly nev�re rendezve. */
	SELECT P.BusinessEntityID, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) PersonName
	FROM Person P
	WHERE P.BusinessEntityID IN
		(SELECT BusinessEntityID
		 FROM EmployeeDepartmentHistory
		 GROUP BY BusinessEntityID
		 HAVING COUNT(1) > 1)

-- E4. feladat (8 pont)
	/* List�zd ki azokat az alkalmazottakat, akik jelenleg egyed�lik�nt dolgoznak egy r�szleg (Department) egy m�szakj�ban (Shift). 
	   A BusinessEntityID, a PersonName, a Department �s a Shift neve (Day, Evening vagy Night) jelenjen meg a list�ban � a szem�ly nev�re rendezve.*/
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
	/* K�sz�ts list�t az egyes r�szlegek �s m�szakok szem�lyi �sszet�tel�r�l � az egyes alkalmazottak nev�t vessz�vel elv�lasztva. 
	Csak azokat az alkalmazottakat vedd figyelembe, akik egy param�terk�nt megadott napon akt�vak voltak. 
	A param�ter alap�rtelmezett �rt�ke a mai nap legyen. 
	A Department, a Shift neve (Reggel, Este vagy �jszaka), valamint az alkalmazottak nevei jelenjenek meg a list�ban � 
	a Department nev�re �s a Shift.StartTime-ra rendezve. */
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
	/* K�sz�ts list�t arr�l, hogy az egyes keresked�k �ves bont�sban h�ny olyan rendel�st vettek fel, amiben legal�bb egy 
	bicikli szerepelt (azaz volt benne Bikes kateg�ri�j� term�k). 
	Az el��ll�tand� oszlopok:
		a.	BusinessEntityID (SalesOrderHeader.SalesPersonID alapj�n)
		b.	PersonName (a LastName, FirstName �s a MiddleName alapj�n)
		c.	�v (DueDate alapj�n),
		d.	Rendel�sek darabsz�ma */
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
	/* K�sz�ts list�t az egyes keresked�k viszontelad�k fel� t�rt�n� �rt�kes�t�s�r�l havi bont�sban. 
	Viszontelad� az, akinek a SalesOrderHeader t�bl�ban szerepl� CustomerID adata alapj�n a Customer t�bl�ban a StoreID ki van t�ltve. 
	Az al�bbi adatok jelenjenek meg a list�ban:
		a.	BusinessEntityID (SalesOrderHeader.SalesPersonID alapj�n)
		b.	PersonName (a LastName, FirstName �s a MiddleName alapj�n)
		c.	�v �s h�nap (DueDate alapj�n),
		d.	Forgalom SalesOrderHeader.SubTotal alapj�n
		e.	Elt�r�s az adott keresked� el�z� havi forgalm�hoz k�pest. */
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
	/* Eg�sz�tsd ki az el�z� lek�rdez�st a SalesOrderHeader.BillToAddressID adatb�l kiindulva az orsz�ggal. 
	   �gy teh�t minden keresked�, minden orsz�g�ra, azon bel�l �vre �s h�napra jelenjenek meg az adatok. */
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
	/* K�sz�ts lek�rdez�st, ami keresked�nk�nt (SalesPersonID), term�kkateg�ri�nk�nt, azon bel�l �vente adja �ssze 
	   a forgalom �rt�k�t (SalesOrderDetail.LineTotal alapj�n). 
	   K�l�n szeretn�k l�tni a kedvezm�nnyel eladott forgalmat (SpecialOfferID>1) �s a kedvezm�ny n�lk�l eladott forgalmat (SpecialOfferID=1). 
	   A megjelen�tend� mez�k:
			a.	BusinessEntityID (SalesOrderHeader.SalesPersonID alapj�n)
			b.	PersonName (a LastName, FirstName �s a MiddleName alapj�n)
			c.	Term�kkateg�ria neve,
			d.	�v (DueDate alapj�n),
			e.	Kedvezm�ny n�lk�li (SpecialOfferID=1) forgalom (LineTotal)
			f.	Kedvezm�nyes (SpecialOfferID>1) forgalom (LineTotal)
			g.	Teljes forgalom � a SpecialOfferID-t�l f�ggetlen�l */
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

