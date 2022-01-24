/******Exercicio com sub query e aplicação de CASE, DATADIFF para contagem de DIAS e JOIN para informação de TERRITÓRIO******/
SELECT Entrega.*
FROM (
	SELECT TB.*
	FROM (
		SELECT [SalesOrderID]
			,[RevisionNumber]
			,CASE 
				WHEN DATEDIFF(DAY, OrderDate, ShipDate) > 7
					THEN 'Fora do prazo'
				ELSE 'Dentro do prazo'
				END PrazoEntrega
			,[Status]
			,[OnlineOrderFlag]
			,[SalesOrderNumber]
			,[PurchaseOrderNumber]
			,[AccountNumber]
			,[CustomerID]
			,[SalesPersonID]
			,[TerritoryID]
			,[BillToAddressID]
			,[ShipToAddressID]
			,[ShipMethodID]
			,[CreditCardID]
			,[CreditCardApprovalCode]
			,[CurrencyRateID]
			,[SubTotal]
			,[TaxAmt]
			,[Freight]
			,[TotalDue]
			,[Comment]
			,[rowguid]
			,[ModifiedDate]
			,DATEDIFF(DAY, OrderDate, ShipDate) AS Prazo
		FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
		) AS TB
	WHERE TB.PrazoEntrega = 'Dentro do prazo'
	) AS Entrega
INNER JOIN [AdventureWorks2019].[Sales].[SalesTerritory] AS Territory ON Territory.TerritoryID = Entrega.TerritoryID
