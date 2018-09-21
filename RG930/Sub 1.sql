DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       COUNT(DISTINCT [FA].dimFolio_SK) AS [Folio], 
       COUNT([OCCUR].[Occur Count]) AS [Occurrence], 
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
                                            AND [FO].[Folio Status Code] = '01'
     --AND [BC Transit Flag] = 'Y'
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].[dimRegionalDistrict_SK] = [FO].[dimRegionalDistrict_SK]
     LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
     LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND [AG].[Roll Category Code] = '1'

    WHERE [FAV].[Roll Year] = @p_RY
          AND [FAV].[Cycle Number] = @p_CN
          AND [FAV].[Assessment Code] = '02'
          AND [AG].[Jurisdiction Code] BETWEEN '200' AND '800'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [RD].[Regional District Code] IN('03', '15')
     AND [AG].[Jurisdiction Code] BETWEEN '200' AND '800'
     AND [ED].[BCA Code] IS NULL
GROUP BY [PC].[Property Class Code], 
         [PC].[Property Class Desc]
ORDER BY [PC].[Property Class Code];