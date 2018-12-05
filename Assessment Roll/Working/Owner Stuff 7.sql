SELECT DISTINCT TOP (1000) *
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
WHERE [Percent Of Ownership For Primary Owner] < 50
      AND [dimRollYear_SK] = 2017
ORDER BY [dimFolio_BK];

SELECT DISTINCT TOP (1000) *
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
WHERE [dimRollYear_SK] = 2017
ORDER BY [dimFolio_BK];