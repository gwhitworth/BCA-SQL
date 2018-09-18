DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SELECT [FA].[Roll Year], 
       [AG].[Region Code], 
       [AG].[Area Desc], 
       'AA'+[AG].[Area Code] AS [Area Code], 
       [AG].[Jurisdiction Code], 
       AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc] AS [Jurisdiction], 
       [ED].[BCA Code], 
       COUNT(DISTINCT CASE
                          WHEN [FA].[Assessment Code] = '01'
                               AND [FA].[Net General Land Value] > 1
                               OR [FA].[Net General Building Value] > 10000000
                          THEN [FA].dimFolio_SK
                      END) AS [Gen Folio], 
       COUNT(DISTINCT CASE
                          WHEN [FA].[Assessment Code] = '01'
                               AND [FA].[Gross General Land Value] > 100000
                          THEN [FA].dimFolio_SK
                      END) AS [Hosp Folio], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN [FA].[Net Other Land Value]
           END) AS [Hosp Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN [FA].[Net Other Building Value]
           END) AS [Hosp Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
WHERE [FA].[Roll Year] = @p_RY
      AND AG.[Roll Category Code] = '1'
      AND [AG].[Area Code] IN('01')
     AND [FA].[Cycle Number] = @p_CN
     --and [FA].[Net General Land Value] > 1 OR [FA].[Net General Building Value]> 1
     AND [AG].[Jurisdiction Code] IN('213', '317')
GROUP BY [FA].[Roll Year], 
         [AG].[Region Code], 
         [AG].[Area Desc], 
         'AA'+[AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc], 
         [ED].[BCA Code]
ORDER BY [FA].[Roll Year], 
         [AG].[Region Code], 
         [AG].[Area Desc], 
         [Area Code], 
         [AG].[Jurisdiction Code];

--Count Proof
--SELECT [AG].[Jurisdiction Code],COUNT(DISTINCT [FA].dimFolio_SK)
--FROM [edw].[FactAllAssessedAmounts] AS [FA]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
--group by [AG].[Jurisdiction Code]
--SELECT [AG].[Jurisdiction Code],COUNT(DISTINCT [FA].dimFolio_SK)
--FROM [edw].[FactAssessedValue] AS [FA]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
--group by [AG].[Jurisdiction Code]
--SELECT [AG].[Jurisdiction Code],COUNT(DISTINCT [FA].dimFolio_SK)
--FROM [edw].[FactActualAmounts] AS [FA]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
--group by [AG].[Jurisdiction Code]
--SELECT [FA].*
--FROM [edw].[FactAllAssessedAmounts] AS [FA]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--	  and [FA].[Assessment Code] = '01'
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
--SELECT [FA].*
--FROM [edw].[FactAssessedValue]AS [FA]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--	  and [FA].[Assessment Code] = '01'
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')