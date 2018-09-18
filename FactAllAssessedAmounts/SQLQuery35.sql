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
							
   WHERE [FAV].[Property Class Code] = '01'
          AND [FAV].[Roll Year] = 2017
          AND [FAV].[Cycle Number] = -1
          AND [JR].[Jurisdiction Code] = '317'
          AND [FAV].[Assessment Code] = '01'
	GROUP BY [FAV].[dimFolio_SK]
	HAVING COunt(*) > 1