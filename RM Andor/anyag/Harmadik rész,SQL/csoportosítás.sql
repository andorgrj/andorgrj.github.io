/*
	Kifejezések használata lekérdezésekben:
	szeretnék egy olyan lekérdezést, amiben a termék neve és a product number egy oszlopban
	szerepel, ilyen formában
	'név (productNumber)'
*/
SELECT P.Name + ' (' + P.ProductNumber + ')', P.Color, P.ListPrice
	FROM Production.Product P
	WHERE P.ListPrice IS NOT NULL;

/* Számokkal kapcsolatos műveleteket is lehet használni kifejezésekben:
	+ összeadás
	- kivonás
	* szorzás
	/ osztás
	% egész számos osztásnál a maradék
*/
SELECT P.Name, P.ListPrice / P.Weight AS UnitPrice
	FROM Production.Product P
	WHERE P.ListPrice IS NOT NULL AND P.Weight IS NOT NULL;


-------------------------------------------------------------------------------------------------------
/* COUNT: megszámolja az oszlopban hány nem null elem van
	- praktikusan az elsõdleges kulcsra rakjuk gyakran */
/* GROUP BY: a SELECT eredményét csoportosítja/összevonja a megadott oszlop alapján */
SELECT P.Color, COUNT(P.ProductID) AS Quantity
	FROM Production.Product P
	GROUP BY P.Color;

/* MIN: az adott oszlopból a legkisebb nem-null elem */ 
SELECT P.Color, MIN(P.ListPrice) AS MinPrice
	FROM Production.Product P
	GROUP BY P.Color;

/* MAX: az adott oszlopból a legnagyobb nem-null */
SELECT P.Color, MAX(P.ListPrice) AS MaxPrice
	FROM Production.Product P
	GROUP BY P.Color;

/* SUM: az adott oszlopban szereplõ nem-null értékek összege */
SELECT P.Color, SUM(P.ListPrice) AS SumPrice
	FROM Production.Product P
	GROUP BY P.Color;

/* AVG: az adott oszlopban szereplõ nem-null értékek átlaga */
SELECT P.Color, AVG(P.ListPrice) AS AveragePrice
	FROM Production.Product P
	GROUP BY P.Color;

/* aggregate function-ök mûködnek GROUP BY nélkül is */
SELECT MAX(P.ListPrice) FROM Production.Product P;

/* Lehet több kategória szerint is csoportosítani */
SELECT P.Color, P.Size, COUNT(P.ProductID) AS Quantity, SUM(P.ListPrice) AS SumPrice
	FROM Production.Product P
	GROUP BY P.Color, P.Size;

/*
	1. WHERE kulcsszó: még a csoportosítás és az aggregate-ek kiszámolása elõtt 
		kiszûr sorokat
	2. GROUP BY szerint csoportosítunk, kiszámoljuk az aggregate-ek eredményét
	3. HAVING: kiszûrjük az összesített adatokból a megfelelõeket
*/
SELECT P.Color, AVG(P.ListPrice) AS AveragePrice
	FROM Production.Product P
	WHERE P.Name LIKE '%a%' -- ez a szûrési feltétel még az eredeti tábla oszlopaira
	GROUP BY P.Color HAVING AVG(P.ListPrice) > 100; -- ez a feltétel az összesített adatokra

/* példa több táblás group by-re: pont ugyanúgy kell, mint egy táblás lekérdezésben */
SELECT PSC.Name AS SubcategoryName, P.Color, COUNT(P.ProductID) AS Quantity
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	GROUP BY PSC.Name, P.Color;

--------------------------------------------------------------------------------------------------------------

    SELECT P.Name, P.Color
	FROM Production.Product AS P
	WHERE P.Color = 'Red';

	SELECT P.Color
	FROM Production.Product AS P
	GROUP BY P.Color;

    SELECT P.Color, COUNT(P.ProductID)              megszámolja, hogy az oszlopban hány nem null van
	FROM Production.Product AS P
	GROUP BY P.Color;

    SELECT P.Color, MIN(P.ListPrice) AS MinPrice
	FROM Production.Product AS P
	GROUP BY P.Color;

	SELECT P.Color, MAX(P.ListPrice) AS MaxPrice
	FROM Production.Product AS P
	GROUP BY P.Color;

    SELECT P.Color, AVG(P.ListPrice) AS AveragePrice
	FROM Production.Product AS P
	GROUP BY P.Color;

    
    SELECT P.Color, AVG(P.ListPrice) AS AveragePrice
	FROM Production.Product P
	WHERE P.Name LIKE '%a%'
	GROUP BY P.Color HAVING AVG(P.ListPrice) > 100;

	SELECT P.Name + ' (' + P.ProductNumber + ')' , P.Color, P.ListPrice     -> szöveg összefűzése (oszlopok neve szerint vannak összefűzve)
	FROM Production.Product P
	WHERE P.ListPrice IS NOT NULL AND P.Weight IS NOT NULL