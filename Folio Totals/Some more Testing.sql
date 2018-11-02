/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  TOP (1000) [Roll Year],  [Folio Number]
  FROM [EDW].[edw].[dimProperty] 
  GROUP BY [Roll Year],[Folio Number]
  HAVING Count(*) > 1

  SELECT DISTINCT [Folio Number], [Property ID]
  FROM [EDW].[edw].[dimFolio] 
  WHERE [Folio Number] IN (SELECT  TOP (10000)  [Folio Number]
  FROM [EDW].[edw].[dimFolio] 
  GROUP BY [Folio Number]
  HAVING Count(*) > 1)
  ORDER BY [Folio Number]

SELECT  TOP (1000)  [Folio Number], Count(*)
  FROM [EDW].[edw].[dimFolio] 
  GROUP BY [Folio Number]
  HAVING Count(*) > 1

  SELECT [Folio Number], [Property ID]
  FROM [EDW].[edw].[dimProperty] 
  WHERE [Folio Number] = '0121300003001'

  SELECT [Roll Year], [Folio Number], [Property ID]
  FROM [EDW].[edw].[dimFolio] 
  WHERE [Property ID] =  '001131371'