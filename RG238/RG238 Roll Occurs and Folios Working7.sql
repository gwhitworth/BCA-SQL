DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;

SELECT [FAV].[dimFolio_SK], 
       IIF(COUNT(CASE
                     WHEN [PC].[Property Class Code] = '01' AND [FAV].[Assessment Code] = '01'
                     THEN [FAV].[dimFolio_SK]
                 END) = 0, COUNT(DISTINCT [FAV].[dimFolio_SK]), COUNT(CASE
                                                                          WHEN [PC].[Property Class Code] = '01' AND [FAV].[Assessment Code] = '01'
                                                                          THEN [FAV].[dimFolio_SK]
                                                                      END)) AS [Occurrences], 
       COUNT(DISTINCT [FAV].[dimFolio_SK]) AS [Folio Count], 
       SUM(CASE
               WHEN PC.[Property Class Code] = '01'
                    AND [FAV].[Assessment Code] = '01'
               THEN [Gross Other Value]
           END) AS [Gross Land], 
       SUM(CASE
               WHEN PC.[Property Class Code] = '01'
                    AND [FAV].[Assessment Code] <> '01'
               THEN [Gross Other Value]
           END) AS [Gross Improvements],
       SUM(CASE
               WHEN PC.[Property Class Code] <> '01'
                    AND [FAV].[Assessment Code] = '01'
               THEN [Other Exemptions Value]
           END)*-1 AS [Exempt Land], 
       SUM(CASE
               WHEN PC.[Property Class Code] <> '01'
                    AND [FAV].[Assessment Code] <> '01'
               THEN [Other Exemptions Value]
           END)*-1 AS [Exempt Improvements],		    
       SUM(CASE
               WHEN PC.[Property Class Code] <> '01'
                    AND [FAV].[Assessment Code] = '01'
               THEN [Net Other Value]
           END) AS [Net Land], 
       SUM(CASE
               WHEN PC.[Property Class Code] <> '01'
                    AND [FAV].[Assessment Code] <> '01'
               THEN [Net Other Value]
           END) AS [Net Improvements]

FROM [edw].[FactAssessedValue] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
		ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
			AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
     INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimArea] AS [AR] 
		ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
		   AND [AR].[Area Code] IN ('01', '08', '09', '10', '11', '14')
     INNER JOIN [edw].[dimFolio] AS [FO] 
		ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
			AND [FO].[Folio Status Code] = '01'
WHERE [FAV].[Property Class Code] < 99
      AND [FAV].[Roll Year] = @p_RY
      AND [FAV].[Cycle Number] <= @p_CN
     AND [JR].[Jurisdiction Code] = '317'
	 AND [FO].[Roll Number] = '08285701'
GROUP BY [FAV].[dimFolio_SK]
ORDER BY [FAV].[dimFolio_SK];