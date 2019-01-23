
/****** Script for SelectTopNRows command from SSMS  ******/

SELECT TOP (1000) [dimFolio_SK], 
                  [PC].[Property Class Code], 
                  [PC].[Property Sub Class Code]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] > -1
      AND [FACT].[Assessment Code] = '01'
ORDER BY [dimFolio_SK];

SELECT DISTINCT 
       [dimFolio_SK], 
       [PC].[Property Class Code], 
	   [PC].[Property Class Desc],
       [PC].[Property Sub Class Code],
	   [PC].[Property Sub Class Desc]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4703916
      AND [FACT].[Assessment Code] = '01'
ORDER BY [PC].[Property Class Code];

--SELECT DISTINCT 
--       [dimFolio_SK], 
--       [PC].[Property Class Code], 
--	   [PC].[Property Class Desc],
--       [PC].[Property Sub Class Code],
--	   [PC].[Property Sub Class Desc]
--FROM [edw].[FactAssessedValue] AS [FACT]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC]
--     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--pivot (max ([PC].[Property Class Desc]) for [PC].[Property Class Code] in (['01'],['0103'],['06'],['08'],['09'])) as JUNK
--WHERE [dimFolio_SK] = 4703916
--      AND [FACT].[Assessment Code] = '01'

SELECT *
FROM
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           [PC].[Property Class Code], 
           [PC].[Property Class Desc], 
           [PC].[Property Sub Class Code], 
           [PC].[Property Sub Class Desc]
    FROM [edw].[FactAssessedValue] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
    WHERE [dimFolio_SK] = 4703916
          AND [FACT].[Assessment Code] = '01'
) [DataTable] PIVOT(MAX([Property Class Code]) FOR [dimFolio_SK] IN([01], 
                                                                         [0103], 
                                                                         [06], 
                                                                         [08], 
                                                                         [09])) [PivotTable];

 

SELECT TOP 1000 [dimFolio_SK], 
                COUNT(*) AS [RecordCnt]
FROM [edw].[FactAssessedValue]
WHERE [Assessment Code] = '01'
GROUP BY [dimFolio_SK]
HAVING COUNT(*) > 4;