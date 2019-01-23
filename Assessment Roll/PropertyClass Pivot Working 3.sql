
/****** Script for SelectTopNRows command from SSMS  ******/

--SELECT TOP (1000) [dimFolio_SK], 
--                  [PC].[Property Class Code], 
--                  [PC].[Property Sub Class Code]
--FROM [edw].[FactAssessedValue] AS [FACT]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC]
--     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--WHERE [dimFolio_SK] > -1
--      AND [FACT].[Assessment Code] = '01'
--ORDER BY [dimFolio_SK];
--SELECT DISTINCT 
--       [dimFolio_SK], 
--       [PC].[Property Class Code], 
--	   [PC].[Property Class Desc],
--       [PC].[Property Sub Class Code],
--	   [PC].[Property Sub Class Desc]
--FROM [edw].[FactAssessedValue] AS [FACT]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC]
--     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--WHERE [dimFolio_SK] = 4703916
--      AND [FACT].[Assessment Code] = '01'
--ORDER BY [PC].[Property Class Code];
--SELECT TOP 1000 [dimFolio_SK], 
--                COUNT(*) AS [RecordCnt]
--FROM [edw].[FactAssessedValue]
--WHERE [Assessment Code] = '01'
--GROUP BY [dimFolio_SK]
--HAVING COUNT(*) > 4;
--SELECT DISTINCT 
--       [dimFolio_SK], 
--       [PC].[Property Class Code] AS [CODE], 
--       ISNULL([PC].[Property Class Desc], [PC].[Property Sub Class Desc]) AS [DESC], 
--       [PC].[Property Sub Class Code], 
--       [PC].[Property Sub Class Desc]
--FROM [edw].[FactAssessedValue] AS [FACT]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC]
--     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--WHERE [dimFolio_SK] = 4703916
--      AND [FACT].[Assessment Code] = '01';
--SELECT DISTINCT 
--       [dimFolio_SK], 
--       [PC].[Property Class Code] AS [CODE], 
--       [PC].[Property Class Desc] AS [DESC]
--FROM [edw].[FactAssessedValue] AS [FACT]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC]
--     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--WHERE [dimFolio_SK] = 4703916
--      AND [FACT].[Assessment Code] = '01'
--UNION
--SELECT DISTINCT 
--       [dimFolio_SK], 
--       [PC].[Property Sub Class Code] AS [CODE], 
--       [PC].[Property Sub Class Desc] AS [DESC]
--FROM [edw].[FactAssessedValue] AS [FACT]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC]
--     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--WHERE [dimFolio_SK] = 4703916
--      AND [FACT].[Assessment Code] = '01'
--      AND [PC].[Property Sub Class Code] IS NOT NULL;
--SELECT *
--FROM
--(
--    SELECT DISTINCT 
--           [dimFolio_SK], 
--           [PC].[Property Class Code] AS [CODE], 
--           ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [DESC]
--    --, 
--    --      [PC].[Property Sub Class Code], 
--    --      [PC].[Property Sub Class Desc]
--    FROM [edw].[FactAssessedValue] AS [FACT]
--         INNER JOIN [edw].[dimPropertyClass] AS [PC]
--         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--    WHERE [dimFolio_SK] = 4703916
--          AND [FACT].[Assessment Code] = '01'
--) [DataTable] PIVOT(MAX([DESC]) FOR [CODE] IN([01], 
--                                              [0103], 
--                                              [06], 
--                                              [08], 
--                                              [09])) [PivotTable];

SELECT *
FROM
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           'Land PC ' + [PC].[Property Class Code] AS [CODE], 
           [PC].[Property Class Code]+' - '+[PC].[Property Class Desc] AS [DESC]
    FROM [edw].[FactAssessedValue] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
    WHERE [dimFolio_SK] = 4703916
          AND [FACT].[Assessment Code] = '01'
    UNION
    SELECT DISTINCT 
           [dimFolio_SK], 
           'Land Psc ' + [PC].[Property Sub Class Code] AS [CODE], 
           [PC].[Property Sub Class Code]+' - '+[PC].[Property Sub Class Desc] AS [DESC]
    FROM [edw].[FactAssessedValue] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
    WHERE [dimFolio_SK] = 4703916
          AND [FACT].[Assessment Code] = '01'
          AND [PC].[Property Sub Class Code] IS NOT NULL
) [DataTable] PIVOT(MAX([DESC]) FOR [CODE] IN([Land PC 01], 
                                              [Land Psc 0102], 
                                              [Land Psc 0103],
											  [Land Psc 0104],
											  [Land Psc 0105],
											  [Land Psc 0106], 
											  [Land PC 02],
											  [Land PC 03],
											  [Land PC 04],
											  [Land PC 05],
                                              [Land PC 06],
											  [Land PC 07], 
                                              [Land PC 08], 
                                              [Land PC 09])) [PiotTable];