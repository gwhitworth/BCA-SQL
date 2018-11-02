/****** Script for SelectTopNRows command from SSMS  ******/

SELECT  TOP (1000) [Folio Number]
  FROM [EDW].[dbo].[bridgeParcelFolioTbl]
  where [Roll Year] = '2017'
  GROUP BY [Folio Number]
  HAVING Count(*) > 1

SELECT distinct [Folio Number]
      ,[Property Id]
  FROM [EDW].[dbo].[bridgeParcelFolioTbl]
  where [Roll Year] = '2017' AND [Folio Number] IN (SELECT  TOP (1000) [Folio Number]
  FROM [EDW].[dbo].[bridgeParcelFolioTbl]
  where [Roll Year] = '2017'
  GROUP BY [Folio Number]
  HAVING Count(*) > 1)
  ORDER BY  [Folio Number]

SELECT  TOP (1000) [Folio Number]
  FROM [EDW].[dbo].[bridgeParcelFolioTbl]
  where [Roll Year] = '2017'
  GROUP BY [Folio Number]
  HAVING Count(*) > 1