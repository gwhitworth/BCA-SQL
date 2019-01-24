SELECT *
FROM
(
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Gross Land PC '+[PC].[Property Class Code]
            ELSE 'Gen Gross Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
       [Gross General Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Sch Gross Land PC '+[PC].[Property Class Code]
            ELSE 'Sch Gross Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
       [Gross School Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Hsptl Gross Land PC '+[PC].[Property Class Code]
            ELSE 'Hsptl Gross Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
       [Gross Other Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Gross Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Gen Gross Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
       [Gross General Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Sch Gross Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Sch Gross Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
       [Gross School Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Hsptl Gross Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Hsptl Gross Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
       [Gross Other Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87

UNION

SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Exmpt Land PC '+[PC].[Property Class Code]
            ELSE 'Gen Exmpt Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
       [General Exemptions Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Sch Exmpt Land PC '+[PC].[Property Class Code]
            ELSE 'Sch Exmpt Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
       [School Exemptions Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Hsptl Exmpt Land PC '+[PC].[Property Class Code]
            ELSE 'Hsptl Exmpt Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
        [Other Exemptions Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Exmpt Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Gen Exmpt Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
        [General Exemptions Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Sch Exmpt Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Sch Exmpt Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
        [School Exemptions Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Hsptl Exmpt Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Hsptl Exmpt Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
        [Other Exemptions Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87

UNION

SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Net Land PC '+[PC].[Property Class Code]
            ELSE 'Gen Net Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
        [Net General Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Sch Net Land PC '+[PC].[Property Class Code]
            ELSE 'Sch Net Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
        [Net School Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Hsptl Net Land PC '+[PC].[Property Class Code]
            ELSE 'Hsptl Net Impr PC '+[PC].[Property Class Code]
        END) AS [CODE], 
        [Net Other Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Gen Net Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Gen Net Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
        [Net General Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Sch Net Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Sch Net Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
        [Net School Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87
UNION
SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code], 
       (CASE [Assessment Code]
            WHEN '01'
            THEN 'Hsptl Net Land Psc '+[PC].[Property Sub Class Code]
            ELSE 'Hsptl Net Impr Psc '+[PC].[Property Sub Class Code]
        END) AS [CODE], 
       [Net Other Value] AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87


) [DataTable] PIVOT(Sum([VALUE]) FOR [CODE] 
IN(
[Gen Gross Land PC 01],
[Gen Gross Impr PC 01],
[Sch Gross Land PC 01],
[Sch Gross Impr PC 01],
[Hsptl Gross Land PC 01],
[Hsptl Gross Impr PC 01],

[Gen Gross Land Psc 0101],
[Gen Gross Impr Psc 0101],
[Sch Gross Land Psc 0101],
[Sch Gross Impr Psc 0101],
[Hsptl Gross Land Psc 0101],
[Hsptl Gross Impr Psc 0101],

[Gen Gross Land Psc 0102],
[Gen Gross Impr Psc 0102],
[Sch Gross Land Psc 0102],
[Sch Gross Impr Psc 0102],
[Hsptl Gross Land Psc 0102],
[Hsptl Gross Impr Psc 0102],

[Gen Gross Land Psc 0103],
[Gen Gross Impr Psc 0103],
[Sch Gross Land Psc 0103],
[Sch Gross Impr Psc 0103],
[Hsptl Gross Land Psc 0103],
[Hsptl Gross Impr Psc 0103],

[Gen Gross Land Psc 0104],
[Gen Gross Impr Psc 0104],
[Sch Gross Land Psc 0104],
[Sch Gross Impr Psc 0104],
[Hsptl Gross Land Psc 0104],
[Hsptl Gross Impr Psc 0104],

[Gen Gross Land Psc 0105],
[Gen Gross Impr Psc 0105],
[Sch Gross Land Psc 0105],
[Sch Gross Impr Psc 0105],
[Hsptl Gross Land Psc 0105],
[Hsptl Gross Impr Psc 0105],

[Gen Gross Land Psc 0106],
[Gen Gross Impr Psc 0106],
[Sch Gross Land Psc 0106],
[Sch Gross Impr Psc 0106],
[Hsptl Gross Land Psc 0106],
[Hsptl Gross Impr Psc 0106],

--
[Gen Gross Land PC 02],
[Gen Gross Impr PC 02],
[Sch Gross Land PC 02],
[Sch Gross Impr PC 02],
[Hsptl Gross Land PC 02],
[Hsptl Gross Impr PC 02],

--
[Gen Gross Land Psc 0201],
[Gen Gross Impr Psc 0201],
[Sch Gross Land Psc 0201],
[Sch Gross Impr Psc 0201],
[Hsptl Gross Land Psc 0201],
[Hsptl Gross Impr Psc 0201],

--
[Gen Gross Land Psc 0202],
[Gen Gross Impr Psc 0202],
[Sch Gross Land Psc 0202],
[Sch Gross Impr Psc 0202],
[Hsptl Gross Land Psc 0202],
[Hsptl Gross Impr Psc 0202],

----
[Gen Gross Land PC 03],
[Gen Gross Impr PC 03],
[Sch Gross Land PC 03],
[Sch Gross Impr PC 03],
[Hsptl Gross Land PC 03],
[Hsptl Gross Impr PC 03],

----
[Gen Gross Land PC 04],
[Gen Gross Impr PC 04],
[Sch Gross Land PC 04],
[Sch Gross Impr PC 04],
[Hsptl Gross Land PC 04],
[Hsptl Gross Impr PC 04],

----
[Gen Gross Land PC 05],
[Gen Gross Impr PC 05],
[Sch Gross Land PC 05],
[Sch Gross Impr PC 05],
[Hsptl Gross Land PC 05],
[Hsptl Gross Impr PC 05],

----
[Gen Gross Land PC 06],
[Gen Gross Impr PC 06],
[Sch Gross Land PC 06],
[Sch Gross Impr PC 06],
[Hsptl Gross Land PC 06],
[Hsptl Gross Impr PC 06],

----
[Gen Gross Land PC 07],
[Gen Gross Impr PC 07],
[Sch Gross Land PC 07],
[Sch Gross Impr PC 07],
[Hsptl Gross Land PC 07],
[Hsptl Gross Impr PC 07],

----
[Gen Gross Land PC 08],
[Gen Gross Impr PC 08],
[Sch Gross Land PC 08],
[Sch Gross Impr PC 08],
[Hsptl Gross Land PC 08],
[Hsptl Gross Impr PC 08],

----
[Gen Gross Land PC 09],
[Gen Gross Impr PC 09],
[Sch Gross Land PC 09],
[Sch Gross Impr PC 09],
[Hsptl Gross Land PC 09],
[Hsptl Gross Impr PC 09],

----
[Gen Gross Land PC 10],
[Gen Gross Impr PC 10],
[Sch Gross Land PC 10],
[Sch Gross Impr PC 10],
[Hsptl Gross Land PC 10],
[Hsptl Gross Impr PC 10]
)
) AS [PiotPC];
