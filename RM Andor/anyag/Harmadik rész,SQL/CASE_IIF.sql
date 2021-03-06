/****** Script for SelectTopNRows command from SSMS  ******/
/* Ki kell listázni a termékek azonosítóját, nevét, listaárát, 
	valamint az alábbi transzformációs táblázat alapján az osztályát:
	+-------------------------------------+
	|  Class	|  Megjelenítendő szöveg  |
	+-------------------------------------+
	|    L		|	Low					  |
	|    M		|	Medium				  |
	|    H		|	High				  |
	|   NULL	|	N/A					  |
	+-------------------------------------+ */

SELECT P.ProductID, P.Name, P.ListPrice,
	CASE P.Class WHEN 'L' THEN 'Low'
				 WHEN 'M' THEN 'Medium'
				 WHEN 'H' THEN 'High'
				 ELSE 'N/A' END ClassName
FROM Production.Product P;

/* Ki kell listázni a termékek azonosítóját, nevét, listaárát, 
	valamint az alábbi transzformációs táblázat alapján az árkategóriát:
	+-------------------------------------+
	|  ListPrice		|  Megjelenítendő |
	+-------------------------------------+
	|  < 1000			|	Cheap		  |
	|>=1000 AND <3000	|	Medium		  |
	|  >= 3000			|	Expensive	  |
	+-------------------------------------+ */

SELECT P.ProductID, P.Name, P.ListPrice,
	CASE WHEN P.ListPrice < 1000 THEN 'Cheap'
		 WHEN P.ListPrice < 3000 THEN 'Medium'
		 ELSE 'Expensive' END PriceCategory
FROM Production.Product P;

/* Ki kell listázni a személyek vezetéknevét, keresztnevét és nemét
	M = Male, F = Female */

SELECT E.LoginID, E.BirthDate, E.Gender, IIF(E.Gender='M','Male','Female') GenderName   -> ha az e.gender M akkor az egyenlő Male, minden egyéb esetben female
	FROM HumanResources.Employee E;

/* Ki kell listázni egy paraméterként megadott év rendeléseit a Sales.SalesOrderHeader táblából
	A negyedév római számmal jelenjen meg. */

DECLARE @YEAR int = 2013
SELECT SOH.SalesOrderID, SOH.DueDate, CHOOSE(DATEPART(q,SOH.DueDate), 'I','II', 'III', 'IV') DueQuarter
FROM Sales.SalesOrderHeader SOH
WHERE YEAR(SOH.Duedate) = @YEAR;