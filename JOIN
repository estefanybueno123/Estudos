/****** Exercicio com aplicação de JOIN com mais de uma tabela e utilização de CASE com valor NULL******/
SELECT Product.[ProductID]
	,Product.[Name]
	,Product.[ProductNumber]
	,Product.[MakeFlag]
	,Product.[FinishedGoodsFlag]
	,Product.[Color]
	,Product.[SafetyStockLevel]
	,Product.[ReorderPoint]
	,Product.[StandardCost]
	,Product.[ListPrice]
	,Product.[Size]
	,Product.[SizeUnitMeasureCode]
	,Product.[WeightUnitMeasureCode]
	,Product.[Weight]
	,Product.[DaysToManufacture]
	,Product.[ProductLine]
	,Product.[Class]
	,Product.[Style]
	,Product.[ProductSubcategoryID]
	,Product.[ProductModelID]
	,Product.[SellStartDate]
	,Product.[SellEndDate]
	,Product.[DiscontinuedDate]
	,Product.[rowguid]
	,Product.[ModifiedDate]
	,CASE 
		WHEN Cat.[Name] IS NULL
			THEN 'Outros'
		ELSE Cat.[Name]
		END AS Category -- Quando não ouver subcategoria, assumiremos o valor 'Outros'
FROM [AdventureWorks2019].[Production].[Product] AS Product
LEFT JOIN [AdventureWorks2019].[Production].[ProductSubcategory] AS Subcat ON Product.ProductSubcategoryID = Subcat.ProductSubcategoryID 
LEFT JOIN [AdventureWorks2019].[Production].[ProductCategory] AS Cat ON Subcat.ProductCategoryID = Cat.ProductCategoryID
