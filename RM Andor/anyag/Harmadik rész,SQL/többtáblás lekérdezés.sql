/* Két tábla összekapcsolása: csak azok, ahol valóban megvan az ON szerinti
	párosítás */
SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName							ON -> milyen oszlopok mentén akarom összepárosítani a két táblámat
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;

/* Két tábla összekapcsolása: ahol megvan az ON szerinti párosítás, vagy
	azok a sorok a bal oldali táblából (ami a FROM után van), amihez nem
	lehetett a jobb oldali táblából sort párosítani */
SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName							-> így beadja azokat a sorokat is, ahol null az érték
	FROM Production.Product P
	LEFT JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;

/* Több tábla összekapcsolása ugyanígy, csak egymás mögé kell láncolni a
	JOIN utasításokat */
SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName,
		PC.Name AS CategoryName
	FROM Production.Product P
	LEFT JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID;

/* Összekapcsolt táblákban ugyanúgy lehet WHERE feltételek szerint szûrni.
	A felhasznált táblákból nem kötelezõ megjeleníteni minden oszlopot.
	Sõt, elõfordulhat, hogy egy táblát csak az összekötéshez használunk, de
	egyáltalán nem jelenítünk meg belõle.
	WHERE feltételeknél fel lehet használni bármelyik tábla oszlopait. */
SELECT P.Name AS ProductName, P.ListPrice, PC.Name AS CategoryName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
	WHERE PC.Name = 'Bikes';

/* Eredmények sorba rendezése valamelyik oszlop vagy oszlopok alapján */
SELECT P.ProductID, P.Name, P.ListPrice
	FROM Production.Product P
	ORDER BY P.ListPrice DESC, P.Name ASC;

/* Sorba rendezett eredmények közül csak valahány sor megmutatása.
	Fontos: az OFFSET-FETCH páros csak ORDER BY után mûködik. */
SELECT P.ProductID, P.Name, P.ListPrice
	FROM Production.Product P
	ORDER BY P.ListPrice DESC, P.Name ASC -- eszerint rendezünk
	OFFSET 20 ROW -- átugor ennyi sort az elejérõl
	FETCH FIRST 10 ROWS ONLY; -- megmutat ennyi sort

/* WHERE feltételekkel leszûrt eredmények sorbarendezése. */
SELECT P.ProductID, P.Name, P.ListPrice
	FROM Production.Product P
	WHERE P.ListPrice > 0
	ORDER BY P.ListPrice ASC
	OFFSET 0 ROWS
	FETCH FIRST 15 ROWS ONLY;
-------------------------------------------------------------------------------------------------------------------------
CROSS JOIN helyett ON kapcsoló

SELECT *
	FROM Production.ProductCategory
														/*-> ezt a két táblát CROSS JOINnal tudom összekapcsolni*/
SELECT * 
	FROM Production.ProductSubcategory

SELECT * 
	FROM Production.ProductCategory PC
	CROSS JOIN Production.ProductSubcategory PSC;

SELECT PC.Name, PSC.Name
	FROM Production.ProductCategory PC
	JOIN Production.ProductSubcategory PSC
	ON PC.ProductCategoryID = PSC.ProductcategoryID;   /*-> az ON használatával az ID-k alapján köti össze*/


-------------------------------------------------------------------------------------------------------------------------

SELECT *
	FROM Production.ProductCategory;

SELECT *
	FROM Production.ProductSubcategory;

SELECT P.Name AS Típus, PS.Name AS Altípus
	FROM Production.ProductSubcategory PS
	JOIN Production.ProductCategory P
	ON PS.ProductCategoryID = P.ProductCategoryID

	
-----------------------------------------------------------------------------------------------------------------------

SELECT *
	FROM Production.ProductCategory;

SELECT *
	FROM Production.ProductSubcategory;

SELECT PC.Name, PSC.Name 
FROM Production.ProductCategory PC
JOIN Production.ProductSubcategory PSC
	ON PC.ProductCategoryID = PSC.ProductCategoryID;



SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
	ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;


SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName
FROM Production.Product P
JOIN Production.ProductSubcategory PSC										- van termék és van kategória
	ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;

SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName
FROM Production.Product P
LEFT JOIN Production.ProductSubcategory PSC									- van termék és vagy van vagy nincs hozzá kategória
	ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;

SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName
FROM Production.Product P
RIGHT JOIN Production.ProductSubcategory PSC
	ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;

SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName
FROM Production.Product P
FULL OUTER JOIN Production.ProductSubcategory PSC
	ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;



SELECT P.Name AS ProductName, P.ListPrice
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
	WHERE PC.Name = 'Bikes';



SELECT P.Name, P.ListPrice
	FROM Production.Product P
	ORDER BY P.ListPrice;


SELECT P.Name, P.ListPrice
	FROM Production.Product P
	ORDER BY P.ListPrice DESC;


SELECT P.ProductID, P.Name, P.ListPrice
	FROM Production.Product P
	ORDER BY P.ListPrice DESC, P.Name ASC;


SELECT P.ProductID, P.Name, P.ListPrice         -> 10 legdrágább elemet hozza ki
	FROM Production.Product P
	ORDER BY P.ListPrice DESC, P.Name ASC
	OFFSET 0 ROW                                -> átugor ennyi sort az elejéről
	FETCH FIRST 10 ROWS ONLY;                   -> megmutat ennyi sort az elejéről



SELECT P.ProductID, P.Name, P.ListPrice			--15 legolcsóbb terméket jeleníti meg
	FROM Production.Product P
	WHERE P.ListPrice > 0
	ORDER BY P.ListPrice ASC
	OFFSET 0 ROWS
	FETCH FIRST 15 ROWS ONLY;

----------------------------------------------------------------------------------------------------------------------------------------------
-- Inner vagy Left join használata: kapcsolódó mező köteleő mező-e vagy nem, a left joinnal lehet a nullás mezőket is behúzni 
-- Termékek és alkategóriák együttes megjelenítése, az alkategóriába be nem sorolt termékek kimaradnak
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PS 
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID

-- Termékek és alkategóriák együttes megjelenítése (LEFT JOIN), minden termék megjelenik, azok is amelyek nincsenek alkategóriában
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
	FROM Production.Product P
	LEFT JOIN Production.ProductSubcategory PS 
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID

-- Termékek és alkategóriák együttes megjelenítése (RIGHT JOIN), minden termék megjelenik
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
	FROM Production.ProductSubcategory PS
	RIGHT JOIN Production.Product P 
	ON PS.ProductSubcategoryID = P.ProductSubcategoryID

-- Termékek és alkategóriák együttes megjelenítése (FULL JOIN), minden termék és minden alkategória megjelenik /RITKA!!!
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
	FROM Production.ProductSubcategory PS
	FULL JOIN Production.Product P 
	ON PS.ProductSubcategoryID = P.ProductSubcategoryID

-- Termékek, alkategóriák, főkategóriák és termékmodellek együttes megjelenítése (LEFT JOIN), 
-- minden termék megjelenik, de az árva alkategóriák, főkategóriák és modellek nem.
SELECT PC.ProductCategoryID CategoryID, PC.Name CategoryName,
	PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	PM.ProductModelID, PM.Name ModelName, 
	P.ProductID, P.Name ProductName, P.Color, P.ListPrice
	FROM Production.Product P
	LEFT JOIN Production.ProductSubcategory PS 
		ON P.ProductSubcategoryID = PS.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory PC 
		ON PS.ProductCategoryID = PC.ProductCategoryID
	LEFT JOIN Production.ProductModel PM 
		ON P.ProductModelID = PM.ProductModelID 