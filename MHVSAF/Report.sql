DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = 11;
SELECT [AG].[Jurisdiction Code] AS [JUR_CODE], 
       [PC].[Property Class Code] AS [PC_CODE], 
       [FA].[Roll Year] AS [ROLLYEAR], 
       [FA].[Roll Effective Date] AS [ROLL_DATE], 
       [FA].[Cycle Number] AS [CYCLE_NUM], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN [FA].[Net Other Land Value]
           END) AS [HSP_NT_LAND], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN [FA].[Net Other Building Value]
           END) AS [HSP_NT_IMPR], 
       COUNT(DISTINCT CASE
                          WHEN [FA].[Assessment Code] = '01'
                          THEN [FA].dimFolio_SK
                      END) AS [Folio], 
       COUNT([OCCUR].[Occur Count]) AS [Occurence]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     LEFT OUTER JOIN
(
    SELECT [FA].dimFolio_SK, 
           [FA].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [edw].[FactAllAssessedAmounts] AS [FA]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND [AG].[Roll Category Code] = '1'
    WHERE [FA].[Roll Year] = @p_RY
          AND [FA].[Cycle Number] = @p_CN
          AND [FA].[Assessment Code] = '02'
    GROUP BY [FA].dimFolio_SK, 
             [FA].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
GROUP BY [AG].[Jurisdiction Code], 
         [PC].[Property Class Code], 
         [FA].[Roll Year], 
         [FA].[Roll Effective Date], 
         [FA].[Cycle Number]
ORDER BY [AG].[Jurisdiction Code], 
         [PC].[Property Class Code], 
         [FA].[Roll Year], 
         [FA].[Roll Effective Date], 
         [FA].[Cycle Number];