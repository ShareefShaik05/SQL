use AdventureWorks2019;
/*1Q. Creating a Pivot Query*/
with PivotData as 
(
	SELECT SalesPersonID, TerritoryID, SubTotal
	from Sales.SalesOrderHeader
)
SELECT isnull(SalesPersonID, 999) as SalesPersonID,
		format(isnull([1],0.00),'c') as t1,
		format(isnull([2],0.00),'c') as t2,
		format(isnull([3],0.00),'c') as t3,
		format(isnull([4],0.00),'c') as t4,
		format(isnull([5],0.00),'c') as t5,
		format(isnull([6],0.00),'c') as t6,
		format(isnull([7],0.00),'c') as t7,
		format(isnull([8],0.00),'c') as t8,
		format(isnull([9],0.00),'c') as t9,
		format(isnull([10],0.00),'c') as t10
FROM PivotData 
	pivot(sum(SubTotal) for TerritoryID in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10])) as p
	ORDER BY SalesPersonID;

/*2Q Including Territory Names in the Output*/
with PivotData as 
(
SELECT h.SalesPersonID, t.Name, h.SubTotal
FROM Sales.SalesOrderHeader as h INNER JOIN Sales.SalesTerritory as t ON h.TerritoryID = t.TerritoryID
)
SELECT isnull(SalesPersonID, 999) as SalesPersonID,
		format(isnull([Northwest],0.00),'c') as Northwest,
		format(isnull([Northeast],0.00),'c') as Northeast,
		format(isnull([Central],0.00),'c') as Central,
		format(isnull([Southwest],0.00),'c') as Southwest,
		format(isnull([Southeast],0.00),'c') as Southeast,
		format(isnull([Canada],0.00),'c') as Canada,
		format(isnull([France],0.00),'c') as France,
		format(isnull([Germany],0.00),'c') as Germany,
		format(isnull([Australia],0.00),'c') as Australia,
		format(isnull([United Kingdom],0.00),'c') as [United Kingdom]
FROM PivotData 
	pivot(sum(SubTotal) for Name in ([Northwest],[Northeast],[Central],[Southwest],[Southeast],[Canada],[France],[Germany],[Australia],[United Kingdom])) as p
	ORDER BY SalesPersonID;

/*3Q. Dynamically Assigning Territory Names*/
DECLARE @bcolsl AS NVARCHAR(MAX), @bcols2 AS NVARCHAR(MAX), @bquery AS NVARCHAR(MAX); 
 SELECT @bcolsl = STUFF 
(( 
SELECT distinct ', FORMAT(ISNULL(' + QUOTENAME([Name]) + ', 0),''c'') AS ' + QUOTENAME([Name]) 
FROM  Sales.SalesTerritory 
FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'') 
SELECT @bcols2 = STUFF 
(( 
SELECT distinct ',' + QUOTENAME([Name]) 
FROM  Sales.SalesTerritory 
FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'') 
SET @bquery = 'SELECT SalesPersonID, ' + @bcolsl + ' FROM 
( 
SELECT SalesPersonID, t.Name AS TerritoryName, SubTotal 
FROM sales.SalesOrderHeader AS o 
INNER JOIN Sales.SalesTerritory AS t 
ON o.TerritoryID = t.TerritoryID 
) AS p PIVOT (SUM(SubTotal) FOR TerritoryName IN (' + @bcols2 + ')) AS pvt' 
 EXECUTE (@bquery) ; 
 

 

 