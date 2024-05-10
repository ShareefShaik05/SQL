select * from region;
select StoreID,StoreZIP from store;
select CustomerName,CustomerZIP from customer order by CustomerName;

#4
select * from region where RegionID in (select RegionID from store);
#5
select * from store where RegionID='C';
#6
select CustomerID,CustomerName from customer where CustomerName like 'T%';
#7
select ProductID, ProductName,ProductPrice from product where ProductPrice>=100;
#8
select ProductID, ProductName,ProductPrice,VendorName from product p, vendor v where p.VendorID=v.VendorID order by ProductID;
#9
select ProductID, ProductName,ProductPrice,VendorName,CategoryName from product p, vendor v,category c where p.VendorID=v.VendorID and p.CategoryID=c.CategoryID order by ProductID;
#10
select ProductID, ProductName,ProductPrice from product p,category c where  p.CategoryID=c.CategoryID and c.CategoryName='Camping' order  by ProductID;
#11
select * from product p, includes i, salestransaction s, store st where p.ProductID=i.ProductID and i.TID=s.TID and s.StoreID=st.StoreID and st.StoreZIP=60600 order by p.ProductID;


select * from product
select StoreZIP from store

select ProductID, ProductName,ProductPrice from product p,vendor v where p.VendorID=v.VendorID and VendorName='Pacifica Gear'
#12
select distinct p.ProductID,p.ProductName,p.ProductPrice from product p, includes i, salestransaction s, store st,vendor v,region r where  p.VendorID=v.VendorID and VendorName='Pacifica Gear' and p.ProductID=i.ProductID and i.TID=s.TID and s.StoreID=st.StoreID and st.RegionID=r.RegionID and r.RegionName='Tristate' order by p.ProductID;

#13
select s.TID,c.CustomerName,TDATE from salestransaction s, customer c,includes i,product p where s.CustomerID=c.CustomerID and s.TID=i.TID and i.ProductID=p.ProductID and p.ProductName='Easy Boot'
#14
select r.RegionID,r.RegionName,count(s.StoreID) Number_of_stores from  region r, store s  where r.RegionID=s.RegionID group by r.RegionID,r.RegionName
#15
select c.CategoryID,CategoryName,avg(p.ProductPrice) average_price_of_a_product from category c,product p where c.CategoryID=p.CategoryID group by c.CategoryID,CategoryName ;

#16
select c.CategoryID,count(p.ProductID) Total_number_of_items from category c,product p, salestransaction s, includes i where c.CategoryID=p.CategoryID and p.ProductID=i.ProductID and i.TID=s.TID group by  c.CategoryID;

#17
SELECT r.RegionID, r.RegionName, SUM(i.Quantity * p.ProductPrice) AS AmountSpent
FROM region r
JOIN store st ON r.RegionID = st.RegionID
JOIN salestransaction s ON st.StoreID = s.StoreID
JOIN includes i ON i.TID=s.TID
JOIN product p ON i.ProductID = p.ProductID
GROUP BY r.RegionID, r.RegionName;

#18
select s.TID, sum(i.Quantity) Total_number_of_items from salestransaction s, includes i where s.TID=i.TID group by s.TID having sum(i.Quantity)>5


#19
SELECT v.VendorID, v.VendorName, SUM(i.Quantity * p.ProductPrice) AS TotalSales
FROM vendor v
JOIN product p ON v.VendorID = p.VendorID
JOIN includes i ON i.ProductID=p.ProductID
JOIN salestransaction s ON i.TID = s.TID
GROUP BY v.VendorID, v.VendorName
HAVING SUM(i.Quantity * p.ProductPrice) > 700;


#20
select ProductID,ProductName,ProductPrice from product where ProductPrice=(select min(ProductPrice) from product);

#21
select ProductID,ProductName,ProductPrice,VendorName from product p, vendor v where p.VendorID=v.VendorID and p.ProductPrice<(select avg(ProductPrice) from product);

#22
SELECT p.ProductID, p.ProductName
FROM product p
JOIN includes i ON p.ProductID=i.ProductID
JOIN salestransaction s ON i.TID = s.TID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(i.Quantity) > 2;

#23
SELECT TOP 1 ProductID
FROM salestransaction s, includes i
where s.TID=i.TID
GROUP BY ProductID
ORDER BY SUM(Quantity) DESC ;

#24
select p.ProductID,p.ProductName,p.ProductPrice from product p inner join includes i on p.ProductID=i.ProductID group by p.ProductID,p.ProductName,p.ProductPrice having sum(i.Quantity)>3;


#25
select p.ProductID,p.ProductName,p.ProductPrice from product p inner join includes i on p.ProductID=i.ProductID group by p.ProductID,p.ProductName,p.ProductPrice having count(i.TID)>1;
