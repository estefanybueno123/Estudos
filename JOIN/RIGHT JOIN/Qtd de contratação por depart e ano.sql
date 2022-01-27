/****** Quantidade de pessoas contratadas por departamento e ano ******/
SELECT FINAL.ID_DEPARTAMENTO
	,DEPARTAMENTO.[Name] AS NOME_DEPARTAMENTO
	,FINAL.CONTRATACAO_ANO
	,FINAL.QTDPESSOAS
FROM (
	SELECT SEPARACAO.DepartmentID AS ID_DEPARTAMENTO
		,DATEPART(YEAR, SEPARACAO.StartDate) AS CONTRATACAO_ANO
		,COUNT(BusinessEntityID) AS QTDPESSOAS
	FROM (
		SELECT [BusinessEntityID]
			,[DepartmentID]
			,[StartDate]
			,[RANK]
		FROM (
			SELECT [BusinessEntityID]
				,[DepartmentID]
				,[StartDate]
				,RANK() OVER (
					PARTITION BY BusinessEntityID ORDER BY StartDate
					) AS RANK
			FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
			) AS ORDENACAO
		) AS SEPARACAO
	WHERE [RANK] = 1
	GROUP BY SEPARACAO.DepartmentID
		,DATEPART(YEAR, SEPARACAO.StartDate)
	) AS FINAL
RIGHT JOIN [AdventureWorks2019].[HumanResources].[Department] AS DEPARTAMENTO ON DEPARTAMENTO.DepartmentID = FINAL.ID_DEPARTAMENTO
ORDER BY FINAL.ID_DEPARTAMENTO
