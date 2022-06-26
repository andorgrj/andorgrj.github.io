1. Jelenítsd meg a termékek és a hozzájuk tartozó alkategória nevét. Ha egy terméknek nincs alkategóriája, akkor kihagyhatod.

SELECT P.Name AS ProductName, PSC.Name AS SubcategoryName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductCategoryID;

2. Jelenítsd meg a termékek és a hozzájuk tartozó főkategória nevét. Azokat a termékeket is jelenítsd meg, amiknek nincs kategóriája.

SELECT P.Name AS ProductName, PC.Name AS CategoryName
	FROM Production.Product P
	LEFT JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID;

3. Jelenítsd meg azon termékek nevét, amik a 'Bikes' vagy a 'Clothing' főkategóriába tartoznak.

SELECT P.Name AS ProductName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
	WHERE PC.Name IN ('Bikes' , 'Clothing');

4. Jelenítsd meg a termékek ID-ját, nevét és alkategóriájának nevét, az alkategória neve szerint növekvő, majd azon belül ár szerint csökkenő sorrendben.

SELECT P.Name AS ProductName, P.Name AS CategoryName
	FROM Production.Product P
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	ORDER BY PSC.Name ASC, P.ListPrice DESC;

5. Jelenítsd meg azon raktárhelységek nevét, ahol van legalább egy olyan termék, amiből több, mint 500 darab van ott tárolva. Bónusz: egy név csak egyszer legyen megjelenítve.
Hint: a Location és a ProductInventory táblákra lesz szükséged.

SELECT DISTINCT L.Name		- ha több azonos van csak egyet jelenít meg belőle
	FROM Production.Location L
	JOIN Production.ProductInventory I
		ON L.LocationID = I.LocationID
	WHERE I.Quantity > 500;

6. Jelenítsd meg a termékek nevét és hogy milyen raktárhelyiségben hány darabot tárolunk belőlük, a darabszám szerint csökkenő, a termék szerint növekvő, majd a raktárhelyiség neve szerint növekvő sorrendben.

SELECT P.Name AS ProductName, L.Name AS LocationName, I.Quantity
	FROM Production.Product P
	JOIN Production.ProductInventory I
		ON P.ProductID = I.ProductID
	JOIN Production.Location L
		ON I.LocationID = L.LocationID
	ORDER BY I.Quantity DESC, P.Name ASC, L.Name ASC;

7. Jelenítsd meg a 20 legdrágább termék nevét, a raktárhelyiség nevét, ahol tároljuk és a darabszámot, amit ott tárolunk.

SELECT P.Name AS ProductName, L.Name AS LocationName, I.Quantity
	FROM Production.Product P
	JOIN Production.ProductInventory I
		ON P.ProductID = I.ProductID
	JOIN Production.Location L
		ON I.LocationID = L.LocationID
	ORDER BY P.ListPrice DESC
	OFFSET 0 ROWS
	FETCH FIRST 20 ROWS ONLY;

8. Jelenítsd meg a raktárhelyiség nevét, a termék nevét, a tárolt darabszámot és az alkategória nevét a 20 legolcsóbb termékről, amiknek az ára legalább 1000 és a 'Bikes' kategóriába tartoznak.

SELECT L.Name AS LocationName, P.Name AS ProductName, I.Quantity, PSC.Name AS SubcategoryName
	FROM Production.Product P
	JOIN Production.ProductInventory I
		ON P.ProductID = I.ProductID
	JOIN Production.Location L
		ON I.LocationID = L.LocationID
	JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
	JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
	WHERE P.ListPrice >= 1000 AND PC.Name = 'Bikes'
	ORDER BY P.ListPrice ASC
	OFFSET 0 ROWS
	FETCH FIRST 20 ROWS ONLY;

