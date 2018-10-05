DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = 10;
SET @p_JR = '213';
SELECT IIF([dimRollType_BK] = 'PAAB', '50', '01') AS [Decision], 
       [dimRollType_BK], 
       [Area Code], 
       [Area], 
       [Jurisdiction Code], 
       [Jurisdiction], 
       [Region Code], 
       [Region], 
       [01], 
       [02], 
       [03], 
       [04], 
       [05], 
       [06], 
       [07], 
       [08], 
       [09], 
       [DEL], 
       [UNK]
FROM
(
    SELECT DISTINCT 
           [FAA].[dimRollType_BK], 
           [AG].[Area Code], 
           [AG].[Area], 
           [AG].[Jurisdiction Code], 
           [AG].[Jurisdiction], 
           [AG].[Region Code], 
           [AG].[Region], 
           [PC].[Property Class Code], 
           [dimFolio_SK]
    FROM [edw].[FactActualAmounts] AS [FAA]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FAA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimRollType] AS [RT]
         ON [RT].[dimRollType_SK] = [FAA].[dimRollType_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FAA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            AND [AG].[Roll Category Code] = '1'
    WHERE([FAA].[dimRollType_BK] = 'PAAB'
          OR [FAA].[dimRollType_BK] = 'SUPP')
         AND [FAA].[Roll Year] = @p_RY
         AND [FAA].[Cycle Number] = @p_CN
) [p] PIVOT(COUNT([dimFolio_SK]) FOR [Property Class Code] IN([01], 
                                                              [02], 
                                                              [03], 
                                                              [04], 
                                                              [05], 
                                                              [06], 
                                                              [07], 
                                                              [08], 
                                                              [09], 
                                                              [DEL], 
                                                              [UNK])) AS [pvt]
ORDER BY [dimRollType_BK], 
         [Area Code], 
         [Jurisdiction Code], 
         [Region Code];