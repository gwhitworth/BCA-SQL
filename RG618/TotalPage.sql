DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT [FA].[Roll Year], 
       [RD].[Regional District], 
       '(AA'+[AG].[Area Code]+')' AS [Area Code], 
       AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc] AS [Jurisdiction], 
       [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       [ED].[BCA Code], 
       COUNT(DISTINCT CASE
                          WHEN [FA].[Assessment Code] = '01'
                          THEN [FA].dimFolio_SK
                      END) AS [Gen Folio], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN [FA].[Net General Land Value]
           END) AS [Gen Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN [FA].[Net General Building Value]
           END) AS [Gen Improvements], 
       COUNT([OCCUR].[Occur Count]) AS [Hosp Folio], 
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
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
     LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
     LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
    WHERE [FAV].[Roll Year] = @p_RY
          AND AG.[Roll Category Code] = '1'
          AND [FAV].[Cycle Number] <= @p_CN
          AND [Assessment Code] = '02'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [FA].[Roll Year] = @p_RY
      AND AG.[Roll Category Code] = '1'
      AND [FA].[Cycle Number] = @p_CN
      AND ([FA].[Current Cycle Flag] = 'Current Cycle Only')
      AND [RD].[Regional District Code] = @p_RD
	  AND  ISNULL([ED].[BCA Code],'1')  <> 'Z'
GROUP BY [FA].[Roll Year], 
         [RD].[Regional District], 
         '(AA'+[AG].[Area Code]+')', 
         AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc], 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc], 
         [ED].[BCA Code]
ORDER BY [FA].[Roll Year], 
         [RD].[Regional District], 
         [Area Code], 
         [Jurisdiction], 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc], 
         [ED].[BCA Code];

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