
/*A list of all employees of Adventure Works, including their employee ids, names, current job title, date of birth, gender, and marital status.*/ 
Select e.BusinessEntityID As EmpID, p.FirstName, p.LastName, e.JobTitle, e.BirthDate, e.Gender, e.MaritalStatus
From HumanResources.Employee e
Join Person.Person p ON e.BusinessEntityID = p.BusinessEntityID;


/*A list of all employee ids for employees who have worked at multiple positions at AdventureWorks2019. HINT: These individuals should have multiple entries in the EmployeeDepartmentHistory table.*/ 
Select BusinessEntityID
From HumanResources.EmployeeDepartmentHistory
Group by BusinessEntityID
Having COUNT(Distinct DepartmentID)>1;


/*A list of compensation history for the individuals identified in part 2 above. The assumption here is that when a person holds various positions, they may also be compensated differently. Hint: Take a look at the EmployeePayHistory table.*/
Select BusinessEntityID, Rate, PayFrequency
From HumanResources.EmployeePayHistory
Where BusinessEntityID IN (Select BusinessEntityID
  From HumanResources.EmployeeDepartmentHistory
  Group By BusinessEntityID
  having COUNT(Distinct DepartmentID)>1);


/*The final list should include ids, names, department names, group names, start and end dates, and salary levels associated with each position held.*/
Select e.BusinessEntityID AS EmpID,
       p.FirstName,
       p.LastName,
       d.[Name] AS Department,
       d.GroupName,
       edh.StartDate,
       edh.EndDate,
       eph.Rate AS Salary
From HumanResources.Employee e
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
Where e.BusinessEntityID IN (Select BusinessEntityID
  From (select BusinessEntityID, COUNT(*) AS cnt
    From HumanResources.EmployeeDepartmentHistory
    Group by BusinessEntityID) AS emp_count
  Where emp_count.cnt>1);



                                



