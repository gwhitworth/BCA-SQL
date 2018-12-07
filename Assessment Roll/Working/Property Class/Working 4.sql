SELECT 
[ID],
       [Class Code], 
       [Sub Class], 

VAL1 =       MAX([GG Val]), 
VAL2 =      MAX([GO Val]), 
VAL3 =       MAX([GS Val]

FROM (
SELECT 
      p.[dimFolio_SK]
      , p.[Property Class Code]
      , p.[Property Sub Class Code] 
      , p.[Gross General Value]
      , p.[Gross Other Value]
	  , p.[Gross School Value]
      --,pd.DetailType + CAST(DENSE_RANK() OVER (PARTITION BY p.OwnerID ORDER BY p.PetName ASC) AS NVARCHAR) AS [PetNumber]
      --,'PetName' + CAST(DENSE_RANK() OVER (PARTITION BY p.OwnerID ORDER BY p.PetName ASC) AS NVARCHAR) AS [PetNamePivot]
FROM[edw].[FactAssessedValue] p

) AS query
PIVOT (MAX([Gross General Value])
      FOR PetNumber IN ([Gender1],[Gender2],[Gender3], [Breed1], [Breed2], [Breed3])) AS Pivot1
PIVOT (MAX(PetName)
      FOR PetNamePivot IN ([PetName1],[PetName2],[PetName3])) AS Pivot2
GROUP BY
  [dimFolio_SK]
, [Property Class Code]
, [Property Sub Class Code]
ORDER BY [dimFolio_SK]