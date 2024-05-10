use AdventureWorks2019

/*1.	Identify (list) the tables containing the relevant data.*/
/*
Sales.Customer
Sales.Currency
Sales.SalesOrderHeader
Sales.SalesOrderDetail
Person.Address
Person.StateProvince
Person.CountryRegion 
*/

/*2.	Produce a list of customers living in France. The list should include: CustomerID, FirstName, LastName, Address, City, Zip, Province Name, and country.*/
SELECT c.customerID, p.FirstName, p.LastName, a.AddressLine1, a.AddressLine2, a.City, 
a.PostalCode AS Zip, sp.Name AS ProvidenceName, cr.Name AS Country 
FROM Sales.Customer AS c, Person.Person AS p, Sales.SalesOrderHeader AS soh, 
Person.Address AS a, Person.StateProvince AS sp, Person.CountryRegion AS cr 
WHERE p.BusinessEntityID = c.CustomerID and p.BusinessEntityID = soh.CustomerID 
and soh.BillToAddressID =a.AddressID and a.StateProvinceID = sp.StateProvinceID 
and cr.CountryRegionCode =sp.CountryRegionCode
and cr.Name = 'France';

/*3.	Produce a list of customers with number of orders placed and dollars spent. The list can include only the CustomerID, Number of Orders, and Total Money Spent columns. */
SELECT c.CustomerID, COUNT(DISTINCT soh.SalesOrderID) AS [Number of Orders], 
SUM(sod.LineTotal) AS [Total Money Spent]
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY c.CustomerID;

/*4.	Produce a list of customers that can be utilized for your RFM analysis. The list needs to include CustomerID, first and last name, city, country, number of orders, total dollars spent, and last order date. The list needs to be limited to the search criteria specified above.*/
SELECT sc.CustomerID,pp.FirstName, pp.LastName, pa.City, pcr.Name AS  'Country',
Count(sso.SalesOrderID) AS 'Number of Orders', SUM (sso.TotalDue) AS 'Dollars Spent', MAX (soh.OrderDate) AS 'Last Order Date'
FROM sales.Customer AS sc, person.Person AS pp, sales.SalesOrderHeader AS soh, person.Address AS pa, Person.StateProvince AS psp, 
Person.CountryRegion AS pcr, Sales.SalesOrderHeader AS sso
WHERE pp.BusinessEntityID = sc.CustomerID and pp.BusinessEntityID = soh.CustomerID and soh.BillToAddressID = pa.AddressID
and pa.StateProvinceID = psp.StateProvinceID and pcr.CountryRegionCode = psp.CountryRegionCode and sc.CustomerID = sso.CustomerID
and pcr.Name = 'France'
GROUP BY sc.CustomerID, pp.FirstName,pp.LastName, pa.City,pcr.Name, soh.OrderDate
ORDER BY soh.OrderDate DESC;
