SELECT DISTINCT 
       [dimFolio_SK], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Gross Land PC '+[PC].[Property Class Code]
            ELSE 'Gen Gross Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN [Gross General Land Value]
            ELSE [Gross General Building Value]
        END) AS [VALUE]
FROM [edw].[FactTotalAllAmounts] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4703916
AND dimRollCycle_SK = 87 AND [PC].[Property Class Code] = '01' ;

--SELECT *
--FROM [edw].[FactTotalAllAmounts] AS [FACT]
--WHERE [dimFolio_SK] = 4703916
--AND dimRollCycle_SK = 87;