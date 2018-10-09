DECLARE @p_RY INT;
SET @p_RY = 2017;
DECLARE @P_CYCLE INT;
SELECT @P_CYCLE = MAX(CAST([Cycle Number] AS INT))
FROM [edw].[dimRollCycle]
WHERE [Roll Year] = @p_RY;
SELECT @P_CYCLE AS [Cycle Number], 
       [AG].[Area Code] AS [AREA], 
       [AG].[Jurisdiction Code] AS [JUR], 
       [FA].[Property Class Code] AS [ASSD PC], 
       SUM([FA].[Net School Land Value]) AS [SCHOOL_LAND], 
       SUM([FA].[Net School Building Value]) AS [SCHOOL_IMPR]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimRollType] AS [RT]
         ON [RT].[dimRollType_SK] = [FA].[dimRollType_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            AND [AG].[Roll Category Code] = '1'
    WHERE([RT].[dimRollType_BK] = 'PAAB'
          OR [RT].[dimRollType_BK] = 'SUPP')
         AND [FA].[Roll Year] = @p_RY
      AND [FA].[Property Class Code] <> 'UNK'
GROUP BY [AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         [FA].[Property Class Code]
ORDER BY [AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         [FA].[Property Class Code];