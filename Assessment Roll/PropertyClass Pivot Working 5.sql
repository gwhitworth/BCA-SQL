SELECT *
FROM
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           (CASE [Assessment Code]
                WHEN '01'
                THEN 'Land PC '+[PC].[Property Class Code]
                ELSE 'Impr PC '+[PC].[Property Class Code]
            END) AS [CODE], 
           [PC].[Property Class Code]+' - '+[PC].[Property Class Desc] AS [DESC]
    FROM [edw].[FactAssessedValue] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
    UNION
    SELECT DISTINCT 
           [dimFolio_SK], 
           (CASE [Assessment Code]
                WHEN '01'
                THEN 'Land Psc '+[PC].[Property Sub Class Code]
                ELSE 'Impr Psc '+[PC].[Property Sub Class Code]
            END) AS [CODE], 
           [PC].[Property Sub Class Code]+' - '+[PC].[Property Sub Class Desc] AS [DESC]
    FROM [edw].[FactAssessedValue] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
) [DataTable] PIVOT(MAX([DESC]) FOR [CODE] IN([Land PC 01], 
                                              [Land Psc 0102], 
                                              [Land Psc 0103], 
                                              [Land Psc 0104], 
                                              [Land Psc 0105], 
                                              [Land Psc 0106], 
                                              [Land PC 02], 
                                              [Land PC 03], 
                                              [Land PC 04], 
                                              [Land PC 05], 
                                              [Land PC 06], 
                                              [Land PC 07], 
                                              [Land PC 08], 
                                              [Land PC 09], 
                                              [Impr PC 01], 
                                              [Impr Psc 0102], 
                                              [Impr Psc 0103], 
                                              [Impr Psc 0104], 
                                              [Impr Psc 0105], 
                                              [Impr Psc 0106], 
                                              [Impr PC 02], 
                                              [Impr PC 03], 
                                              [Impr PC 04], 
                                              [Impr PC 05], 
                                              [Impr PC 06], 
                                              [Impr PC 07], 
                                              [Impr PC 08], 
                                              [Impr PC 09])) AS [PiotPC];