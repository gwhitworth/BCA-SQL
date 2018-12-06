WITH FMT([dimFolio_SK], 
         [CAT], 
         [CODE])
     AS (SELECT [dimFolio_SK], 
                [BTC].[Minor Tax Category] AS [CAT], 
                [TC].[BCA Code] AS [CODE]
         FROM [edw].[bridgeFolioMinorTax] AS [BTC]
              INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
              ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
         WHERE [dimFolio_SK] = 4621915)
     SELECT [dimFolio_SK], 
            [LA - LOCAL AREA], 
            [SM - SPECIFIED MUNICIPAL], 
            [SR - SPECIFIED REGIONAL ], 
            [SA - SERVICE AREA], 
            [DE - DEFINED], 
            [ID - IMPROVEMENT DISTRICT], 
            [GS - GENERAL SERVICE], 
            [IT - ISLANDS TRUST]
     FROM
     (
         SELECT [dimFolio_SK], 
                [CAT], 
         (
             SELECT DISTINCT 
                    [smcList] = STUFF(
             (
                 SELECT ','+[TC].[BCA Code]
                 FROM [EDW].[edw].[bridgeFolioMinorTax] AS [id2]
                      INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
                      ON [id2].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
                 WHERE [id1].[dimFolio_SK] = [id2].[dimFolio_SK]
                       AND [id1].[Minor Tax Category Code] = [id2].[Minor Tax Category Code]
                 GROUP BY [TC].[BCA Code] FOR XML PATH(''), TYPE
             ).value('.', 'varchar(max)'), 1, 1, '')
             FROM [EDW].[edw].[bridgeFolioMinorTax] AS [id1]
                  INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
                  ON [id1].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
             WHERE [dimFolio_SK] = [FMT].[dimFolio_SK]
                   AND [id1].[Minor Tax Category] = [FMT].[CAT]
         ) AS [CODE]
         FROM [FMT]
     ) [C] PIVOT(MAX([CODE]) FOR [CAT] IN([LA - LOCAL AREA], 
                                          [SM - SPECIFIED MUNICIPAL], 
                                          [SR - SPECIFIED REGIONAL ], 
                                          [SA - SERVICE AREA], 
                                          [DE - DEFINED], 
                                          [ID - IMPROVEMENT DISTRICT], 
                                          [GS - GENERAL SERVICE], 
                                          [IT - ISLANDS TRUST])) AS [PivotTable];