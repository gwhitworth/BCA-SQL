If(OBJECT_ID('tempdb..#Temp') Is Not Null)
Begin
    Drop Table #Temp
End
create table #Temp
(
    Code1 varchar(10), 
    Code2 Varchar(10), 
    Code3 varchar(10)
)
Insert into #Temp Values('Gen', 'Gross', 'Land')
Insert into #Temp Values('Gen', 'Gross', 'Impr')
Insert into #Temp Values('Sch', 'Gross', 'Land')
Insert into #Temp Values('Sch', 'Gross', 'Impr')
Insert into #Temp Values('Hsptl', 'Gross', 'Land')
Insert into #Temp Values('Hsptl', 'Gross', 'Impr')

Insert into #Temp Values('Gen', 'Exmpt', 'Land')
Insert into #Temp Values('Gen', 'Exmpt', 'Impr')
Insert into #Temp Values('Sch', 'Exmpt', 'Land')
Insert into #Temp Values('Sch', 'Exmpt', 'Impr')
Insert into #Temp Values('Hsptl', 'Exmpt', 'Land')
Insert into #Temp Values('Hsptl', 'Exmpt', 'Impr')

Insert into #Temp Values('Gen', 'Net', 'Land')
Insert into #Temp Values('Gen', 'Net', 'Impr')
Insert into #Temp Values('Sch', 'Net', 'Land')
Insert into #Temp Values('Sch', 'Net', 'Impr')
Insert into #Temp Values('Hsptl', 'Net', 'Land')
Insert into #Temp Values('Hsptl', 'Net', 'Impr')

SELECT * FROM #Temp

SELECT DISTINCT 
	   [dimFolio_SK],
	   [PC].[Property Class Code],
	   [PC].[Property Sub Class Code], 
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
AND dimRollCycle_SK = 87

SELECT *
FROM
(
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
AND dimRollCycle_SK = 87 AND [PC].[Property Class Code] = '01'
) [DataTable] PIVOT(Sum([VALUE]) FOR [CODE] 
IN(
[Gen Gross Land PC 01],
[Gen Gross Impr PC 01],
[Gen Gross Total PC 01]
)
) AS [PiotPC];




--SELECT *
--FROM [edw].[FactTotalAllAmounts] AS [FACT]
--WHERE [dimFolio_SK] = 4703916
--AND dimRollCycle_SK = 87;