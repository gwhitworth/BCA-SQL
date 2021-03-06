SELECT [FAV].[Property Class Code], 
       [FAV].[Property Sub Class Code], 
       [FAV].[Assessment Code], 
       COUNT(*)
FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
WHERE [FAV].[Roll Year] = 2017
      AND [AG].[Roll Category Code] = '1'
      AND [FAV].[Cycle Number] <= -1
      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14')
     AND [AG].[Jurisdiction Code] = '317'
     AND [FAV].[Property Class Code] = '01'
GROUP BY [FAV].[Property Class Code], 
         [FAV].[Property Sub Class Code], 
         [FAV].[Assessment Code]
HAVING COUNT(*) > 1;