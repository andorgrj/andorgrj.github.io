-- NULL értékek matematikai műveletekben
DECLARE @Ár decimal(11,2) = 1340.20, 
		@Árszorzó decimal(3,2),
		@Áreltérítő decimal(9,2)
SELECT @Ár, @Ár + @Áreltérítő, @Ár * @Árszorzó

-- Helyettesítő érték alkalmazása a COALESCE függvénnyel
DECLARE @Ár1 decimal(11,2) = 1340.20, 
		@Árszorzó1 decimal(3,2),
		@Áreltérítő1 decimal(9,2)
SELECT @Ár1, @Ár1 + COALESCE(@Áreltérítő1,0), @Ár1 * COALESCE(@Árszorzó1,1)

-- NULL értékek szöveges műveletekben
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
	P.LastName + ' ' + P.MiddleName + ', ' + P.FirstName
FROM Person.Person P

-- NULL értékek szöveges műveletekben (a COALESCE függvénnyel korrigálva)
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
	P.LastName + ' ' + COALESCE(P.MiddleName,'') + ', ' + P.FirstName
FROM Person.Person P

-- NULL értékek szöveges műveletekben (a COALESCE függvénnyel korrigálva, a felesleges szóköz kinyesése)
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
	P.LastName + COALESCE(' ' + P.MiddleName,'') + ', ' + P.FirstName
FROM Person.Person P

-- 2012-től a CONCAT függvény egyszerűsíti a NULL kérdést
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
	CONCAT(P.LastName,' ' + P.MiddleName, ', ' + P.FirstName)
FROM Person.Person P

-- NULL probléma kezelése dátumoknál
SELECT PCH.*
FROM Production.ProductCostHistory PCH
WHERE GETDATE() > '20130101'

SELECT PCH.*
FROM Production.ProductCostHistory PCH
WHERE '20130101' /*GETDATE()*/ BETWEEN PCH.StartDate AND PCH.EndDate

-- Itt is a COALESCE függvény segít, de használhatjuk a T-SQL-ben az ISNULL függvényt is
SELECT PCH.*
FROM Production.ProductCostHistory PCH
WHERE GETDATE() BETWEEN PCH.StartDate AND ISNULL(PCH.EndDate,'99991231')

-- NULL probléma WHERE feltételben
SELECT *
FROM Production.Product P
WHERE P.Color = 'Red'
SELECT *
FROM Production.Product P
WHERE P.Color <> 'Red'

-- A megoldás az IS NULL beiktatása a WHERE feltételbe, ha a piros termékeken kívül az összes többi kell
SELECT *
FROM Production.Product P
WHERE P.Color <> 'Red' OR P.Color IS NULL
 
 -- Ha minden színes termék kell
SELECT *
FROM Production.Product P
WHERE P.Color IS NOT NULL

