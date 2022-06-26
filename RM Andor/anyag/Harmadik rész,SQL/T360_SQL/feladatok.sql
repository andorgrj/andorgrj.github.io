1. /1. /* Készíts listát az alkalmazottakról az alábbi adatokkal:
        a.    BusinessEntityID, 
        b.    PersonName (a LastName, FirstName és a MiddleName alapján), 
        c.    EmailAddress, 
        d.    PhoneNumber (PhoneType.Name), például 181-555-0156 (Work).
        e.    Rendezd a címlistát az alkalmazott nevére. */

SELECT HRE.BusinessEntityID, CONCAT(PP.FirstName,' ',PP.MiddleName,' ',PP.LastName) AS PersonName, PE.EmailAddress,
CONCAT(PPP.PhoneNumber,' (',PNT.Name,')') AS PhoneNumber
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON HRE.BusinessEntityID = PP.BusinessEntityID
JOIN Person.EmailAddress AS PE ON PP.BusinessEntityID = PE.BusinessEntityID
JOIN Person.PersonPhone AS PPP ON PE.BusinessEntityID = PPP.BusinessEntityID
JOIN Person.PhoneNumberType AS PNT ON PPP.PhoneNumberTypeID = PNT.PhoneNumberTypeID
ORDER BY PersonName


1. /2. /* Kik azok az alkalmazottak, akiknek ma van a születésnapjuk. Megjelenítendő mezők:
        a.    BusinessEntityID
        b.    PersonName (a LastName, FirstName és a MiddleName alapján)
        c.    BirthDate
        d.    A lista az alkalmazott nevére legyen rendezve. */

SELECT HRE.BusinessEntityID, HRE.BirthDate, CONCAT(PP.FirstName,' ',PP.MiddleName,' ',PP.LastName) AS PersonName
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON HRE.BusinessEntityID = PP.BusinessEntityID
WHERE MONTH(HRE.BirthDate) = MONTH(GETDATE()) AND DAY(HRE.BirthDate) = DAY(GETDATE())
ORDER BY PersonName


1. /3. /* Listázd ki azokat az alkalmazottakat, akik több részlegnél (Department) is dolgoztak. 
       Csak a BusinessEntityID és a PersonName jelenjen meg a listában – a személy nevére rendezve.*/ 

SELECT DISTINCT EDH.BusinessEntityID, CONCAT(PP.FirstName,' ',PP.MiddleName,' ',PP.LastName) AS PersonName
FROM HumanResources.EmployeeDepartmentHistory AS EDH
JOIN Person.Person AS PP ON EDH.BusinessEntityID = PP.BusinessEntityID
GROUP BY EDH.BusinessEntityID, PP.FirstName, PP.MiddleName, PP.LastName
HAVING COUNT (EDH.BusinessEntityID) > 1
ORDER BY PersonName


1. /4. /* Listázd ki azokat az alkalmazottakat, akik jelenleg egyedüliként dolgoznak egy részleg (Department) egy műszakjában (Shift). 
       A BusinessEntityID, a PersonName, a Department és a Shift neve (Day, Evening vagy Night) jelenjen meg a listában – a személy nevére rendezve.*/

SELECT MIN(EDH.BusinessEntityID) AS BusinessEntityID, MIN(CONCAT(PP.FirstName,' ',PP.MiddleName,' ',PP.LastName)) AS PersonName, HRD.Name AS Department, HRS.Name AS 'Shift'
FROM HumanResources.EmployeeDepartmentHistory EDH
JOIN HumanResources.Department HRD ON EDH.DepartmentID = HRD.DepartmentID
JOIN HumanResources.Shift HRS ON EDH.ShiftID = HRS.ShiftID
JOIN HumanResources.Employee AS HRE ON EDH.BusinessEntityID = HRE.BusinessEntityID
JOIN Person.Person PP ON HRE.BusinessEntityID = PP.BusinessEntityID
GROUP BY HRD.Name, HRS.Name
HAVING COUNT(HRD.Name) = 1 AND COUNT(HRS.Name) = 1
ORDER BY PersonName


