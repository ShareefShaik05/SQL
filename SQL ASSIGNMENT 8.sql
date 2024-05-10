/* GROUPING SETS Clause*/
SELECT 
    DimProductCategory.EnglishProductCategoryName as ProductCategory, 
    DimProductSubCategory.EnglishProductSubcategoryName AS ProductSubCategory, 
    DimProduct.EnglishProductName as Product, 
    SUM(FactInternetSales.SalesAmount) as SalesAmt
FROM 
    DimProduct 
    Inner join DimProductSubcategory on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
    Inner join DimProductCategory on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey 
    Inner join FactInternetSales ON DimProduct.ProductKey = FactInternetSales.ProductKey 
GROUP BY GROUPING Sets (
        (DimProductCategory.EnglishProductCategoryName, DimProductSubCategory.EnglishProductSubcategoryName, DimProduct.EnglishProductName),
        (DimProductCategory.EnglishProductCategoryName, DimProductSubCategory.EnglishProductSubcategoryName),
        (DimProductCategory.EnglishProductCategoryName),
        ()
    )
ORDER BY 
    DimProductCategory.EnglishProductCategoryName, 
    DimProductSubCategory.EnglishProductSubcategoryName, 
    DimProduct.EnglishProductName;
/* CUBE Clause */
SELECT
    DimProductCategory.EnglishProductCategoryName as ProductCategory, 
    DimProductSubCategory.EnglishProductSubcategoryName as ProductSubCategory, 
    DimProduct.EnglishProductName as Product, 
    sum(FactInternetSales.SalesAmount) as SalesAmt
FROM
DimProduct 
Inner Join DimProductSubcategory on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
Inner join DimProductCategory on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey 
Inner join FactInternetSales On DimProduct.ProductKey = FactInternetSales.ProductKey 
GROUP by 
	Cube (DimProductCategory.EnglishProductCategoryName, DimProductSubCategory.EnglishProductSubcategoryName, DimProduct.EnglishProductName)
Having Grouping(DimProductCategory.EnglishProductCategoryName) = 0
    And Grouping(DimProductSubCategory.EnglishProductSubcategoryName) = 0
    And grouping(DimProduct.EnglishProductName) = 0
ORDER by 
DimProductCategory.EnglishProductCategoryName, 
DimProductSubCategory.EnglishProductSubcategoryName, 
DimProduct.EnglishProductName;
/* ROLLUP Clause*/
SELECT
    pc.EnglishProductCategoryName As Category,
    psc.EnglishProductSubcategoryName as Subcategory,
    p.EnglishProductName as Product,
    Sum(f.SalesAmount) as SalesAmt
FROM 
    dbo.FactInternetSales f
    Join dbo.DimProduct p on f.ProductKey = p.ProductKey
    Join dbo.DimProductSubcategory psc on p.ProductSubcategoryKey = psc.ProductSubcategoryKey
    Join dbo.DimProductCategory pc on psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY 
    Rollup(pc.EnglishProductCategoryName, psc.EnglishProductSubcategoryName, p.EnglishProductName);




/*ROLLUP clause and GROUPING Function */
SELECT ISNULL(pc.EnglishProductCategoryName, 'All Categories') as ProductCategory,
       ISNULL(psc.EnglishProductSubcategoryName, 'All Subcategories') as ProductSubcategory,
       ISNULL(p.EnglishProductName, 'All Products') as Product,
       SUM(FIS.SalesAmount) as TotalSales,
       GROUPING(pc.EnglishProductCategoryName) as CategoryGroup,
       GROUPING(psc.EnglishProductSubcategoryName) as SubcategoryGroup,
       GROUPING(p.EnglishProductName) as ProductGroup
FROM dbo.FactInternetSales FIS
Inner Join dbo.DimProduct p on FIS.ProductKey = p.ProductKey
Inner Join dbo.DimProductSubcategory psc on p.ProductSubcategoryKey = psc.ProductSubcategoryKey
Inner join dbo.DimProductCategory pc on psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY Rollup(pc.EnglishProductCategoryName, psc.EnglishProductSubcategoryName, p.EnglishProductName)
having GROUPING(pc.EnglishProductCategoryName) = 0 OR GROUPING(psc.EnglishProductSubcategoryName) = 0 OR Grouping(p.EnglishProductName) = 0
ORDER BY ProductCategory, ProductSubcategory, Product;



/*ROLLUP clause and GROUPING_ID Function */
SELECT ISNULL(pc.EnglishProductCategoryName, 'All Categories') as ProductCategory,
       ISNULL(psc.EnglishProductSubcategoryName, 'All Subcategories') as ProductSubcategory,
       ISNULL(p.EnglishProductName, 'All Products') As Product,
       SUM(FIS.SalesAmount) as TotalSales,
       GROUPING_ID(pc.EnglishProductCategoryName, psc.EnglishProductSubcategoryName, p.EnglishProductName) AS GroupID
From dbo.FactInternetSales FIS
Inner Join dbo.DimProduct p On FIS.ProductKey = p.ProductKey
Inner Join dbo.DimProductSubcategory psc ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
Inner join dbo.DimProductCategory pc ON psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY Rollup(pc.EnglishProductCategoryName, psc.EnglishProductSubcategoryName, p.EnglishProductName)
Having Grouping(pc.EnglishProductCategoryName) = 0 OR GROUPING(psc.EnglishProductSubcategoryName) = 0 OR GROUPING(p.EnglishProductName) = 0
ORDER by GroupID;


