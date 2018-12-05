
/****** Script for SelectTopNRows command from SSMS  ******/

--SELECT top 1000 [OAD].[Address Unit],[OAD].[Street Number],[OAD].[Address Street Name],[OAD].[City Desc], COUNT(*) as CNT
--FROM		[EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
--INNER JOIN [edw].[dimName] AS [ONA]
--     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
--	 INNER JOIN [edw].[dimAddress] AS [OAD]
--     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
--INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
--        AND [FO].[Folio Status Code] = '01'
--where [OFA].[Roll Year] = 2017
--GROUP BY [OAD].[Address Unit],[OAD].[Street Number],[OAD].[Address Street Name],[OAD].[City Desc]
--SELECT top 1000 [SITUS Address Street Name],[SITUS Full Address],COUNT(*) as CNT
--FROM		[EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
--INNER JOIN [edw].[dimName] AS [ONA]
--     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
--	 INNER JOIN [edw].[dimAddress] AS [OAD]
--     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
--INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
--        AND [FO].[Folio Status Code] = '01'
--where [OFA].[Roll Year] = 2017
--GROUP BY [SITUS Address Street Name], [SITUS Full Address]
--HAVING		 COUNT(*) > 2

SELECT TOP 1000 [FO].[Folio Number], 
                [SITUS Full Address], 
                COUNT(*) AS [CNT]
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [OFA].[Roll Year] = 2017
GROUP BY [FO].[Folio Number], 
         [SITUS Full Address];
--HAVING		 COUNT(*) < 2

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

--SELECT top 1000 [FO].[Folio Number],[SITUS Address Street Name],[SITUS City],[SITUS Postal Code],COUNT(*) as CNT
--FROM		[EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
--INNER JOIN [edw].[dimName] AS [ONA]
--     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
--	 INNER JOIN [edw].[dimAddress] AS [OAD]
--     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
--INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
--        AND [FO].[Folio Status Code] = '01'
--where [OFA].[Roll Year] = 2017
--GROUP BY [FO].[Folio Number],[SITUS Address Street Name],[SITUS City],[SITUS Postal Code]
--SELECT top 1000 [FO].[Folio Number],[OAD].[Address Unit],[OAD].[Street Number],[OAD].[Address Street Name],[OAD].[City Desc], COUNT(*) as CNT
--FROM		[EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
--INNER JOIN [edw].[dimName] AS [ONA]
--     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
--	 INNER JOIN [edw].[dimAddress] AS [OAD]
--     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
--INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
--        AND [FO].[Folio Status Code] = '01'
--where [OFA].[Roll Year] = 2017
--GROUP BY [FO].[Folio Number],[OAD].[Address Unit],[OAD].[Street Number],[OAD].[Address Street Name],[OAD].[City Desc]
----HAVING		 COUNT(*) > 2;
----order by CNT desc;