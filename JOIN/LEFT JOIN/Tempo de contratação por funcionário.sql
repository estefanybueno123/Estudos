/****** Tempo de contratação em ano, de cada funcionário  ******/
SELECT EMPLOYEE.BusinessEntityID
	,CONCAT (
		PERSON.[FirstName]
		,' '
		,[LastName]
		) AS NomeFuncionario
	,EMPLOYEE.StartDate AS DataContracao
	,EMPLOYEE.DataAtual
	,DATEDIFF(month, EMPLOYEE.StartDate, EMPLOYEE.DataAtual) / 12 AS TempoAno --Quantidade de meses dividido por 12
FROM (
	SELECT [BusinessEntityID]
		,[DepartmentID]
		,[ShiftID]
		,[StartDate]
		,[EndDate]
		,DATEADD(dd, datediff(dd, 0, GETDATE()), 0) AS DataAtual
		,RANK() OVER (
			PARTITION BY BusinessEntityID ORDER BY StartDate
			) AS RANK --Data em que o funcionário entrou
	FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
	) AS EMPLOYEE
LEFT JOIN [AdventureWorks2019].[Person].[Person] AS PERSON ON PERSON.BusinessEntityID = EMPLOYEE.BusinessEntityID
WHERE [RANK] = 1
ORDER BY EMPLOYEE.BusinessEntityID
	,DATEDIFF(month, EMPLOYEE.StartDate, EMPLOYEE.DataAtual)
