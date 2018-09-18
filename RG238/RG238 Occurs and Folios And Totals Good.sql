DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SELECT [FAV].[Roll Year], 
       [AR].[Area], 
       [JR].[Jurisdiction Code], 
       [JR].[Jurisdiction Desc], 
       [SD].[School  District Code], 
       [PC].[RowSortOrder], 
       [PC].[Property Class Code], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '01' AND [FAV].[Property Class Code] = '01'
               THEN [Occurrences]
			   WHEN [FAV].[Assessment Code] = '01'
               THEN [Folio Count]
               ELSE 0
           END) AS [Occurrences], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '01'
               THEN [Folio Count]
               ELSE 0
           END) AS [Folio Count], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '01'
               THEN [Gross Land]
               ELSE 0
           END) AS [Gross Land], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '01'
               THEN [Net Land]
               ELSE 0
           END) AS [Net Land], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '01'
               THEN [Exempt Land]
               ELSE 0
           END) AS [Exempt Land], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '02'
               THEN [Gross Improvements]
               ELSE 0
           END) AS [Gross Improvements], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '02'
               THEN [Net Improvements]
               ELSE 0
           END) AS [Net Improvements], 
       SUM(CASE
               WHEN [FAV].[Assessment Code] = '02'
               THEN [Exempt Improvements]
               ELSE 0
           END) AS [Exempt Improvements]
FROM [edw].[FactAssessedValue] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
     INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] 
		ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
			AND [FO].[BC Transit Flag] = 'Y'
			AND [FO].[Current Record Flag] = 'Y'
     LEFT JOIN
(
    SELECT [FAV].[dimFolio_SK], 
           IIF(COUNT([FAV].[dimFolio_SK]) = 0, COUNT(DISTINCT [FAV].[dimFolio_SK]), COUNT([FAV].[dimFolio_SK])) AS [Occurrences], 
           COUNT(DISTINCT [FAV].[dimFolio_SK]) AS [Folio Count]
    FROM [edw].[FactAssessedValue] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND AG.[Roll Category Code] = '1'
         INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
         INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
         INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
                                               AND [AR].[Area Code] IN('01', '08', '09', '10', '11', '14')
         INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
                                                AND [FO].[Folio Status Code] = '01'
												AND [FO].[BC Transit Flag] = 'Y'
												AND [FO].[Current Record Flag] = 'Y'
    WHERE [FAV].[Assessment Code] = '01'
    GROUP BY [FAV].[dimFolio_SK]
) AS [DATA] ON [DATA].[dimFolio_SK] = [FAV].[dimFolio_SK]
     LEFT OUTER JOIN
(
    SELECT [FAV].[dimFolio_SK], 
           SUM([Gross Other Value]) AS [Gross Land], 
           SUM([Other Exemptions Value]) * -1 AS [Exempt Land], 
           SUM([Net Other Value]) AS [Net Land]
    FROM [edw].[FactAssessedValue] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND AG.[Roll Category Code] = '1'
         INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
         INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
         INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
                                               AND [AR].[Area Code] IN('01', '08', '09', '10', '11', '14')
         INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
                                                AND [FO].[Folio Status Code] = '01'
												AND [FO].[BC Transit Flag] = 'Y'
												AND [FO].[Current Record Flag] = 'Y'
    WHERE [FAV].[Assessment Code] = '01'
    GROUP BY [FAV].[dimFolio_SK]
) AS [DATALAND] ON [DATALAND].[dimFolio_SK] = [FAV].[dimFolio_SK]
     LEFT OUTER JOIN
(
    SELECT [FAV].[dimFolio_SK], 
           SUM([Gross Other Value]) AS [Gross Improvements], 
           SUM([Other Exemptions Value]) * -1 AS [Exempt Improvements], 
           SUM([Net Other Value]) + SUM([Other Exemptions Value]) AS [Net Improvements]
    FROM [edw].[FactAssessedValue] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND AG.[Roll Category Code] = '1'
         INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
         INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
         INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
                                               AND [AR].[Area Code] IN('01', '08', '09', '10', '11', '14')
         INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
                                                AND [FO].[Folio Status Code] = '01'
												AND [FO].[BC Transit Flag] = 'Y'
												AND [FO].[Current Record Flag] = 'Y'
    WHERE [FAV].[Assessment Code] = '02'
    GROUP BY [FAV].[dimFolio_SK]
) AS [DATAIMPROV] ON [DATAIMPROV].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE [FAV].[Roll Year] = @p_RY
      AND [FAV].[Cycle Number] <= @p_CN
      AND [JR].[Jurisdiction Code] = '317'
      AND [Current Cycle Flag] = 'Yes'
GROUP BY [FAV].[Roll Year], 
         [AR].[Area], 
         [JR].[Jurisdiction Code], 
         [JR].[Jurisdiction Desc], 
         [SD].[School  District Code], 
         [PC].[RowSortOrder], 
         [PC].[Property Class Code], 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [FAV].[Roll Year], 
         [AR].[Area], 
         [JR].[Jurisdiction Code], 
         [JR].[Jurisdiction Desc], 
         [SD].[School  District Code], 
         [PC].[RowSortOrder], 
         [PC].[Property Class Code], 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]);