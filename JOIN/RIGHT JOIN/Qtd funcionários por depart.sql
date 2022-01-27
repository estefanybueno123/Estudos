/****** Quantidade de funcionários por departamento  ******/
SELECT FUNCIONARIOS.DepartmentID
	,DEPARTAMENTO.[Name]
	,count(DISTINCT [BusinessEntityID]) AS QTDFUNCIONARIOS
FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory] AS FUNCIONARIOS
RIGHT JOIN [AdventureWorks2019].[HumanResources].[Department] AS DEPARTAMENTO ON DEPARTAMENTO.DepartmentID = FUNCIONARIOS.DepartmentID
GROUP BY FUNCIONARIOS.DepartmentID
	,DEPARTAMENTO.[Name]
