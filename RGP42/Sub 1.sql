DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT
       [FA].[Roll Year], 
       [RD].[Regional District], 
       '(AA'+[AG].[Area Code]+')' AS [Area Code], 
       AG.[Jurisdiction Code]+'   '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc] AS [Jurisdiction], 
       [ED].[BCA Code], 
       [Converted Land], 
       [Converted Improvements], 
       COUNT(DISTINCT CASE
                          WHEN [FA].[Assessment Code] = '01'
                      -- AND [FA].[Net General Land Value] > 1
                          THEN [FA].dimFolio_SK
                      END) AS [Gen Folio], 
       IIF(COUNT([OCCUR].[Occur Count]) = 0, NULL, COUNT([OCCUR].[Occur Count])) AS [Hosp Folio], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN IIF([FA].[Net Other Land Value] = 0, NULL, [FA].[Net Other Land Value])
           END) AS [Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN IIF([FA].[Net Other Building Value] = 0, NULL, [FA].[Net Other Building Value])
           END) AS [Improvements]
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
         INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
                                                AND FO.[Folio Status Code] = '01'
         INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
    WHERE [FAV].[Roll Year] = @p_RY
          AND AG.[Roll Category Code] = '1'
          AND [FAV].[Cycle Number] <= @p_CN
          AND [Assessment Code] = '02'
          AND [RD].[Regional District Code] IN(@p_RD)
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
     INNER JOIN
(
    SELECT [AG].dimJurisdiction_SK, 
           SUM([FA].[Net Other Land Value] * ([PC].[Property Conversion Factor] / 100 / 100)) AS [Converted Land], 
           SUM([FA].[Net Other Building Value] * ([PC].[Property Conversion Factor] / 100 / 100)) AS [Converted Improvements]
    FROM [edw].[FactAllAssessedAmounts] AS [FA]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND AG.[Roll Category Code] = '1'
         INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                                AND FO.[Folio Status Code] = '01'
         INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
         LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
    WHERE [FA].[Roll Year] = @p_RY
          AND [FA].[Cycle Number] = @p_CN
          AND ([FA].[Current Cycle Flag] = 'Current Cycle Only')
          AND [RD].[Regional District Code] = @p_RD
          AND [ED].[BCA Code] IS NOT NULL
    GROUP BY [AG].dimJurisdiction_SK
) AS [CONV] ON [AG].dimJurisdiction_SK = [CONV].dimJurisdiction_SK
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [FA].[Current Cycle Flag] = 'Current Cycle Only'
      AND [RD].[Regional District Code] = @p_RD
GROUP BY [FA].[Roll Year], 
         [RD].[Regional District], 
         '(AA'+[AG].[Area Code]+')', 
         AG.[Jurisdiction Code]+'   '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc], 
         [ED].[BCA Code], 
         [Converted Land], 
         [Converted Improvements]
ORDER BY [FA].[Roll Year], 
         [RD].[Regional District], 
         [Area Code], 
         [Jurisdiction], 
         [ED].[BCA Code]