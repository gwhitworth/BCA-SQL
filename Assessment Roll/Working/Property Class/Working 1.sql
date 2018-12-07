SELECT TOP 1000 [dimFolio_SK], 
                COUNT(*) AS [CNT]
FROM [EDW].[edw].[FactActualValue]
WHERE [Roll Year] = 2017 AND [dimFolio_SK] > 0
GROUP BY [dimFolio_SK]
HAVING COUNT(*) > 2
ORDER BY [CNT] DESC

SELECT *
  FROM [EDW].[edw].[FactActualValue]
  where [dimFolio_SK] = 4166936