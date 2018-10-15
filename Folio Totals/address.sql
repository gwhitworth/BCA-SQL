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

SELECT *
  FROM [EDW].[edw].[dimAddress]
  --where dimAddress_SK in (2132057,36023,36977)
  where dimAddress_SK in (2132057)
  SELECT distinct *
  FROM [EDW].[edw].[bridgeOwnerFolioAddress]
  where [dimAddress_SK] = 2132057
  --and dimFolio_SK = 391068

SELECT *
  FROM [EDW].[edw].[dimAddress]
  where Attention like '%R/M%'
  and [Address Line 1] like '%DIV STR%'
  

--SELECT distinct B.*
--  FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [A]
--  INNER JOIN [edw].[dimAddress] AS [B] ON [B].dimAddress_SK = A.dimAddress_SK
--   where b.dimAddress_SK = 36023
