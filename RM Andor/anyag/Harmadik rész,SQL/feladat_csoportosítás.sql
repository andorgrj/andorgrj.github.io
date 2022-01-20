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











--------------------------------------------------------------------------------------------------------------------------------------------------------------

	SELECT *
	FROM crime_scene_report AS C
	WHERE DATE = '20180115'
	GROUP BY C.Type;

Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

SELECT *
	FROM person AS P
	WHERE P.address_street_name LIKE 'Northwestern Dr'
	ORDER BY P.address_number DESC;

SELECT *
	FROM get_fit_now_member G
	WHERE G.Name LIKE 'Morty Schapiro';

SELECT *
	FROM person G
	WHERE G.Name LIKE 'Morty Schapiro'; id = 14887

SELECT *
	FROM interview I
	WHERE I.person_id LIKE '14887';

I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

SELECT *
	FROM get_fit_now_member F
	WHERE id LIKE '48Z%';

48Z7A	28819	Joe Germuska	20160305	gold
48Z55	67318	Jeremy Bowers	20160101	gold

SELECT *
	FROM drivers_license L
	WHERE L.plate_number LIKE '%H42W%';

SELECT *
	FROM person G
	WHERE G.name LIKE '%Annabel%';

16371	Annabel Miller	490173	103	Franklin Ave	318771143

SELECT *
	FROM get_fit_now_check_in I
	WHERE I.check_in_date = '20180109';

SELECT *
	FROM get_fit_now_member G
	WHERE G.name LIKe '%Annabel%';

90081	16371	Annabel Miller	20160208	gold

SELECT *
	FROM get_fit_now_member M
	JOIN drivers_license DS
		ON M.id = DS.id 
	WHERE DS.plate_number LIKE '%H42W%';


SELECT *
	FROM drivers_license
	WHERE plate_number LIKE '%H42W%';

183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius
423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS
664760	21	71	black	black	male	4H42WR	Nissan	Altima

28819	Joe Germuska	173289	111	Fisk Rd	138909730
67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279

SELECT *
	FROM interview i
	WHERE i.person_id = '67318';

	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.              


SELECT *
	FROM drivers_license d
	WHERE d.car_make LIKE '%Tesla%'
	WHERE d.gender;

SELECT *
	FROM drivers_license d
	WHERE d.car_model LIKE '%Model S%'
	AND d.gender = 'female'
	AND d.height BETWEEN 65 AND 67;

202298	68	66	green	red	female	500123	Tesla	Model S
291182	65	66	blue	red	female	08CM64	Tesla	Model S
918773	48	65	black	red	female	917UU3	Tesla	Model S