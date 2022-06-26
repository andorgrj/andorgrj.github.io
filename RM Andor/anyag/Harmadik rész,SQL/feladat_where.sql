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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Jelenítsd meg a Product tábla ProductID, Name és ListPrice oszlopait! 

SELECT ProductID, Name, ListPrice
FROM Production.Product

Jelenítsd meg a Product tábla Name mezőjét, mellette zárójelben jelenjen meg a termék azonosítója (ProductNumber), a második oszlopban a termék listaára (ListPrice), és végül az eladás kezdetének éve, hónapja és napja külön-külön oszlopban (SellStartDate). 

SELECT Name + ' (' + ProductNumber + ') ', ListPrice, YEAR(SellStartDate),
MONTH(SellStartDate), DAY(SellStartDate)
FROM Production.Product

Készíts lekérdezést, amely kigyűjti a Product tábla azon termékeit, ahol a Size paraméter “M” értékű. Az eredmény tábla tartalmazza a termék nevét (Name), számát (ProductNumber), színét (Color) és méretét (Size)!

SELECT Name, ProductNumber, Color, Size
FROM Production.Product
WHERE Size = 'M'

Gyűjtsd ki azon termékek nevét (Name),  listaárát (ListPrice) és eladásának kezdeti dátumát (SellStartDate), amelyek SellStartDate mezője 2013. június előttre esik!

SELECT Name, ListPrice, SellStartDate
FROM Production.Product
WHERE SellStartDate < '20130601'

Az előző lekérdezést módosítsd úgy, hogy az adatsorok rendezve legyenek az eladás kezdeti dátuma, azon belül pedig a listaár alapján!

SELECT Name, ListPrice, SellStartDate
FROM Production.Product
WHERE SellStartDate < '20130601'
ORDER BY SellStartDate, ListPrice

Készíts lekérdezést, amely megjeleníti a nevét (Name), listaárát (ListPrice) és színét (Color) az összes terméknek, aminek a nevében szerepel a “Road” szöveg, és a színe piros vagy ezüst, esetleg fekete! 

SELECT Name, ListPrice, Color
FROM Production.Product
WHERE Name LIKE '%Road%' AND Color IN ('Red', 'Silver', 'Black')

Derítsük ki, hogy milyen értékei vannak a ProductLine oszlopnak! Nézzük meg, hogy azon belül milyen osztályúak lehetnek a termékek (Class)!

SELECT DISTINCT ProductLine, Class
FROM Production.Product

Jelenítsd meg a Person táblából a személyek neveit “Title FirstName MiddleName LastName” formátumban. Figyelj arra, hogy több helyen NULL értéket tárol a Title, vagy a MiddleName mező, ekkor ezt megfelelően kezeld, ne tartalmazzon felesleges szóközöket a végeredmény! 

SELECT CONCAT (P.Title, ' ' + FirstName, ' ' + MiddleName, ' ' + LastName)
	FROM Person.Person P;

Jelenítsd meg azon termékek Name, Weight, SellStartDate és SellEndDate adatait, melyek az átlag súlynál nehezebbek! Ahol a Weight mező NULL, azokat az értékeket ne vegyük figyelembe az átlag számításnál!

SELECT P.Name, P.Weight, P.SellStartDate, P.SellEndDate
	FROM Production.Product P
	WHERE P.Weight > (SELECT AVG(P2.Weight) FROM Production.Product P2 WHERE P2.Weight IS NOT NULL);

Módosítsd a lekérdezést úgy, hogy csak azok a rekordok jelenjenek meg, melyeknél a SellEndDate későbbi, mint 2012. december 31! Ahol a SellEndDate mező NULL értékű, az azt jelenti, hogy ez a feltétel igaz, tehát ezek az adatsorok is legyenek benne az eredménytáblában. 

SELECT P.Name, P.Weight, P.SellStartDate, P.SellEndDate
	FROM Production.Product P
	WHERE P.Weight > (SELECT AVG(P2.Weight) FROM Production.Product P2 WHERE P2.Weight IS NOT NULL)
		AND (SellEndDate > '20121231' OR SellEndDate IS NULL);