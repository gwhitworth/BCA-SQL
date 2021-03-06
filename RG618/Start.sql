DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SELECT [FA].[Roll Year], 
       [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Desc], 
       [FO].[School  District Code], 
       [PC].[RowSortOrder], 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       SUM([Occur Count]) AS [Occurrences], 
       IIF(COUNT(CASE
                     WHEN [FA].[Assessment Code] = '01'
                          AND [PC].[Property Class Code] = '01'
                     THEN [FA].[dimFolio_SK]
                 END) = 0, COUNT(DISTINCT [FA].dimFolio_SK), COUNT(CASE
                                                                       WHEN [FA].[Assessment Code] = '01'
                                                                            AND [PC].[Property Class Code] = '01'
                                                                       THEN [FA].[dimFolio_SK]
                                                                   END)) AS [Folio_Count], 
       IIF(SUM([FA].[Gross Other Land Value]) = 0, NULL, SUM([FA].[Gross Other Land Value])) AS [Gross Land], 
       IIF(SUM([FA].[Gross Other Building Value]) = 0, NULL, SUM([FA].[Gross Other Building Value])) AS [Gross_Improvements], 
       IIF(SUM([FA].[Other Exemptions Land Value]) * -1 = 0, NULL, SUM([FA].[Other Exemptions Land Value]) * -1) AS [Exempt_Land], 
       IIF(SUM([FA].[Other Exemptions Building Value]) * -1 = 0, NULL, SUM([FA].[Other Exemptions Building Value]) * -1) AS [Exempt_Improvements], 
       IIF(SUM([FA].[Net Other Land Value]) = 0, NULL, SUM([FA].[Net Other Land Value])) AS [Net_Land], 
       IIF(SUM([FA].[Net Other Building Value]) = 0, NULL, SUM([FA].[Net Other Building Value])) AS [Net_Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
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
          AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14', '15')
         AND [Assessment Code] = '02'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [FA].[Roll Year] = @p_RY
      AND AG.[Roll Category Code] = '1'
      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14', '15')
AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213','317')
GROUP BY [FA].[Roll Year], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Desc], 
         [FO].[School  District Code], 
         [PC].[RowSortOrder], 
         [PC].[Property Class Code],
         CASE
             WHEN [PC].[Property Class Code] = '01'
             THEN 'RES'
             WHEN [PC].[Property Class Code] <> '01'
             THEN 'NONRES'
         END, 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [FA].[Roll Year], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Desc], 
         [FO].[School  District Code], 
         [RESNONRES] DESC, 
         [PC].[RowSortOrder];