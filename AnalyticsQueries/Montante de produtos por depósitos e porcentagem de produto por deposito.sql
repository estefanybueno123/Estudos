/****** Cada depósito possuí produtos e quantidades diferentes, foi verificado o montante de produtos por depósitos e quantos % cada produto ID representa deste montante por depósito  ******/
SELECT INVENTORY.[ProductID]
	,PRODUCT.[Name] AS ProductName
	,INVENTORY.[LocationID]
	,LL.[Name] LocationName
	,INVENTORY.[Quantity]
	,SUM(QUANTITY) OVER (
		PARTITION BY INVENTORY.LOCATIONID ORDER BY INVENTORY.LOCATIONID
		) AS TPL -- Soma de todos os produtos por Local/Depósito
	,ROUND(([Quantity] * 100) / SUM(QUANTITY) OVER (
			PARTITION BY INVENTORY.LOCATIONID ORDER BY INVENTORY.LOCATIONID
			), 4) AS PorcentagemProduto -- Porcentagem de ocupação de cada produto por Local/Depósito
FROM [AdventureWorks2019].[Production].[ProductInventory] AS INVENTORY
LEFT JOIN [AdventureWorks2019].[Production].[Product] AS PRODUCT ON INVENTORY.ProductID = PRODUCT.ProductID --JOIN para trazer nome do Produto
LEFT JOIN [AdventureWorks2019].[Production].[Location] AS LL ON INVENTORY.LocationID = LL.LocationID -- JOIN para trazer o nome do Local/Depósito
