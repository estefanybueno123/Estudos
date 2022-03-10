/****** Verificando custo dos produtos, se houve aumento ou redução. Incluindo Fleg nos produtos em que teve aumento ******/
SELECT [ProductID]
      ,[StartDate]
      ,[EndDate]
      ,[StandardCost]
	  ,LAG(StandardCost, 1, 0) Over (Partition by productID order by [startdate]) AS CustotAnterior
	  ,CASE
	  WHEN LAG(StandardCost, 1, 0) Over (Partition by productID order by [startdate]) = 0 THEN 0
	  WHEN StandardCost > LAG(StandardCost, 1, 0) Over (Partition by productID order by [startdate]) THEN 1
	  ELSE 0
	  END AS FlgAumento -- Verificando se houve aumento no custo do produto
	  ,CASE 
		WHEN LAG(StandardCost, 1, 0) Over (Partition by productID order by [startdate]) > 0 THEN
	 (StandardCost - LAG(StandardCost, 1, 0) Over (Partition by productID order by [startdate])) / LAG(StandardCost, 1, 0) Over (Partition by productID order by [startdate]) *100
	 ELSE 0
	 END AS PorcentagemAumentoDiminuicao -- Verificando quantos % o custo aumentou ou diminuiu
  FROM [AdventureWorks2019].[Production].[ProductCostHistory]
