--SELECT [FAV].[Property Class Code], 
--       [FAV].[Property Sub Class Code], 
--       [FAV].[Assessment Code], 
--       COUNT(*)
--FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FAV].[Roll Year] = 2017
--      AND AG.[Roll Category Code] = '1'
--      AND [FAV].[Cycle Number] <= -1
--      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14')
--     AND [AG].[Jurisdiction Code] = '317'
--     AND [FAV].[Property Class Code] = '01'
--GROUP BY [FAV].[Property Class Code], 
--         [FAV].[Property Sub Class Code], 
--         [FAV].[Assessment Code]
--HAVING COUNT(*) > 1;

SELECT [FAV].dimFolio_SK,
		[FAV].[Property Class Code], 
 
       COUNT(*)
FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
WHERE [FAV].[Roll Year] = 2017
      AND AG.[Roll Category Code] = '1'
      AND [FAV].[Cycle Number] <= -1
      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14')
     AND [AG].[Jurisdiction Code] = '317'
	 and [Assessment Code] = '02'
GROUP BY  [FAV].dimFolio_SK,
		[FAV].[Property Class Code]
HAVING COUNT(*) > 1;

SELECT Count(*)
FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
	 INNER JOIN [edw].[dimFolio] AS [FO]
			ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]

WHERE [FAV].[Roll Year] = 2017
      AND AG.[Roll Category Code] = '1'
      AND [FAV].[Cycle Number] <= -1
      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14')
     AND [AG].[Jurisdiction Code] = '317'
	 and [FAV].[Property Class Code] = '01'
	 and [FAV].[Property Sub Class Code] = '0102'
	  and [Assessment Code] = '01'
	 --and [FO].[Roll Number] = '08285701'




--SELECT distinct [FAV].dimFolio_SK
--FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FAV].[Roll Year] = 2017
--      AND AG.[Roll Category Code] = '1'
--      AND [FAV].[Cycle Number] <= -1
--      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14')
--     AND [AG].[Jurisdiction Code] = '317'
--	 AND [FAV].dimFolio_SK in (SELECT [FAV2].dimFolio_SK
--								FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV2]
--								WHERE [FAV2].[Roll Year] = 2017
--      AND AG.[Roll Category Code] = '1'
--      AND [FAV].[Cycle Number] <= -1
--      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14')
--     AND [AG].[Jurisdiction Code] = '317'
--	 and [FAV].dimFolio_SK = [FAV2].dimFolio_SK
--	 AND [FAV].[Property Class Code] =  [FAV2].[Property Class Code]
--	 and  [FAV].[Property Sub Class Code] = [FAV2].[Property Sub Class Code]
--								)
