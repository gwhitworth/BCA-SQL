
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
           [PC].[Property Class Code]+' - '+[PC].[Property Class Desc] AS [DESC]
    FROM [edw].[FactAssessedValue] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
		 where [dimFolio_SK] = 4703916
    UNION
    SELECT DISTINCT 
           [dimFolio_SK], 
           (CASE [Assessment Code]
                WHEN '01'
                THEN 'Gen Gross Land Psc '+[PC].[Property Sub Class Code]
                ELSE 'Gen Gross Impr Psc '+[PC].[Property Sub Class Code]
            END) AS [CODE], 
           [PC].[Property Sub Class Code]+' - '+[PC].[Property Sub Class Desc] AS [DESC]
    FROM [edw].[FactAssessedValue] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
		 where [dimFolio_SK] = 4703916
		 AND dimRollCycle_SK = 87
) [DataTable] PIVOT(MAX([DESC]) FOR [CODE] 
IN(
[Gen Gross Land PC 01],
[Gen Gross Impr PC 01],
[Gen Gross Total PC 01],
[Sch Gross Land PC 01],
[Sch Gross Impr PC 01],
[Sch Gross Total PC 01],
[Hsptl Gross Land PC 01],
[Hsptl Gross Impr PC 01],
[Hsptl Gross Total PC 01],
[Gen Exmpt Land PC 01],
[Gen Exmpt Impr PC 01],
[Gen Exmpt Total PC 01],
[Sch Exmpt Land PC 01],
[Sch Exmpt Impr PC 01],
[Sch Exmpt Total PC 01],
[Hsptl Exmpt Land PC 01],
[Hsptl Exmpt Impr PC 01],
[Hsptl Exmpt Total PC 01],
[Gen Net Land PC 01],
[Gen Net Impr PC 01],
[Gen Net Total PC 01],
[Sch Net Land PC 01],
[Sch Net Impr PC 01],
[Sch Net Total PC 01],
[Hsptl Net Land PC 01],
[Hsptl Net Impr PC 01],
[Hsptl Net Total PC 01],
[Gen Gross Land Psc 0101],
[Gen Gross Impr Psc 0101],
[Gen Gross Total Psc 0101],
[Sch Gross Land Psc 0101],
[Sch Gross Impr Psc 0101],
[Sch Gross Total Psc 0101],
[Hsptl Gross Land Psc 0101],
[Hsptl Gross Impr Psc 0101],
[Hsptl Gross Total Psc 0101],
[Gen Exmpt Land Psc 0101],
[Gen Exmpt Impr Psc 0101],
[Gen Exmpt Total Psc 0101],
[Sch Exmpt Land Psc 0101],
[Sch Exmpt Impr Psc 0101],
[Sch Exmpt Total Psc 0101],
[Hsptl Exmpt Land Psc 0101],
[Hsptl Exmpt Impr Psc 0101],
[Hsptl Exmpt Total Psc 0101],
[Gen Net Land Psc 0101],
[Gen Net Impr Psc 0101],
[Gen Net Total Psc 0101],
[Sch Net Land Psc 0101],
[Sch Net Impr Psc 0101],
[Sch Net Total Psc 0101],
[Hsptl Net Land Psc 0101],
[Hsptl Net Impr Psc 0101],
[Hsptl Net Total Psc 0101],
[Gen Gross Land Psc 0102],
[Gen Gross Impr Psc 0102],
[Gen Gross Total Psc 0102],
[Sch Gross Land Psc 0102],
[Sch Gross Impr Psc 0102],
[Sch Gross Total Psc 0102],
[Hsptl Gross Land Psc 0102],
[Hsptl Gross Impr Psc 0102],
[Hsptl Gross Total Psc 0102],
[Gen Exmpt Land Psc 0102],
[Gen Exmpt Impr Psc 0102],
[Gen Exmpt Total Psc 0102],
[Sch Exmpt Land Psc 0102],
[Sch Exmpt Impr Psc 0102],
[Sch Exmpt Total Psc 0102],
[Hsptl Exmpt Land Psc 0102],
[Hsptl Exmpt Impr Psc 0102],
[Hsptl Exmpt Total Psc 0102],
[Gen Net Land Psc 0102],
[Gen Net Impr Psc 0102],
[Gen Net Total Psc 0102],
[Sch Net Land Psc 0102],
[Sch Net Impr Psc 0102],
[Sch Net Total Psc 0102],
[Hsptl Net Land Psc 0102],
[Hsptl Net Impr Psc 0102],
[Hsptl Net Total Psc 0102],
[Gen Gross Land Psc 0103],
[Gen Gross Impr Psc 0103],
[Gen Gross Total Psc 0103],
[Sch Gross Land Psc 0103],
[Sch Gross Impr Psc 0103],
[Sch Gross Total Psc 0103],
[Hsptl Gross Land Psc 0103],
[Hsptl Gross Impr Psc 0103],
[Hsptl Gross Total Psc 0103],
[Gen Exmpt Land Psc 0103],
[Gen Exmpt Impr Psc 0103],
[Gen Exmpt Total Psc 0103],
[Sch Exmpt Land Psc 0103],
[Sch Exmpt Impr Psc 0103],
[Sch Exmpt Total Psc 0103],
[Hsptl Exmpt Land Psc 0103],
[Hsptl Exmpt Impr Psc 0103],
[Hsptl Exmpt Total Psc 0103],
[Gen Net Land Psc 0103],
[Gen Net Impr Psc 0103],
[Gen Net Total Psc 0103],
[Sch Net Land Psc 0103],
[Sch Net Impr Psc 0103],
[Sch Net Total Psc 0103],
[Hsptl Net Land Psc 0103],
[Hsptl Net Impr Psc 0103],
[Hsptl Net Total Psc 0103],
[Gen Gross Land Psc 0104],
[Gen Gross Impr Psc 0104],
[Gen Gross Total Psc 0104],
[Sch Gross Land Psc 0104],
[Sch Gross Impr Psc 0104],
[Sch Gross Total Psc 0104],
[Hsptl Gross Land Psc 0104],
[Hsptl Gross Impr Psc 0104],
[Hsptl Gross Total Psc 0104],
[Gen Exmpt Land Psc 0104],
[Gen Exmpt Impr Psc 0104],
[Gen Exmpt Total Psc 0104],
[Sch Exmpt Land Psc 0104],
[Sch Exmpt Impr Psc 0104],
[Sch Exmpt Total Psc 0104],
[Hsptl Exmpt Land Psc 0104],
[Hsptl Exmpt Impr Psc 0104],
[Hsptl Exmpt Total Psc 0104],
[Gen Net Land Psc 0104],
[Gen Net Impr Psc 0104],
[Gen Net Total Psc 0104],
[Sch Net Land Psc 0104],
[Sch Net Impr Psc 0104],
[Sch Net Total Psc 0104],
[Hsptl Net Land Psc 0104],
[Hsptl Net Impr Psc 0104],
[Hsptl Net Total PC 0104],
[Gen Gross Land Psc 0105],
[Gen Gross Impr Psc 0105],
[Gen Gross Total Psc 0105],
[Sch Gross Land Psc 0105],
[Sch Gross Impr Psc 0105],
[Sch Gross Total Psc 0105],
[Hsptl Gross Land Psc 0105],
[Hsptl Gross Impr Psc 0105],
[Hsptl Gross Total Psc 0105],
[Gen Exmpt Land Psc 0105],
[Gen Exmpt Impr Psc 0105],
[Gen Exmpt Total Psc 0105],
[Sch Exmpt Land Psc 0105],
[Sch Exmpt Impr Psc 0105],
[Sch Exmpt Total Psc 0105],
[Hsptl Exmpt Land Psc 0105],
[Hsptl Exmpt Impr Psc 0105],
[Hsptl Exmpt Total Psc 0105],
[Gen Net Land Psc 0105],
[Gen Net Impr Psc 0105],
[Gen Net Total Psc 0105],
[Sch Net Land Psc 0105],
[Sch Net Impr Psc 0105],
[Sch Net Total Psc 0105],
[Hsptl Net Land Psc 0105],
[Hsptl Net Impr Psc 0105],
[Hsptl Net Total Psc 0105],
[Gen Gross Land Psc 0106],
[Gen Gross Impr Psc 0106],
[Gen Gross Total Psc 0106],
[Sch Gross Land Psc 0106],
[Sch Gross Impr Psc 0106],
[Sch Gross Total Psc 0106],
[Hsptl Gross Land Psc 0106],
[Hsptl Gross Impr Psc 0106],
[Hsptl Gross Total Psc 0106],
[Gen Exmpt Land Psc 0106],
[Gen Exmpt Impr Psc 0106],
[Gen Exmpt Total Psc 0106],
[Sch Exmpt Land Psc 0106],
[Sch Exmpt Impr Psc 0106],
[Sch Exmpt Total Psc 0106],
[Hsptl Exmpt Land Psc 0106],
[Hsptl Exmpt Impr Psc 0106],
[Hsptl Exmpt Total Psc 0106],
[Gen Net Land Psc 0106],
[Gen Net Impr Psc 0106],
[Gen Net Total Psc 0106],
[Sch Net Land Psc 0106],
[Sch Net Impr Psc 0106],
[Sch Net Total Psc 0106],
[Hsptl Net Land Psc 0106],
[Hsptl Net Impr Psc 0106],
[Hsptl Net Total Psc 0106],
[Gen Gross Land PC 02],
[Gen Gross Impr PC 02],
[Gen Gross Total PC 02],
[Sch Gross Land PC 02],
[Sch Gross Impr PC 02],
[Sch Gross Total PC 02],
[Hsptl Gross Land PC 02],
[Hsptl Gross Impr PC 02],
[Hsptl Gross Total PC 02],
[Gen Exmpt Land PC 02],
[Gen Exmpt Impr PC 02],
[Gen Exmpt Total PC 02],
[Sch Exmpt Land PC 02],
[Sch Exmpt Impr PC 02],
[Sch Exmpt Total PC 02],
[Hsptl Exmpt Land PC 02],
[Hsptl Exmpt Impr PC 02],
[Hsptl Exmpt Total PC 02],
[Gen Net Land PC 02],
[Gen Net Impr PC 02],
[Gen Net Total PC 02],
[Sch Net Land PC 02],
[Sch Net Impr PC 02],
[Sch Net Total PC 02],
[Hsptl Net Land PC 02],
[Hsptl Net Impr PC 02],
[Hsptl Net Total PC 02],
[Gen Gross Land Psc 0201],
[Gen Gross Impr Psc 0201],
[Gen Gross Total Psc 0201],
[Sch Gross Land Psc 0201],
[Sch Gross Impr Psc 0201],
[Sch Gross Total Psc 0201],
[Hsptl Gross Land Psc 0201],
[Hsptl Gross Impr Psc 0201],
[Hsptl Gross Total Psc 0201],
[Gen Exmpt Land Psc 0201],
[Gen Exmpt Impr Psc 0201],
[Gen Exmpt Total Psc 0201],
[Sch Exmpt Land Psc 0201],
[Sch Exmpt Impr Psc 0201],
[Sch Exmpt Total Psc 0201],
[Hsptl Exmpt Land Psc 0201],
[Hsptl Exmpt Impr Psc 0201],
[Hsptl Exmpt Total Psc 0201],
[Gen Net Land Psc 0201],
[Gen Net Impr Psc 0201],
[Gen Net Total Psc 0201],
[Sch Net Land Psc 0201],
[Sch Net Impr Psc 0201],
[Sch Net Total Psc 0201],
[Hsptl Net Land Psc 0201],
[Hsptl Net Impr Psc 0201],
[Hsptl Net Total Psc 0201],
[Gen Gross Land Psc 0202],
[Gen Gross Impr Psc 0202],
[Gen Gross Total Psc 0202],
[Sch Gross Land Psc 0202],
[Sch Gross Impr Psc 0202],
[Sch Gross Total Psc 0202],
[Hsptl Gross Land Psc 0202],
[Hsptl Gross Impr Psc 0202],
[Hsptl Gross Total Psc 0202],
[Gen Exmpt Land Psc 0202],
[Gen Exmpt Impr Psc 0202],
[Gen Exmpt Total Psc 0202],
[Sch Exmpt Land Psc 0202],
[Sch Exmpt Impr Psc 0202],
[Sch Exmpt Total Psc 0202],
[Hsptl Exmpt Land Psc 0202],
[Hsptl Exmpt Impr Psc 0202],
[Hsptl Exmpt Total Psc 0202],
[Gen Net Land Psc 0202],
[Gen Net Impr Psc 0202],
[Gen Net Total Psc 0202],
[Sch Net Land Psc 0202],
[Sch Net Impr Psc 0202],
[Sch Net Total Psc 0202],
[Hsptl Net Land Psc 0202],
[Hsptl Net Impr Psc 0202],
[Hsptl Net Total Psc 0202],
[Gen Gross Land PC 03],
[Gen Gross Impr PC 03],
[Gen Gross Total PC 03],
[Sch Gross Land PC 03],
[Sch Gross Impr PC 03],
[Sch Gross Total PC 03],
[Hsptl Gross Land PC 03],
[Hsptl Gross Impr PC 03],
[Hsptl Gross Total PC 03],
[Gen Exmpt Land PC 03],
[Gen Exmpt Impr PC 03],
[Gen Exmpt Total PC 03],
[Sch Exmpt Land PC 03],
[Sch Exmpt Impr PC 03],
[Sch Exmpt Total PC 03],
[Hsptl Exmpt Land PC 03],
[Hsptl Exmpt Impr PC 03],
[Hsptl Exmpt Total PC 03],
[Gen Net Land PC 03],
[Gen Net Impr PC 03],
[Gen Net Total PC 03],
[Sch Net Land PC 03],
[Sch Net Impr PC 03],
[Sch Net Total PC 03],
[Hsptl Net Land PC 03],
[Hsptl Net Impr PC 03],
[Hsptl Net Total PC 03],
[Gen Gross Land PC 04],
[Gen Gross Impr PC 04],
[Gen Gross Total PC 04],
[Sch Gross Land PC 04],
[Sch Gross Impr PC 04],
[Sch Gross Total PC 04],
[Hsptl Gross Land PC 04],
[Hsptl Gross Impr PC 04],
[Hsptl Gross Total PC 04],
[Gen Exmpt Land PC 04],
[Gen Exmpt Impr PC 04],
[Gen Exmpt Total PC 04],
[Sch Exmpt Land PC 04],
[Sch Exmpt Impr PC 04],
[Sch Exmpt Total PC 04],
[Hsptl Exmpt Land PC 04],
[Hsptl Exmpt Impr PC 04],
[Hsptl Exmpt Total PC 04],
[Gen Net Land PC 04],
[Gen Net Impr PC 04],
[Gen Net Total PC 04],
[Sch Net Land PC 04],
[Sch Net Impr PC 04],
[Sch Net Total PC 04],
[Hsptl Net Land PC 04],
[Hsptl Net Impr PC 04],
[Hsptl Net Total PC 04],
[Gen Gross Land PC 05],
[Gen Gross Impr PC 05],
[Gen Gross Total PC 05],
[Sch Gross Land PC 05],
[Sch Gross Impr PC 05],
[Sch Gross Total PC 05],
[Hsptl Gross Land PC 05],
[Hsptl Gross Impr PC 05],
[Hsptl Gross Total PC 05],
[Gen Exmpt Land PC 05],
[Gen Exmpt Impr PC 05],
[Gen Exmpt Total PC 05],
[Sch Exmpt Land PC 05],
[Sch Exmpt Impr PC 05],
[Sch Exmpt Total PC 05],
[Hsptl Exmpt Land PC 05],
[Hsptl Exmpt Impr PC 05],
[Hsptl Exmpt Total PC 05],
[Gen Net Land PC 05],
[Gen Net Impr PC 05],
[Gen Net Total PC 05],
[Sch Net Land PC 05],
[Sch Net Impr PC 05],
[Sch Net Total PC 05],
[Hsptl Net Land PC 05],
[Hsptl Net Impr PC 05],
[Hsptl Net Total PC 05],
[Gen Gross Land PC 06],
[Gen Gross Impr PC 06],
[Gen Gross Total PC 06],
[Sch Gross Land PC 06],
[Sch Gross Impr PC 06],
[Sch Gross Total PC 06],
[Hsptl Gross Land PC 06],
[Hsptl Gross Impr PC 06],
[Hsptl Gross Total PC 06],
[Gen Exmpt Land PC 06],
[Gen Exmpt Impr PC 06],
[Gen Exmpt Total PC 06],
[Sch Exmpt Land PC 06],
[Sch Exmpt Impr PC 06],
[Sch Exmpt Total PC 06],
[Hsptl Exmpt Land PC 06],
[Hsptl Exmpt Impr PC 06],
[Hsptl Exmpt Total PC 06],
[Gen Net Land PC 06],
[Gen Net Impr PC 06],
[Gen Net Total PC 06],
[Sch Net Land PC 06],
[Sch Net Impr PC 06],
[Sch Net Total PC 06],
[Hsptl Net Land PC 06],
[Hsptl Net Impr PC 06],
[Hsptl Net Total PC 06],
[Gen Gross Land PC 07],
[Gen Gross Impr PC 07],
[Gen Gross Total PC 07],
[Sch Gross Land PC 07],
[Sch Gross Impr PC 07],
[Sch Gross Total PC 07],
[Hsptl Gross Land PC 07],
[Hsptl Gross Impr PC 07],
[Hsptl Gross Total PC 07],
[Gen Exmpt Land PC 07],
[Gen Exmpt Impr PC 07],
[Gen Exmpt Total PC 07],
[Sch Exmpt Land PC 07],
[Sch Exmpt Impr PC 07],
[Sch Exmpt Total PC 07],
[Hsptl Exmpt Land PC 07],
[Hsptl Exmpt Impr PC 07],
[Hsptl Exmpt Total PC 07],
[Gen Net Land PC 07],
[Gen Net Impr PC 07],
[Gen Net Total PC 07],
[Sch Net Land PC 07],
[Sch Net Impr PC 07],
[Sch Net Total PC 07],
[Hsptl Net Land PC 07],
[Hsptl Net Impr PC 07],
[Hsptl Net Total PC 07],
[Gen Gross Land PC 08],
[Gen Gross Impr PC 08],
[Gen Gross Total PC 08],
[Sch Gross Land PC 08],
[Sch Gross Impr PC 08],
[Sch Gross Total PC 08],
[Hsptl Gross Land PC 08],
[Hsptl Gross Impr PC 08],
[Hsptl Gross Total PC 08],
[Gen Exmpt Land PC 08],
[Gen Exmpt Impr PC 08],
[Gen Exmpt Total PC 08],
[Sch Exmpt Land PC 08],
[Sch Exmpt Impr PC 08],
[Sch Exmpt Total PC 08],
[Hsptl Exmpt Land PC 08],
[Hsptl Exmpt Impr PC 08],
[Hsptl Exmpt Total PC 08],
[Gen Net Land PC 08],
[Gen Net Impr PC 08],
[Gen Net Total PC 08],
[Sch Net Land PC 08],
[Sch Net Impr PC 08],
[Sch Net Total PC 08],
[Hsptl Net Land PC 08],
[Hsptl Net Impr PC 08],
[Hsptl Net Total PC 08],
[Gen Gross Land PC 09],
[Gen Gross Impr PC 09],
[Gen Gross Total PC 09],
[Sch Gross Land PC 09],
[Sch Gross Impr PC 09],
[Sch Gross Total PC 09],
[Hsptl Gross Land PC 09],
[Hsptl Gross Impr PC 09],
[Hsptl Gross Total PC 09],
[Gen Exmpt Land PC 09],
[Gen Exmpt Impr PC 09],
[Gen Exmpt Total PC 09],
[Sch Exmpt Land PC 09],
[Sch Exmpt Impr PC 09],
[Sch Exmpt Total PC 09],
[Hsptl Exmpt Land PC 09],
[Hsptl Exmpt Impr PC 09],
[Hsptl Exmpt Total PC 09],
[Gen Net Land PC 09],
[Gen Net Impr PC 09],
[Gen Net Total PC 09],
[Sch Net Land PC 09],
[Sch Net Impr PC 09],
[Sch Net Total PC 09],
[Hsptl Net Land PC 09],
[Hsptl Net Impr PC 09],
[Hsptl Net Total PC 09],
[Gen Gross Land PC 10],
[Gen Gross Impr PC 10],
[Gen Gross Total PC 10],
[Sch Gross Land PC 10],
[Sch Gross Impr PC 10],
[Sch Gross Total PC 10],
[Hsptl Gross Land PC 10],
[Hsptl Gross Impr PC 10],
[Hsptl Gross Total PC 10],
[Gen Exmpt Land PC 10],
[Gen Exmpt Impr PC 10],
[Gen Exmpt Total PC 10],
[Sch Exmpt Land PC 10],
[Sch Exmpt Impr PC 10],
[Sch Exmpt Total PC 10],
[Hsptl Exmpt Land PC 10],
[Hsptl Exmpt Impr PC 10],
[Hsptl Exmpt Total PC 10],
[Gen Net Land PC 10],
[Gen Net Impr PC 10],
[Gen Net Total PC 10],
[Sch Net Land PC 10],
[Sch Net Impr PC 10],
[Sch Net Total PC 10],
[Hsptl Net Land PC 10],
[Hsptl Net Impr PC 10],
[Hsptl Net Total PC 10]
)
) AS [PiotPC];
