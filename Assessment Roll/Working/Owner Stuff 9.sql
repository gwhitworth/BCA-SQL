
/****** Script for SelectTopNRows command from SSMS  ******/

--SELECT TOP (1000) [dimFolio_SK],[BTC].[Minor Tax Category Code],
--                  CASE
--                      WHEN [BTC].[Minor Tax Category Code] = 'SM'
--                      THEN [TC].[BCA Code]
--                  END AS [Specified Municipal Code],
--                  CASE
--                      WHEN [BTC].[Minor Tax Category Code] = 'SA'
--                      THEN [TC].[BCA Code]
--                  END AS [Service Area Code]
--FROM [edw].[bridgeFolioMinorTax] AS [BTC]
--     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
--     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
--WHERE [dimFolio_SK] = 4621915 AND [TC].[BCA Code] is not null;

SELECT [dimFolio_SK],[BTC].[Minor Tax Category Code], [TC].[BCA Code]
FROM [edw].[bridgeFolioMinorTax] AS [BTC]
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
WHERE [dimFolio_SK] = 4621915;


WITH CUST_CTE([ID] , [CAT],[CODE],RID)
AS
(
SELECT [dimFolio_SK],[BTC].[Minor Tax Category Code] AS [CAT], [TC].[BCA Code] AS [CODE] , ROW_NUMBER() OVER (PARTITION BY ([BTC].[Minor Tax Category Code])ORDER BY [dimFolio_SK]) AS RID FROM [edw].[bridgeFolioMinorTax] AS [BTC]
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
)

SELECT 'SA','SM'

FROM

(SELECT [ID], [CAT], [CODE],RID

FROM CUST_CTE)C

PIVOT

(

max([ID])

FOR [CAT] IN (SA,SM)

) AS PivotTable;





--select [BTC].[dimFolio_SK],[BTC].[Minor Tax Category Code],[TC].[BCA Code]

--from [edw].[bridgeFolioMinorTax] AS [BTC]                                -- Colums to pivot
--INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
--     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
--pivot 
--(
--   MIN([BTC].[m\])                                                   -- Pivot on this column
--   FOR [CAT] in ([SA])
--   )
--   as BlaBla                                                     -- Pivot table alias


--WHERE [dimFolio_SK] = 4621915

select top 100 [BTC].[dimFolio_SK],max([BTC].[Minor Tax Category Code]),max([TC].[BCA Code])

from [edw].[bridgeFolioMinorTax] AS [BTC]
INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
	 pivot( max([BTC].[dimFolio_SK]) )
group by [BTC].[dimFolio_SK]