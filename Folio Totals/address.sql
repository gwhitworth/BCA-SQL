/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [EDW].[edw].[dimAddress]
  where [dimAddress_SK] = 2479785

  SELECT distinct *
  FROM [EDW].[edw].[bridgeOwnerFolioAddress]
  where [dimAddress_SK] = 2479785
  and dimFolio_SK = 391068
SELECT  *
  FROM [EDW].[edw].[bridgeNameAddress]
  where [dimAddress_SK] = 2479785