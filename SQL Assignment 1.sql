--Q1. Display a list of all customers
SELECT * 
FROM sales.customers;

--Q2. List all customers' company names and contact names. Label the output columns "Company Name" and "Contact Name", respectively.
SELECT companyname AS "Company Name", contactname AS "Contact Name" 
FROM sales.customers;

--Q3. List all customer addresses by concatenating address, city, postalcode, and country columns in a single column in the output. Use appropriate delimiters between the values (e.g., a comma). Make sure the column in the output is labeled.
SELECT contactname, concat(address, ', ', city, ', ', postalcode, ', ', country) AS "Address" 
FROM sales.customers;

--Q4. Find all customers located either in Germany or France.
SELECT * 
FROM sales.customers 
WHERE country = 'Germany' OR country = 'France';

--Q5. Find all orders placed in 2016 that were shipped to Canada, Mexico, or USA. List only order ID and order date in the output.
SELECT orderid, orderdate 
FROM sales.Orders 
WHERE orderdate BETWEEN '2016-01-01' AND '2016-12-31' 
AND shipcountry IN ('Canada', 'Mexico', 'USA');

--Q6. Find all customers located in countries starting with letters "A", "B", or "C".
SELECT * 
FROM sales.customers 
WHERE country LIKE 'A%' OR country LIKE 'B%' OR country LIKE 'C%';

--Q7. Find all customers whose company name starts with letter "K". Note that all company names start with the "Customer" prefix followed by the actual company name.
SELECT * 
FROM sales.customers 
WHERE companyname LIKE 'Customer K%';






