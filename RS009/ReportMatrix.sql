DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = 10;
SET @p_JR = '213';
SELECT [Region Code] AS [Code],[01]
FROM
(
SELECT '50' AS [Decision], 
                [AG].[Area Code], 
                [AG].[Jurisdiction Code], 
                [AG].[Region Code], 
                [PC].[Property Class Code] AS [PropClass],
				[FAA].[Folio Number]
FROM [edw].[FactActualAmounts] AS [FAA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FAA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimRollType] AS [RT]
     ON [RT].[dimRollType_SK] = [FAA].[dimRollType_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FAA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Roll Category Code] = '1'
WHERE [FAA].[dimRollType_BK] = 'PAAB'
      AND [FAA].[Roll Year] = @p_RY
      AND [FAA].[Cycle Number] = @p_CN


) AS SourceTable
PIVOT
(
COUNT([Folio Number]) FOR [PropClass] IN ([01])
) AS PivotTable
ORDER BY [Code]