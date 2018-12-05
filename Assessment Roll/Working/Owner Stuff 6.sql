SELECT [OAD].[Address Unit], 
       [OAD].[Street Number], 
       [OAD].[Address Street Name], 
       [OAD].[City Desc]
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [OFA].[Roll Year] = 2017
      AND [FO].[Folio Number] = '2532901330190';

SELECT [ONA].[First Name], 
       [ONA].[Last Name]
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [OFA].[Roll Year] = 2017
      AND [FO].[Folio Number] = '2532901330190';