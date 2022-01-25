SELECT 
		Cat.[ProductCategoryID]


  FROM [AdventureWorks2019].[Sales].[SalesOrderDetail] AS Sales
LEFT JOIN [AdventureWorks2019].[Production].[Product] AS Product ON Sales.ProductID = Product.ProductID
LEFT JOIN [AdventureWorks2019].[Production].[ProductSubcategory] AS Subcat ON Product.ProductSubcategoryID = Subcat.ProductSubcategoryID 
LEFT JOIN [AdventureWorks2019].[Production].[ProductCategory] AS Cat ON Subcat.ProductCategoryID = Cat.ProductCategoryID
GROUP BY Cat.[ProductCategoryID], Cat.[Name]

UNION -- aplicação de DISTINCT por de traz, trazendo da segunda QUERY somente o que não consta no resultado da primeira

  SELECT  

		CASE	
			WHEN Cat.[ProductCategoryID] is null THEN -99
			ELSE Cat.[ProductCategoryID]
		END as ProductCategoryID
	   
  FROM [AdventureWorks2019].[Purchasing].[PurchaseOrderDetail] AS Purchase
LEFT JOIN [AdventureWorks2019].[Production].[Product] AS Product ON Purchase.ProductID = Product.ProductID
LEFT JOIN [AdventureWorks2019].[Production].[ProductSubcategory] AS Subcat ON Product.ProductSubcategoryID = Subcat.ProductSubcategoryID 
LEFT JOIN [AdventureWorks2019].[Production].[ProductCategory] AS Cat ON Subcat.ProductCategoryID = Cat.ProductCategoryID
GROUP BY 
		
		CASE	
			WHEN Cat.[ProductCategoryID] is null THEN -99
			ELSE Cat.[ProductCategoryID]
		END 
	   ,CASE 
			WHEN Cat.[Name] is null THEN 'Not informed'
			ELSE Cat.[Name] 
		END 
