DECLARE @p_RY INT;
SET @p_RY = 2018;
SELECT [AG].[Area Code], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Desc], 
       MAX([RC].[Cycle Number]) AS [Roll Version], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [Folios], 
       SUM(CASE [PC].[Property Class Code]
               WHEN '01'
               THEN [Total]
               ELSE 0
           END) AS 'Class 1', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '02'
               THEN [Total]
               ELSE 0
           END) AS 'Class 2', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '03'
               THEN [Total]
               ELSE 0
           END) AS 'Class 3', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '04'
               THEN [Total]
               ELSE 0
           END) AS 'Class 4', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '05'
               THEN [Total]
               ELSE 0
           END) AS 'Class 5', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '06'
               THEN [Total]
               ELSE 0
           END) AS 'Class 6', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '07'
               THEN [Total]
               ELSE 0
           END) AS 'Class 7', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '08'
               THEN [Total]
               ELSE 0
           END) AS 'Class 8', 
       SUM(CASE [PC].[Property Class Code]
               WHEN '01'
               THEN [Total]
               ELSE 0
           END) AS 'Class 9', 
       SUM([Total]) AS 'Total 1-9'
FROM
(
    SELECT DISTINCT 
           [A].[dimFolio_SK], 
           [A].[dimAssessmentGeography_SK], 
           [A].[dimJurisdiction_SK], 
           [dimRollCycle_SK], 
           [A].[dimPropertyClass_SK], 
           SUM([Net General Total Value]) AS [Total]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
    WHERE [A].[dimRollYear_SK] = @p_RY
    GROUP BY [A].[dimFolio_SK], 
             [A].[dimPropertyClass_SK], 
             [A].[dimAssessmentGeography_SK], 
             [A].[dimJurisdiction_SK], 
             [dimRollCycle_SK]
) AS [FA]
LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
   AND [dimRollCategory_BK] = '2'
INNER JOIN [edw].[dimRollCycle] AS [RC]
ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
WHERE [AG].[Area Code] IS NOT NULL
GROUP BY [AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Desc]
ORDER BY [Jurisdiction Desc];