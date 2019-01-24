--If(OBJECT_ID('tempdb..#Temp2') Is Not Null)
--Begin
--    Drop Table #Temp2
--End


DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX) 

declare @Temp2  table 
(
    ColumnName varchar(50), 
	Value varchar(50)
)
Insert into @Temp2 Values('Gen Gross Land','Gross General Value')
Insert into @Temp2 Values('Gen Gross Impr', 'Gross General Value')
Insert into @Temp2 Values('Sch Gross Land','Gross School Value')
Insert into @Temp2 Values('Sch Gross Impr','Gross School Value')
Insert into @Temp2 Values('Hsptl Gross Land','Gross Other Value')
Insert into @Temp2 Values('Hsptl Gross Impr','Gross Other Value')

set @query = 'SELECT DISTINCT 
	   [dimFolio_SK],
	   --[PC].[Property Class Code],
	   --[PC].[Property Sub Class Code],
	  [JUNK.ColumnName] , 
       (CASE [Assessment Code]
            WHEN ''01''
            THEN ''Gen Gross Land PC ''+[PC].[Property Class Code]
            ELSE ''Gen Gross Impr PC ''+[PC].[Property Class Code]
        END) AS [CODE], 
       [JUNK.Value]  AS [VALUE]
FROM [edw].[FactAssessedValue] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
	 CROSS JOIN ' + @Temp2 + ' AS JUNK
WHERE [dimFolio_SK] = 4705916
AND dimRollCycle_SK = 87'
exec sp_executesql @query;



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

) [DataTable] PIVOT(Sum([VALUE]) FOR [CODE] 
IN(
[Gen Gross Land PC 01],
[Gen Gross Impr PC 01],
[Sch Gross Land PC 01],
[Sch Gross Impr PC 01],
[Hsptl Gross Land PC 01],
[Hsptl Gross Impr PC 01]
)
) AS [PiotPC];
