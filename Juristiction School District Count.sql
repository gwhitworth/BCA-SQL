
/****** Script for SelectTopNRows command from SSMS  ******/

SELECT [Jurisdiction Code], 
       COUNT(DISTINCT [School  District Code]) AS [SD Count]
FROM [EDW].[edw].[dimFolio]
GROUP BY [Jurisdiction Code];