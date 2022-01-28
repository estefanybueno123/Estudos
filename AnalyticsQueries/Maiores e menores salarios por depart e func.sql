/****** Cinco maiores e menores salários por departamento e nome do funcionario  ******/
SELECT SALARIOS.DepartmentID
	,DEPARTMENT.[Name] AS NameDepartment
	,SALARIOS.BusinessEntityID
	,CONCAT (
		PERSON.[FirstName]
		,' '
		,[LastName]
		) AS NamePerson
	,SALARIOS.Rate
	,SALARIOS.RANK
FROM (
	SELECT DEPART.DepartmentID
		,RANKRATE.BusinessEntityID
		,RANKRATE.Rate
		,RANK() OVER (
			PARTITION BY DEPART.DepartmentID ORDER BY RATE DESC
			) AS RANK -- Rank dos maiores salários
	FROM (
		SELECT PAY.*
		FROM (
			SELECT [BusinessEntityID]
				,[RateChangeDate]
				,[Rate]
				,ROW_NUMBER() OVER (
					PARTITION BY BusinessEntityID ORDER BY RateChangeDate DESC
					) AS RANK
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
					PARTITION BY BusinessEntityID ORDER BY StartDate
					) AS RANK
			FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
			) AS RANKDEPART
		WHERE [RANK] = 1
		) AS DEPART ON RANKRATE.BusinessEntityID = DEPART.BusinessEntityID
	) AS SALARIOS
LEFT JOIN [AdventureWorks2019].[HumanResources].[Department] AS DEPARTMENT ON DEPARTMENT.DepartmentID = SALARIOS.DepartmentID
LEFT JOIN [AdventureWorks2019].[Person].[Person] AS PERSON ON PERSON.BusinessEntityID = SALARIOS.BusinessEntityID
WHERE [RANK] <= 5
ORDER BY SALARIOS.DepartmentID
	,SALARIOS.Rate

---------------------------------------------------------------------------------------------------------------------------

SELECT SALARIOS.DepartmentID
	,DEPARTMENT.[Name] AS NameDepartment
	,SALARIOS.BusinessEntityID
	,CONCAT (
		PERSON.[FirstName]
		,' '
		,[LastName]
		) AS NamePerson
	,SALARIOS.Rate
FROM (
	SELECT DEPART.DepartmentID
		,RANKRATE.BusinessEntityID
		,RANKRATE.Rate
		,RANK() OVER (
			PARTITION BY DEPART.DepartmentID ORDER BY RATE
			) AS RANK -- Rank dos menores salários
	FROM (
		SELECT PAY.*
		FROM (
			SELECT [BusinessEntityID]
				,[RateChangeDate]
				,[Rate]
				,ROW_NUMBER() OVER (
					PARTITION BY BusinessEntityID ORDER BY RateChangeDate DESC
					) AS RANK
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
					PARTITION BY BusinessEntityID ORDER BY StartDate
					) AS RANK
			FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
			) AS RANKDEPART
		WHERE [RANK] = 1
		) AS DEPART ON RANKRATE.BusinessEntityID = DEPART.BusinessEntityID
	) AS SALARIOS
LEFT JOIN [AdventureWorks2019].[HumanResources].[Department] AS DEPARTMENT ON DEPARTMENT.DepartmentID = SALARIOS.DepartmentID
LEFT JOIN [AdventureWorks2019].[Person].[Person] AS PERSON ON PERSON.BusinessEntityID = SALARIOS.BusinessEntityID
WHERE SALARIOS.[RANK] <= 5
ORDER BY SALARIOS.DepartmentID
	,SALARIOS.Rate
