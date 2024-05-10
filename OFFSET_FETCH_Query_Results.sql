--TOP OFFSET-FETCH

select top (3) orderid, custid, empid, orderdate
from Sales.Orders
order by orderdate desc;

select top (1) percent orderid, custid, empid, orderdate
from Sales.Orders
order by orderdate desc;

select top (3) with ties orderid, custid, empid, orderdate
from Sales.Orders
order by orderdate desc;

declare @n as bigint = 5;

select top (@n) with ties orderid, orderdate, custid, empid
from Sales.Orders
order by orderdate desc;


select orderid, orderdate, custid, empid
from Sales.Orders
order by orderdate desc, orderid desc
offset 50 rows fetch next 25 rows only;

select orderid, orderdate, custid, empid
from Sales.Orders
order by orderdate asc, orderid asc
offset 0 rows fetch next 25 rows only;


