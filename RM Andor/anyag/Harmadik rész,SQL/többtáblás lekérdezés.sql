/* Két tábla összekapcsolása: csak azok, ahol valóban megvan az ON szerinti
	párosítás */
SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID;

/* Két tábla összekapcsolása: ahol megvan az ON szerinti párosítás, vagy
	azok a sorok a bal oldali táblából (ami a FROM után van), amihez nem
	lehetett a jobb oldali táblából sort párosítani */
SELECT P.ProductID, P.Name AS ProductName, PSC.Name AS SubcategoryName
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