DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
SET @p_RY = 2017;
SET @p_CN = 10;
SELECT [FO].[Jurisdiction Code] AS [JUR_CODE], 
       [PC].[Property Class Code] AS [PC_CODE], 
       [FA].[Roll Year] AS [ROLL_YEAR], 
       REPLACE(CAST([FA].[Roll Effective Date] AS VARCHAR(10)),'-','') AS [ROLL_DATE], 
       [FA].[Cycle Number] AS [CYCLE_NUM], 
       SUM([FA].[Net School Land Value]) AS [SCH_NT_LAND], 
       SUM([FA].[Net School Building Value]) AS [SCH_NT_IMPR], 
       SUM([FA].[Net School Building Value]) + SUM([FA].[Net School Building Value]) AS [SCH_NT_TOTAL], 
       ISNULL(SUM([OC].[Property Class Occurrence]), 0) AS [OCCURRENCES]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN [edw].[FactPropertyClassOccurrenceCount] AS [OC]
     ON [FO].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
	  AND [FO].[Jurisdiction Code] > '199'
GROUP BY [FO].[Jurisdiction Code], 
         [PC].[Property Class Code], 
         [FA].[Roll Year], 
         [FA].[Roll Effective Date], 
         [FA].[Cycle Number]
ORDER BY [FO].[Jurisdiction Code], 
         [PC].[Property Class Code], 
         [FA].[Roll Year], 
         [FA].[Roll Effective Date], 
         [FA].[Cycle Number];