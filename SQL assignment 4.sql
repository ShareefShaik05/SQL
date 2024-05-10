use AdventureWorks2019;

/*Q1*/
select p.Color, p.Size, PM.CatalogDescription
from Production.ProductModel pm
inner join Production.Product p on  p.ProductModelID = pm.ProductModelID;

/*Q2*/
select p.ProductID, sod.SalesOrderDetailID, *
from Production.Product p left join Sales.SalesOrderDetail sod on p.ProductID = sod.ProductID;

/*Q3*/
select sp.BusinessEntityID, pp.ProductID 
from Sales.SalesPerson sp 
join
Sales.SalesOrderHeader soh on sp.BusinessEntityID = soh.SalesPersonID 
join
Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID 
join
Production.Product pp on sod.ProductID = pp.ProductID;

/*Q4*/
select p.Name, sod.SalesOrderID 
from Production.Product p LEFT OUTER JOIN Sales.SalesOrderDetail sod on p.ProductID = sod.ProductID 
union
select p.Name, sod.SalesOrderID 
from Sales.SalesOrderDetail sod LEFT OUTER JOIN Production.Product p on sod.ProductID = p.ProductID 
where p.ProductID IS NULL;