DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SELECT [SD].[School  District Code], 
       [SD].[School District] AS [School District], 
       'AA'+[AG].[Area Code] AS [Area], 
       [AG].[Jurisdiction],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       IIF(SUM([Occur Count]) IS NULL, 0,SUM([Occur Count])) AS [Occurrences], 
       IIF(COUNT(CASE
                     WHEN [FA].[Assessment Code] = '02'
                          AND [PC].[Property Class Code] = '01'
                     THEN [FA].[dimFolio_SK]
                 END) = 0, COUNT(DISTINCT [FA].dimFolio_SK), COUNT(CASE
                                                                       WHEN [FA].[Assessment Code] = '02'
                                                                            AND [PC].[Property Class Code] = '01'
                                                                       THEN [FA].[dimFolio_SK]
                                                                   END)) AS [Folio_Count], 
       SUM([FA].[Net School Land Value]) AS [Net_Land], 
       SUM([FA].[Net School Building Value]) AS [Net_Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimSchoolDistrict] AS SD ON SD.[School  District Code] = FO.[School  District Code]
     LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*)- 1 AS [Occur Count]
    FROM [edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
			AND AG.[Roll Category Code] = '1'
    WHERE [FAV].[Roll Year] = @p_RY
          AND [FAV].[Cycle Number] <= @p_CN
         AND [Assessment Code] = '02'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [AG].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [SD].[School  District Code] = '05'
GROUP BY [SD].[School  District Code], 
         [SD].[School District], 
         'AA'+[AG].[Area Code], 
         [AG].[Jurisdiction],
         CASE
             WHEN [PC].[Property Class Code] = '01'
             THEN 'RES'
             WHEN [PC].[Property Class Code] <> '01'
             THEN 'NONRES'
         END
ORDER BY [SD].[School  District Code], 
         [SD].[School District], 
         'AA'+[AG].[Area Code], 
         [RESNONRES] DESC, 
         [AG].[Jurisdiction];