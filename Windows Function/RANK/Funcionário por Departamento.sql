SELECT [BusinessEntityID]
	  ,[DepartmentID]
	  ,[ShiftID]
	  ,[StartDate]
	  ,[EndDate]
	  ,[ModifiedDate]
FROM (
	SELECT [BusinessEntityID]
		  ,[DepartmentID]
		  ,[ShiftID]
		  ,[StartDate]
		  ,[EndDate]
		  ,[ModifiedDate]
		  ,RANK() OVER (PARTITION BY DepartmentID ORDER BY StartDate DESC) AS RANK
	FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
	 ) AS Depart
WHERE [RANK] = 1
