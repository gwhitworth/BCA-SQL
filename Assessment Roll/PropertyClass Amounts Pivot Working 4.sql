If(OBJECT_ID('tempdb..#Temp') Is Not Null)
Begin
    Drop Table #Temp
End
create table #Temp
(
    Code1 varchar(10), 
    Code2 Varchar(10), 
    Code3 varchar(10),
	ColName varchar(50)
)
Insert into #Temp Values('Gen', 'Gross', 'Land','Gross General Value')
Insert into #Temp Values('Gen', 'Gross', 'Impr', 'Gross General Value')
Insert into #Temp Values('Sch', 'Gross', 'Land','Gross School Value')
Insert into #Temp Values('Sch', 'Gross', 'Impr','Gross School Value')
Insert into #Temp Values('Hsptl', 'Gross', 'Land','Gross Other Value')
Insert into #Temp Values('Hsptl', 'Gross', 'Impr','Gross Other Value')

Insert into #Temp Values('Gen', 'Exmpt', 'Land', 'General Exemptions Value')
Insert into #Temp Values('Gen', 'Exmpt', 'Impr', 'General Exemptions Value')
Insert into #Temp Values('Sch', 'Exmpt', 'Land', 'School Exemptions Value')
Insert into #Temp Values('Sch', 'Exmpt', 'Impr', 'School Exemptions Value')
Insert into #Temp Values('Hsptl', 'Exmpt', 'Land', 'Other Exemptions Value')
Insert into #Temp Values('Hsptl', 'Exmpt', 'Impr', 'Other Exemptions Value')

Insert into #Temp Values('Gen', 'Net', 'Land', 'Net General Value')
Insert into #Temp Values('Gen', 'Net', 'Impr', 'Net General Value')
Insert into #Temp Values('Sch', 'Net', 'Land', 'Net School Value')
Insert into #Temp Values('Sch', 'Net', 'Impr', 'Net School Value')
Insert into #Temp Values('Hsptl', 'Net', 'Land', 'Net Other Value')
Insert into #Temp Values('Hsptl', 'Net', 'Impr', 'Net Other Value')

SELECT * FROM #Temp

SELECT DISTINCT 
	   [dimFolio_SK],
	   [PC].[Property Class Code],
	   [PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Gross Land PC '+[PC].[Property Class Code]
            ELSE 'Gen Gross Impr PC '+[PC].[Property Class Code]
        END) AS [CODE1], 
       [Gross General Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4703916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   [PC].[Property Class Code],
	   [PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Sch Gross Land PC '+[PC].[Property Class Code]
            ELSE 'Sch Gross Impr PC '+[PC].[Property Class Code]
        END) AS [CODE1], 
       [Gross School Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4703916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   [PC].[Property Class Code],
	   [PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Hsptl Gross Land PC '+[PC].[Property Class Code]
            ELSE 'Hsptl Gross Impr PC '+[PC].[Property Class Code]
        END) AS [CODE1], 
       [Gross Other Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
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
       [Gross General Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
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




SELECT *
FROM [edw].[FactAssessedValue]
WHERE [dimFolio_SK] = 4703916
AND dimRollCycle_SK = 87;