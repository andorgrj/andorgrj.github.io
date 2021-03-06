-- Keressük meg azt, hogy melyek azok a színek, amelyekből nem létezik bicikli.
-- Egy adott alkategóriában, pedig más alkategóriában van ilyen színű bicikli.
-- Példa: nincs kék (blue) bicikli se road bikes, se mountain bikes, csak a touring bikes között.


SELECT DISTINCT SC.ProductSubcategoryID, SC.Color 
FROM Production.Product P
RIGHT JOIN 
	(SELECT PS.ProductSubcategoryID, C.Color
		FROM Production.ProductSubcategory PS
		CROSS JOIN 
			(SELECT DISTINCT Color
			FROM Production.Product P
			WHERE P.ProductSubcategoryID IN (1,2,3)) C
		WHERE PS.ProductCategoryID = 1) SC 
	ON P.ProductSubcategoryID = SC.ProductSubcategoryID AND P.Color = SC.Color
WHERE P.ProductSubcategoryID IS NULL

