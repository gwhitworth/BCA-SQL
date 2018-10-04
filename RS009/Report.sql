DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = 10;
SET @p_JR = '213';
SELECT '50' AS [Decision], 
       [FAA].[dimRollType_BK], 
       [AG].[Area Code], 
       [AG].[Jurisdiction Code], 
       [AG].[Region Code], 
       [PC].[Property Class Code], 
       [FAA].[Folio Number]
FROM [edw].[FactActualAmounts] AS [FAA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimRollType] AS [RT] ON [RT].[dimRollType_SK] = [FAA].[dimRollType_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND [AG].[Roll Category Code] = '1'
WHERE([FAA].[dimRollType_BK] = 'PAAB'
      OR [FAA].[dimRollType_BK] = 'SUPP')
     AND [FAA].[Roll Year] = @p_RY
     AND [FAA].[Cycle Number] = @p_CN
ORDER BY [FAA].[dimRollType_BK], --[AG].[Area Code], 
         --[AG].[Jurisdiction Code], 
         --[AG].[Region Code], 
         [PC].[Property Class Code];