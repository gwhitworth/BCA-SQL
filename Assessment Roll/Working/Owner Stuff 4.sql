
/****** Script for SelectTopNRows command from SSMS  ******/

SELECT DISTINCT TOP (1000) *
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [OAD].[Street Number] = '11762'
      AND [OAD].[Address Street Name] = '194A'
      AND [OAD].[City Desc] = 'PITT MEADOWS'
      AND [OFA].[dimRollYear_SK] = 2017;