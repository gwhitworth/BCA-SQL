
/****** Script for SelectTopNRows command from SSMS  ******/

SELECT DISTINCT TOP 100 [dimFolio_SK], 
                        [smcList] = STUFF(
(
    SELECT ','+[TC].[BCA Code]
    FROM [EDW].[edw].[bridgeFolioMinorTax] AS [id2]
         INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
         ON [id2].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
    WHERE [id1].[dimFolio_SK] = [id2].[dimFolio_SK]
          AND [id2].[Minor Tax Category Code] = [id1].[Minor Tax Category Code]
    GROUP BY [TC].[BCA Code] FOR XML PATH(''), TYPE
).value('.', 'varchar(max)'), 1, 1, '')
FROM [EDW].[edw].[bridgeFolioMinorTax] AS [id1]
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
     ON [id1].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
WHERE [id1].[Minor Tax Category Code] = 'SM'
      AND [dimFolio_SK] = 4621915;