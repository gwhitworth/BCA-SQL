DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT [AG].[Area Code] AS [AREA], 
       [AG].[Jurisdiction Code] AS [JUR], 
       [FA].[Property Class Code] AS [ASSD PC], 
       SUM([FA].[Net School Land Value]) AS [SCHOOL_LAND], 
       SUM([FA].[Net School Building Value]) AS [SCHOOL_IMPR]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND AG.[Roll Category Code] = '1'
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Property Class Code] <> 'UNK'
GROUP BY [AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         [FA].[Property Class Code]
ORDER BY [AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         [FA].[Property Class Code];