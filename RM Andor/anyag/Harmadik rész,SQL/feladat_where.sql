1. Kérdezd le a teljes Production.Product táblát!

SELECT * FROM [Production].[Product]

2. Kérdezd le a Name, Color, Size és ListPrice oszlopokat a Production.Product táblából!

SELECT P.Name, P.Color, P.Size, P.ListPrice
FROM Production.Product as P 

3. Kérdezd le azokat a termékeket, amiknek a színe ezüst, piros vagy kék! Írd meg két féle képpen is a lekérdezést!

SELECT * FROM Production.Product as P 
WHERE P.Color IN ('Silver', 'Red', 'Blue');

SELECT * FROM Production.Product as P 
WHERE P.Color = ('Silver', 'Red', 'Blue');

4. Kérdezd le azokat a termékeket, amiknek a neve a 'Touring' karaktersorral kezdődik!

SELECT * 
FROM Production.Product as P
WHERE P.Name LIKE 'Touring%';

5. Kérdezd le azokat a termékeket, amiknek a neve bárhol tartalmazza a 'Touring' karaktersort!

SELECT P.Name
FROM Production.Product as P
WHERE P.Name LIKE '%Touring%';

6. Kérdezd le azokat a termékeket, amiket 2011 január 1-e után kezdtünk el árusítani!

SELECT *
FROM Production.Product as P
WHERE P.SellStartDate >= '2011-01-01T00:00:00.000'

7. Kérdezd le azokat a termékeket, amiket 2011 január 1-e és 2013 január 1-e között kezdtünk el árusítani!

SELECT *
FROM Production.Product as P
WHERE P.SellStartDate >= '2011-01-01T00:00:00.000'
AND P.SellStartDate <= '2013-01-01T00:00:00.000';

WHERE P.SellStartDate BETWEEN '2011-01-01T00:00:00.000' AND '2013-01-01T00:0

8. Kérdezd le az összes termék nevét, színét és méretét úgy, hogy az oszlopfejléceket nevezd át a 'ProductName', 'ProductColor' és 'ProductSize értékekre!

SELECT P.Name AS ProductName, P.color AS ProductColor, P.Size AS ProductSize
FROM Production.Product AS P;

9. Kérdezd le az összes olyan terméket, aminek sem a színét, sem a méretét nem ismerjük!

SELECT * 
FROM Production.Product as P
Where P.Color IS NULL AND P.Size IS NULL;

10. Kérdezd le az összes olyan terméket, amiket 2011-ben vagy bármelyik év májusában kezdtünk el árusítani!

SELECT * 
FROM Production.Product as P
WHERE YEAR(P.SellStartDate) = 2011 OR MONTH(P.SellStartDate) =5;

11. Kérdezd le az összes olyan terméket, amit 2012-ben vagy azután kezdtünk el árusítani, a színe piros, kék vagy fekete, az ára 1000 és 1400 között van, és a nevük tartalmazza bárhol a 'Touring' karaktersort!

SELECT * FROM Production.Product as P
WHERE YEAR(P.SellStartDate) >= 2012
	AND P.Color IN ('Red', 'Blue', 'Black')
	AND P.ListPrice BETWEEN 1000 AND 1400
	AND P.Name LIKE '%Touring%';