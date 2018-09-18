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
       SUM([Gross Improvements]) AS [Gross Improvements], 
       SUM([Net Improvements]) AS [Net Improvements], 
       SUM([Exempt Improvements]) AS [Exempt Improvements]
FROM [edw].[FactAssessedValue] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
     INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
     --INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
     INNER JOIN
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
    WHERE [FAV].[Assessment Code] = '02'
    GROUP BY [FAV].[dimFolio_SK]
) AS [DATAIMPROV] ON [DATAIMPROV].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE [FAV].[Property Class Code] = '01'
      AND [FAV].[Roll Year] = @p_RY
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