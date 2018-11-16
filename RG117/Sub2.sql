DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_SD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_SD = '06';
SELECT DISTINCT 
       [NET].[School District Code] AS                          [School District Code], 
       [NET].[School District] AS                               [School District], 
       'AA'+[AR].[Area Code] AS                                 [Area], 
       [JurisdictionFormatted], 
       IIF([Res Occur] = 0, NULL, [Res Occur]) AS               [Res Occur], 
       IIF([Res Net Land] = 0, NULL, [Res Net Land]) AS         [Res Net Land], 
       IIF([Res Net Impr] = 0, NULL, [Res Net Impr]) AS         [Res Net Impr], 
       IIF([Non Res Occur] = 0, NULL, [Non Res Occur]) AS       [Non Res Occur], 
       IIF([Non Res Net Land] = 0, NULL, [Non Res Net Land]) AS [Non Res Net Land], 
       IIF([Non Res Net Impr] = 0, NULL, [Non Res Net Impr]) AS [Non Res Net Impr], 
       IIF([Folios] = 0, NULL, [Folios]) AS                     [Folios]
FROM
(
    SELECT [Jurisdiction Code],
           CASE
               WHEN CHARINDEX('Rural', [JurisdictionRural]) > 0
               THEN [JurisdictionRural]
               ELSE [Jurisdiction]
           END AS [JurisdictionFormatted], 
           [Res Occur], 
           [Non Res Occur], 
           [Folios]
    FROM
    (
        SELECT [Jurisdiction Code], 
               [Jurisdiction], 
               [JurisdictionRural], 
               SUM([Res Occur]) AS     [Res Occur], 
               SUM([Non Res Occur]) AS [Non Res Occur], 
               SUM([Folios]) AS        [Folios]
        FROM
        (
            SELECT [AG].[Jurisdiction Code], 
                   [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
                   [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Desc] AS                                      [JurisdictionRural], 
                   [PC].[Property Class Code], 
                   [PC].[Property Sub Class Code], 
                   COUNT(DISTINCT CASE
                                      WHEN [PC].[Property Class Code] = '01'
                                           AND [AV].[Assessment Code] <> '01'
                                      THEN [AV].[dimFolio_SK]
                                  END) AS                                                                        [Res Occur], 
                   COUNT(DISTINCT CASE
                                      WHEN [PC].[Property Class Code] <> '01'
                                           AND [AV].[Assessment Code] = '01'
                                      THEN [AV].[dimFolio_SK]
                                  END) AS                                                                        [Non Res Occur], 
                   COUNT(DISTINCT CASE
                                      WHEN [PC].[Property Class Code] = '01'
                                      THEN [AV].[dimFolio_SK]
                                  END) AS                                                                        [Folios]
            FROM [edw].[FactAllAssessedAmounts] AS [AV]
                 INNER JOIN [edw].[dimPropertyClass] AS [PC]
                 ON [AV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
                    AND [PC].[Roll Year] = @p_RY
                 INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
                 ON [AV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                    AND [AG].[Roll Category Code] = '1'
                 INNER JOIN [edw].[dimFolio] AS [FO]
                 ON [FO].[dimFolio_SK] = [AV].[dimFolio_SK]
                    AND [FO].[Folio Status Code] = '01'
                 INNER JOIN [edw].[dimSchoolDistrict] AS [SD]
                 ON [SD].[School District Code] = [FO].[School District Code]
                    AND [SD].[Roll Year] = @p_RY
            WHERE [AV].[Roll Year] = @p_RY
                  AND [AV].[Property Class Code] < 99
                  AND [AV].[Cycle Number] <= @p_CN
                  AND [SD].[School District Code] IN(@p_SD)
            GROUP BY [AG].[Jurisdiction Code], 
                     [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
                     [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Desc], 
                     [PC].[Property Class Code], 
                     [PC].[Property Sub Class Code]
        ) AS [Occurances]
        GROUP BY [Jurisdiction Code], 
                 [Jurisdiction], 
                 [JurisdictionRural]
    ) AS [OCCURLIST]
) AS [OCCUR]
INNER JOIN
(
    SELECT [SD].[School District Code] AS [School District Code], 
           [SD].[School District Desc] AS  [School District], 
           [AG].[Jurisdiction Code], 
           SUM(CASE
                   WHEN [PC].[Property Class Code] = '01'
                        AND [AV].[Assessment Code] = '01'
                   THEN [AV].[Net School Land Value]
               END) AS                     [Res Net Land], 
           SUM(CASE
                   WHEN [PC].[Property Class Code] = '01'
                        AND [AV].[Assessment Code] <> '01'
                   THEN [AV].[Net School Building Value]
               END) AS                     [Res Net Impr], 
           SUM(CASE
                   WHEN [PC].[Property Class Code] <> '01'
                        AND [AV].[Assessment Code] = '01'
                   THEN [AV].[Net School Land Value]
               END) AS                     [Non Res Net Land], 
           SUM(CASE
                   WHEN [PC].[Property Class Code] <> '01'
                        AND [AV].[Assessment Code] <> '01'
                   THEN [AV].[Net School Building Value]
               END) AS                     [Non Res Net Impr]
    FROM [edw].[FactAllAssessedAmounts] AS [AV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [AV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
            AND [PC].[Roll Year] = @p_RY
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [AV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            AND [AG].[Roll Category Code] = '1'
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [AV].[dimFolio_SK]
            AND [FO].[Folio Status Code] = '01'
         INNER JOIN [edw].[dimSchoolDistrict] AS [SD]
         ON [SD].[School  District Code] = [FO].[School  District Code]
            AND [SD].[Roll Year] = @p_RY
    WHERE [AV].[Roll Year] = @p_RY
          AND [AV].[Cycle Number] <= @p_CN
          AND [SD].[School  District Code] IN(@p_SD)
    GROUP BY [SD].[School  District Code], 
             [SD].[School District Desc], 
             [AG].[Jurisdiction Code]
) AS [NET]
ON [OCCUR].[Jurisdiction Code] = [NET].[Jurisdiction Code]
INNER JOIN [edw].[dimJurisdiction] AS [JR]
ON [NET].[Jurisdiction Code] = [JR].[Jurisdiction Code]
INNER JOIN [edw].[dimArea] AS [AR]
ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
WHERE [School District Code] IN(@p_SD)
ORDER BY [School District Code], 
         [School District], 
         [Area], 
         [JurisdictionFormatted];