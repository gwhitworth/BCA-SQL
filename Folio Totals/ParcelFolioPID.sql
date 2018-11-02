/****** Script for SelectTopNRows command from SSMS  ******/
  SELECT TOP 500
	  a.dimParcel_SK	
	  ,b.[Folio Number]
      ,a.PID
  FROM [EDW].[edw].[dimParcel] AS [A]
  INNER JOIN [dbo].[bridgeParcelFolioTbl] AS [B] ON A.dimParcel_SK = b.dimParcel_SK
  WHERE b.[Roll Year] = '2017' AND b.[Folio Number] IN (SELECT TOP (1000) 
	  b.[Folio Number]
  FROM [EDW].[edw].[dimParcel] AS [A]
  INNER JOIN [dbo].[bridgeParcelFolioTbl] AS [B] ON A.dimParcel_SK = b.dimParcel_SK
  WHERE b.[Roll Year] = '2017' AND PID IS NOT NULL
  GROUP BY b.[Folio Number]
  HAVING Count(*) > 1)
  ORDER BY b.[Folio Number] ,a.PID