2. /1. /* Készíts címlistát a szállítókról (vendorokról) az alábbi adatokkal:
        a.    BusinessEntityID, 
        b.    VendorName, 
        c.    Vendor címe (Main office= 3-as AddressTypeID) az alábbi formában: CountryName, StateProvinceCode, PostalCode, City, AddressLine1, AddressLine2
        d.    CreditRating (szövegesen: 1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average)
        e.    Rendezd a címlistát a vendor nevére. */
SELECT PV.BusinessEntityID, PV.Name, CONCAT(CR.Name,', ',SP.StateProvinceCode,', ',PA.PostalCode,', ',PA.City,', ',PA.AddressLine1,', ' + PA.AddressLine2) AS Address,
       CASE PV.CreditRating
        WHEN 1 THEN 'Superior'
        WHEN 2 THEN 'Excellent'
        WHEN 3 THEN 'Above average'
        WHEN 4 THEN 'Average'
        WHEN 5 THEN 'Below average'
        END AS CreditRating
FROM Purchasing.Vendor AS PV
JOIN Person.BusinessEntityAddress AS PBA ON PV.BusinessEntityID = PBA.BusinessEntityID
JOIN Person.Address AS PA ON PBA.AddressID = PA.AddressID
JOIN Person.AddressType AS PAT ON PBA.AddressTypeID = PAT.AddressTypeID
JOIN Person.StateProvince AS SP ON PA.StateProvinceID = SP.StateProvinceID
JOIN Person.CountryRegion AS CR ON SP.CountryRegionCode = CR.CountryRegionCode
ORDER BY PV.Name


2. /3. /* Listázd ki azokat a forgalmazott (SellEndDate üres) termékeket, amelyek jelenleg egyetlen szállítótól sem rendelhetők. 
        Megjelenítendő mezők: a termék neve, termékszáma (ProductNumber), listaára (ListPrice). Rendezés a termék nevére történjen. */
        
SELECT PP.ProductNumber, PP.Name, PP.ListPrice
FROM Production.Product AS PP
WHERE PP.SellEndDate IS NULL
EXCEPT
SELECT PP.ProductNumber, PP.Name, PP.ListPrice
FROM Production.Product AS PP
JOIN Purchasing.ProductVendor AS PV ON PP.ProductID = PV.ProductID
WHERE PP.SellEndDate IS NULL
ORDER BY PP.Name


2. /4. /* Készíts listát, amiben össze lehet vetni az egyes szállítási módok (ShipMethod) esetén a szállítási költségeket (Freight). 
    A szállítói rendeléseket (PurchaseOrder) a szállítási mód (ShipMethod), azon belül évente és havonta (ShipDate alapján) kell összegezni. 
    A megjelenítendő adatok:
        a.    A szállítási mód neve (Purchasing.ShipMethod.Name)
        b.    Év, hónap
        c.    Összes szállítási költség (Freight)
        d.    Összes termékköltség (SubTotal)
        e.    Az előző kettő alapján a szállítási költség százalékos értéke */

SELECT SM.Name, YEAR(POH.OrderDate) OrderYear, MONTH(POH.OrderDate) OrderMonth, SUM(POH.Freight) FreightSum, SUM(POH.SubTotal)SubTotalSum,
SUM(POH.Freight) / SUM(POH.SubTotal) * 100 FreightPercent
FROM Purchasing.PurchaseOrderHeader AS POH
JOIN Purchasing.ShipMethod AS SM ON POH.ShipMethodID = SM.ShipMethodID
GROUP BY SM.Name, YEAR(POH.OrderDate), MONTH(POH.OrderDate)
ORDER BY YEAR(POH.OrderDate), MONTH(POH.OrderDate)

SELECT SM.Name, YEAR(POH.ShipDate) OrderYear, MONTH(POH.ShipDate) OrderMonth, SUM(POH.Freight) FreightSum, SUM(POH.SubTotal)SubTotalSum,
SUM(POH.Freight) / SUM(POH.SubTotal) * 100 FreightPercent
FROM Purchasing.PurchaseOrderHeader AS POH
JOIN Purchasing.ShipMethod AS SM ON POH.ShipMethodID = SM.ShipMethodID
GROUP BY SM.Name, YEAR(POH.ShipDate), MONTH(POH.ShipDate)
ORDER BY YEAR(POH.ShipDate), MONTH(POH.ShipDate)