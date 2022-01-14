SELECT P.Name AS ProductName, PSC.Name AS SubcategoryName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductCategoryID;


SELECT P.Name AS ProductName, PC.Name AS CategoryName
	FROM Production.Product P
	LEFT JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID;


SELECT P.Name AS ProductName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
	WHERE PC.Name IN ('Bikes' , 'Clothing'); 


SELECT P.Name AS ProductName, P.Name AS CategoryName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	ORDER BY PSC.Name ASC, P.ListPrice DESC;


SELECT DISTINCT L.Name		- ha több azonos van csak egyet jelenít meg belőle
	FROM Production.Location L
	JOIN Production.ProductInventory I
		ON L.LocationID = I.LocationID
	WHERE I.Quantity > 500;


SELECT P.Name AS ProductName, L.Name AS LocationName, I.Quantity
	FROM Production.Product P
	JOIN Production.ProductInventory I
		ON P.ProductID = I.ProductID
	JOIN Production.Location L
		ON I.LocationID = L.LocationID
	ORDER BY I.Quantity DESC, P.Name ASC, L.Name ASC;