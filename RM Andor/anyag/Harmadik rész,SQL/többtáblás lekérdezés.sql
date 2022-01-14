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