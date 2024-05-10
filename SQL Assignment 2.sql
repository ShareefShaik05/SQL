use AdventureWorksLT2019;
/*Q1 */

SELECT ProductID, Name, ProductNumber, ListPrice, SellStartDate, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL
ORDER BY ListPrice DESC, ProductID ASC, SellStartDate ASC;


/*Q2 */

SELECT TOP 12 ProductID, Name, ProductNumber, ListPrice, SellStartDate, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL
ORDER BY ListPrice DESC, ProductID ASC, SellStartDate ASC;

/*Q3*/

SELECT TOP 12 PERCENT ProductID, Name, ProductNumber, ListPrice, SellStartDate, SellEndDate 
FROM salesLT.Product  
WHERE sellenddate is null 
ORDER BY sellstartdate, ListPrice DESC, ProductID ASC;

/*Q4*/

SELECT TOP 4 ProductID, Name, ProductNumber, ListPrice, SellStartDate, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL
ORDER BY ListPrice ASC;

/*Q5*/

SELECT ProductID, Name, ProductNumber, ListPrice, SellStartDate, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL
ORDER BY ListPrice DESC, ProductID ASC, SellStartDate ASC OFFSET 6 ROWS
	FETCH NEXT 10 ROWS ONLY;