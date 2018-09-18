DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SELECT [FA].[Roll Year], [AG].[Region Code],
		[AG].[Area Desc],
	   'AA'+[AG].[Area Code] AS [Area Code], 
       [AG].[Jurisdiction Code], 
	   AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc] AS [Jurisdiction], 
	   [ED].[BCA Code],
	   COUNT(DISTINCT [FA].dimFolio_SK) AS [Folio],
	   --COUNT(CASE
    --               WHEN [FA].[Assessment Code] = '02'
    --               THEN [FA].dimFolio_SK
    --           END) AS [Junk],
       IIF(SUM([FA].[Net General Land Value]) = 0, NULL, SUM([FA].[Net General Land Value])) AS [Land], 
       IIF(SUM([FA].[Net General Building Value]) = 0, NULL, SUM([FA].[Net General Building Value])) AS [Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
	LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
 LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
    WHERE [FAV].[Roll Year] = @p_RY
          AND AG.[Roll Category Code] = '1'
          AND [FAV].[Cycle Number] <= @p_CN
          AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14', '15')
         AND [Assessment Code] = '02'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [FA].[Roll Year] = @p_RY
      AND AG.[Roll Category Code] = '1'
      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14', '15')
AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213','317')
GROUP BY [FA].[Roll Year], 
 [AG].[Region Code],
         [AG].[Area Desc],
	   'AA'+[AG].[Area Code],
         [AG].[Jurisdiction Code], 
         AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc], 

		 [ED].[BCA Code]

ORDER BY [FA].[Roll Year],
 [AG].[Region Code],
[AG].[Area Desc], 
         [Area Code], 
         [AG].[Jurisdiction Code]

--Count Proof

--SELECT [AG].[Jurisdiction Code],COUNT(DISTINCT [FA].dimFolio_SK)
--FROM [edw].[FactAllAssessedAmounts] AS [FA]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
--group by [AG].[Jurisdiction Code]

--SELECT [AG].[Jurisdiction Code],COUNT(DISTINCT [FA].dimFolio_SK)
--FROM [edw].[FactAssessedValue] AS [FA]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
--group by [AG].[Jurisdiction Code]

--SELECT [AG].[Jurisdiction Code],COUNT(DISTINCT [FA].dimFolio_SK)
--FROM [edw].[FactActualAmounts] AS [FA]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
--group by [AG].[Jurisdiction Code]


















--SELECT [FA].*
--FROM [edw].[FactAllAssessedAmounts] AS [FA]

--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--	  and [FA].[Assessment Code] = '01'
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')

--SELECT [FA].*
--FROM [edw].[FactAssessedValue]AS [FA]

--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--WHERE [FA].[Roll Year] = @p_RY
--      AND AG.[Roll Category Code] = '1'
--      AND [AG].[Area Code] IN('01')
--	  and [FA].[Assessment Code] = '01'
--AND [FA].[Cycle Number] = @p_CN
--AND [AG].[Jurisdiction Code] in ('213')
