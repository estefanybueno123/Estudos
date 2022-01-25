SELECT [PurchaseOrderID]
	,[UnitPrice]
FROM (
	SELECT [PurchaseOrderID]
		,[UnitPrice]
		,ROW_NUMBER() OVER (
			PARTITION BY PurchaseOrderID ORDER BY UnitPrice DESC
			) AS RANK
	FROM [AdventureWorks2019].[Purchasing].[PurchaseOrderDetail]
	) AS Price
WHERE [RANK] = 1
ORDER BY UnitPrice DESC
	,PurchaseOrderID
