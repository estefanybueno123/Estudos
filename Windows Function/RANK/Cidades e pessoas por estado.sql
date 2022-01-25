/****** As 3 cidades com mais pessoas por Estado  ******/
SELECT FINAL.*
FROM (
	SELECT EstadoPessoa.*
		,RANK() OVER (
			PARTITION BY Estado ORDER BY QTDPerson DESC
			) AS RANK
	FROM (
		SELECT STP.StateProvinceID
			,STP.[Name] AS Estado
			,ADDR.City
			,COUNT(DISTINCT BEA.[BusinessEntityID]) AS QTDPerson
		FROM [AdventureWorks2019].[Person].[BusinessEntityAddress] AS BEA
		LEFT JOIN [AdventureWorks2019].[Person].[Address] AS ADDR ON ADDR.AddressID = BEA.AddressID
		LEFT JOIN [AdventureWorks2019].[Person].[StateProvince] AS STP ON STP.StateProvinceID = ADDR.StateProvinceID
		GROUP BY STP.StateProvinceID
			,STP.[Name]
			,ADDR.City
		) AS EstadoPessoa
	) AS FINAL
WHERE [RANK] <= 3
ORDER BY Estado
	,[RANK]
