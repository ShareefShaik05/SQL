use AdventureWorks2019
SELECT 
    e.BusinessEntityID,
    p.Title, 
    p.FirstName, 
    p.MiddleName, 
    p.LastName, 
    p.Suffix,
    e.JobTitle,
    ph.PhoneNumber,
    pt.Name AS PhoneNumberType,
    ea.EmailAddress,
    p.EmailPromotion,
    a.AddressLine1, a.AddressLine2,
    a.City,
    sp.Name AS StateProvinceName,
    a.PostalCode,
    cr.Name AS CountryRegionName,
    p.AdditionalContactInfo
FROM HumanResources.Employee e
INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress bea ON e.BusinessEntityID = bea.BusinessEntityID
LEFT JOIN Person.Address a ON bea.AddressID = a.AddressID
LEFT JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
LEFT JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
LEFT JOIN Person.PersonPhone ph ON e.BusinessEntityID = ph.BusinessEntityID
LEFT JOIN Person.PhoneNumberType pt ON ph.PhoneNumberTypeID = pt.PhoneNumberTypeID
LEFT JOIN Person.EmailAddress ea ON e.BusinessEntityID = ea.BusinessEntityID;
