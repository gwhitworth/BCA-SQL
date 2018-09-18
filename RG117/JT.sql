SELECT [Jurisdiction Type Desc],
       CASE
           WHEN [Property Class Code] = '01'
           THEN 'RES'
           WHEN [Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       [Property Class], 
       [Folios], 
       [Res Occur] + [Non Res Occur] AS [Occurrences], 
       ISNULL([Res Net Land], 0) + ISNULL([Non Res Net Land], 0) AS [Net Land], 
       ISNULL([Res Net Impr], 0) + ISNULL([Non Res Net Impr], 0) AS [Net Improvements]
FROM
(
    SELECT JRT.[Jurisdiction Type Desc], 
           PC.[Property Class Code], 
           PC.[Property Class], 
           COUNT(DISTINCT AV.dimFolio_SK) AS [Folios], 
           COUNT(DISTINCT CASE
                              WHEN PC.[Property Class Code] = '01'
                                   AND AV.[Assessment Code] <> '01'
                              THEN AV.dimFolio_SK
                          END) AS [Res Occur], 
           COUNT(DISTINCT CASE
                              WHEN PC.[Property Class Code] <> '01'
                                   AND AV.[Assessment Code] = '01'
                              THEN AV.dimFolio_SK
                          END) AS [Non Res Occur], 
           SUM(CASE
                   WHEN PC.[Property Class Code] = '01'
                        AND AV.[Assessment Code] = '01'
                   THEN AV.[Net School Value]
               END) AS [Res Net Land], 
           SUM(CASE
                   WHEN PC.[Property Class Code] = '01'
                        AND AV.[Assessment Code] <> '01'
                   THEN AV.[Net School Value]
               END) AS [Res Net Impr], 
           SUM(CASE
                   WHEN PC.[Property Class Code] <> '01'
                        AND AV.[Assessment Code] = '01'
                   THEN AV.[Net School Value]
               END) AS [Non Res Net Land], 
           SUM(CASE
                   WHEN PC.[Property Class Code] <> '01'
                        AND AV.[Assessment Code] <> '01'
                   THEN AV.[Net School Value]
               END) AS [Non Res Net Impr]
    FROM edw.FactAssessedValue AS AV
         INNER JOIN edw.dimPropertyClass AS PC ON AV.dimPropertyClass_SK = PC.dimPropertyClass_SK
         INNER JOIN edw.dimAssessmentGeography AS AG ON AV.dimAssessmentGeography_SK = AG.dimAssessmentGeography_SK
         INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
         INNER JOIN [edw].[dimJurisdictiontYPE] AS JRT ON JR.dimJurisdictionType_SK = JRT.dimJurisdictionType_SK
         INNER JOIN [edw].[dimFolio] AS FO ON FO.dimFolio_SK = AV.dimFolio_SK
    WHERE AV.[Roll Year] = @p_RY
          AND [AV].[Property Class Code] < 99
          AND FO.[Folio Status Code] = '01'
          AND AG.[Roll Category Code] = '1'
          AND [AV].[Cycle Number] <= @p_CN
    GROUP BY JRT.[Jurisdiction Type Desc], 
             PC.[Property Class Code], 
             PC.[Property Class]
) AS [JUR]
ORDER BY [Jurisdiction Type Desc], 
         [RESNONRES] DESC, 
         [Property Class];