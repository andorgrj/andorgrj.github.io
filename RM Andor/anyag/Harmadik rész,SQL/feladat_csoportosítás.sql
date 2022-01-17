/* 1. Jelenítsd meg, hány termék van az adatbázisban aszerint csoportosítva, 
	hogy hány nap alatt lehet legyártani õket (DaysToManufacture)! */
SELECT P.DaysToManufacture, COUNT(P.ProductID) Quantity
	FROM Production.Product P
	GROUP BY P.DaysToManufacture;

/* 2. Jelenítsd meg gyártási idõ és színek szerint csoportosítva, hogy az egyes 
	kategóriákban hány termék van, valamint mennyibe kerül a legolcsóbb és a legdrágább! */
SELECT  P.DaysToManufacture, 
		P.Color, 
		COUNT(P.ProductID) Quantity,
		MIN(P.ListPrice) MinPrice,
		MAX(P.ListPrice) MaxPrice
	FROM Production.Product P
	GROUP BY P.DaysToManufacture, P.Color;

/* 3. Jelenítsd meg, hogy alkategóriákra bontva (ProductSubcategory) hány termék kapható 
	és mennyi az átlagos ár alkategóriánként! */
SELECT  PSC.Name AS SubcategoryName,
		COUNT(P.ProductID) AS Quantity,
		AVG(P.ListPrice) AS AveragePrice
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	GROUP BY PSC.Name;

/* 4. Jelenítsd meg, hogy fõkategóriákra bontva (ProductCategory) hány termék kapható és mennyi az átlagos ár fõkategóriánként! */
SELECT  PC.Name AS CategoryName,
		COUNT(P.ProductID) AS Quantity,
		AVG(P.ListPrice) AS AveragePrice
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
	GROUP BY PC.Name;

/* 5. Jelenítsd meg minden termék nevét, és hogy mennyi az összes készlet szummája belõle 
	(hint: ProductInventory)! */
SELECT P.Name, SUM(I.Quantity) AS SumQuantity
	FROM Production.Product P
	JOIN Production.ProductInventory I
		ON P.ProductID = I.ProductID
	GROUP BY P.Name;

/* 6. Jelenítsd meg minden termék nevét és színét együtt 'név - szín' formátumban,
	valamint a hozzá tartozó listaárat. Csak azokat a termékeket jelenítsd meg, 
	amiknek van színe! */
SELECT P.Name + ' - ' + P.Color AS NameAndColor, P.ListPrice 
	FROM Production.Product P
	WHERE P.Color IS NOT NULL;

/* 7. Jelenítsd meg az egyes raktárhelyiségek (Location) nevét, 
	a fõkategóriák nevét (ProductCategory), 
	és hogy az adott raktárban és az adott fõkategóriából hány fajta terméket árulunk. */
SELECT  L.Name AS LocationName,
		PC.Name AS CategoryName,
		COUNT(P.ProductID) AS Products
	FROM Production.Location L
	JOIN Production.ProductInventory I
		ON L.LocationID = I.LocationID
	JOIN Production.Product P
		ON I.ProductID = P.ProductID
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
	GROUP BY L.Name, PC.Name;