
1. 

select p.BusinessEntityID "Személy Kódja", CONCAT(P.FirstName,' ',P.MiddleName,' ',P.LastName)  "Személy neve", pea.EmailAddress "E-mail Cím"
from Person.Person P
join Person.EmailAddress PEA
on p.BusinessEntityID = pea.BusinessEntityID
where p.EmailPromotion is not null
order by [Személy neve] 

2.

SELECT PP.BusinessEntityID AS 'Személy kódja',
    CONCAT(PP.LastName,' '+ COALESCE(PP.MiddleName + ' ', ''), PP.FirstName) AS 'Személy neve',
    COUNT(PBE.AddressID) AS 'Címek darabszáma'
FROM Person.Person PP
    JOIN Person.BusinessEntityAddress PBE 
        ON PP.BusinessEntityID = PBE.BusinessEntityID
GROUP BY PP.BusinessEntityID, CONCAT(PP.LastName,' '+ COALESCE(PP.MiddleName + ' ', ''), PP.FirstName)
    HAVING COUNT(PBE.AddressID) > 1
ORDER BY 'Személy neve'


3.

select sod.ProductID "Termék Kódja", p.Name "Termék neve", avg(sod.unitprice) "Átlagos egységár"
from Sales.SalesOrderDetail SOD
join Production.Product P
on p.ProductID = sod.ProductID
group by sod.ProductID, p.Name
order by p.Name

------------------------------------------------------------------------------------------------------------------------------------------------------------

1. feladat
Készíts listát azokról a személyekről (Person.Person tábla) és a hozzájuk tartozó e-mail címekről (Person.EmailAddress tábla), akik engedélyezték, hogy e-mailben ajánlatokat küldjenek nekik (Person.EmailPromotion értéke nem nulla)
A megjelenítendő mezők: - Személy kódja (Person.BusinessEntityID)
- Személy neve (LastName, MiddleName és FirstName összefűzve egyetlen oszlopban)
- E-mail cím (EmailAddress.EmailAddress)
A listát a személy nevére rendezd!"
6 pont

2. feladat
Írasd ki azoknak a személyeknek a nevét a Person.Person táblából, akiknek legalább két címük (AddressID) található a Person.BusinessEntityAddress táblában. A megjelenítendő mezők:
- Személy kódja (Person.BusinessEntityID) - Személy neve (LastName, MiddleName és FirstName összefűzve egyetlen oszlopban) - Címek darabszáma (azaz hány különböző AddressID található az adott személyhez) Rendezd a listát a személy nevére!
7 pont

3. feladat
Készíts lekérdezést, ami megjeleníti a vevői rendeléstételekben (Sales.SalesOrderDetail) szereplő termékeket (SalesOrderDetail.ProductID) a termék nevével és az átlagos egységárával együtt. A megjelenítendő mezők:
- Termék kódja (ProductID), - Termék neve (Production.Product táblából a Name oszlop),
- Átlagos egységár (SalesOrderDetail.UnitPrice alapján)
Az eredmény legyen a termék nevére rendezve!
7 pont