SELECT DISTINCT 
       [FA].[Roll Year], 
       [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Desc], 
       [PC].[RowSortOrder], 
       [PC].[Property Class Code], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       SUM([Occur Count]) AS [Occur Count], 
       IIF(COUNT(CASE
                     WHEN [FA].[Assessment Code] = '01'
                          AND [PC].[Property Class Code] = '01'
                     THEN [FA].[dimFolio_SK]
                 END) = 0, COUNT(DISTINCT [FA].dimFolio_SK), COUNT(CASE
                                                                       WHEN [FA].[Assessment Code] = '01'
                                                                            AND [PC].[Property Class Code] = '01'
                                                                       THEN [FA].[dimFolio_SK]
                                                                   END)) AS [Folios], 
       SUM([FA].[Gross Other Land Value]) AS [Gross Other Land Value], 
       SUM([FA].[Gross Other Building Value]) AS [Gross Other Building Value], 
       SUM([FA].[Other Exemptions Land Value]) * -1 AS [Other Exemption Land Value], 
       SUM([FA].[Other Exemptions Building Value]) * -1 AS [Other Exemption Building Value], 
       SUM([FA].[Net Other Land Value]) AS [Net Other Land Value], 
       SUM([FA].[Net Other Building Value]) AS [Net Other Building Value]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
    WHERE [FAV].[Roll Year] = 2017
          AND AG.[Roll Category Code] = '1'
          AND [FAV].[Cycle Number] <= -1
          AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14')
         AND [AG].[Jurisdiction Code] = '317'
         AND [Assessment Code] = '02'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [AG].[Roll Year] = 2017
      AND AG.[Roll Category Code] = '1'
      AND [FA].[Cycle Number] = -1
      AND ([AG].[Jurisdiction Code] = '317')
GROUP BY [FA].[Roll Year], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Desc], 
         [PC].[RowSortOrder], 
         [PC].[Property Class Code], 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [FA].[Roll Year], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Desc], 
         [PC].[RowSortOrder];