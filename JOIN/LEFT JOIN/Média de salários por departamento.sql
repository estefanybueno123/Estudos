/****** Média de salários por departamento  ******/
SELECT INFORMACOES.[DepartmentID]
	,DEPARTMENT.[Name]
	,AVG(RATE) AS [Salary_AVG]
FROM (
	SELECT RANKRATE.*
		,DEPART.DepartmentID
	FROM (
		SELECT PAY.*
		FROM (
			SELECT [BusinessEntityID]
				,[RateChangeDate]
				,[Rate]
				,ROW_NUMBER() OVER (
					PARTITION BY BusinessEntityID ORDER BY RateChangeDate DESC
					) AS RANK -- Salario mais recente de cada funcionario
			FROM [AdventureWorks2019].[HumanResources].[EmployeePayHistory]
			) AS PAY
		WHERE [RANK] = 1
		) AS RANKRATE
	LEFT JOIN (
		SELECT RANKDEPART.*
		FROM (
			SELECT [BusinessEntityID]
				,[DepartmentID]
				,RANK() OVER (
					PARTITION BY BusinessEntityID ORDER BY StartDate DESC
					) AS RANK --Departamento atual de cada funcionario
			FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
			) AS RANKDEPART
		WHERE [RANK] = 1
		) AS DEPART ON RANKRATE.BusinessEntityID = DEPART.BusinessEntityID
	) AS INFORMACOES
LEFT JOIN [AdventureWorks2019].[HumanResources].[Department] AS DEPARTMENT ON INFORMACOES.DepartmentID = DEPARTMENT.DepartmentID
GROUP BY INFORMACOES.DepartmentID
	,DEPARTMENT.[Name]
ORDER BY INFORMACOES.DepartmentID
	,AVG(RATE)
