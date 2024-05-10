
/*1*/ 
SElECT e.BusinessEntityID AS EmpID, 
       p.FirstName, 
	   p.LastName, 
	   e.JobTitle, 
	   e.BirthDate, 
	   e.Gender, 
	   e.MaritalStatus
FROM HumanResources.Employee e
Join Person.Person p ON e.BusinessEntityID = p.BusinessEntityID;


/*2*/ 
SELECT BusinessEntityID
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY BusinessEntityID
HAVING COUNT(Distinct DepartmentID)>1;


/*3*/
SELECT BusinessEntityID, Rate, PayFrequency
FROM HumanResources.EmployeePayHistory
WHERE BusinessEntityID IN (Select BusinessEntityID
  From HumanResources.EmployeeDepartmentHistory
  Group By BusinessEntityID
  having COUNT(Distinct DepartmentID)>1);


/*4*/
SELECT e.BusinessEntityID AS EmpID,
       p.FirstName,
       p.LastName,
       d.[Name] AS Department,
       d.GroupName,
       edh.StartDate,
       edh.EndDate,
       eph.Rate AS Salary
FROM HumanResources.Employee e
JOIN Person.Person p
  ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh
  On e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d
  ON edh.DepartmentID = d.DepartmentID
JOIN HumanResources.EmployeePayHistory eph
  ON e.BusinessEntityID = eph.BusinessEntityID
  AND edh.StartDate <= eph.RateChangeDate
  AND (edh.EndDate IS NULL OR edh.EndDate>eph.RateChangeDate)
WHERE e.BusinessEntityID IN (Select BusinessEntityID
    FROM (select BusinessEntityID, COUNT(*) AS cnt
    FROM HumanResources.EmployeeDepartmentHistory
    GROUP BY BusinessEntityID) AS emp_count
    WHERE emp_count.cnt>1);



                                



