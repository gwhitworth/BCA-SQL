/****** Script for SelectTopNRows command from SSMS  ******/

SELECT TOP 1000 [FO].[dimFolio_SK], 
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
GROUP BY [FO].[dimFolio_SK]

--SELECT TOP 1000 [FO].[dimFolio_SK],[FO].[SITUS Building/Unit Number],[FO].[SITUS Address Street Name], [FO].[SITUS City], 
--                COUNT(*) AS [CNT]
--FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
--     INNER JOIN [edw].[dimName] AS [ONA]
--     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
--     INNER JOIN [edw].[dimAddress] AS [OAD]
--     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
--     INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
--        AND [FO].[Folio Status Code] = '01'
--WHERE [OFA].[Roll Year] = 2017
--GROUP BY [FO].[dimFolio_SK], [FO].[SITUS Building/Unit Number],[FO].[SITUS Address Street Name], [FO].[SITUS City]
--HAVING COUNT(*) > 2

--SELECT [ONA].[First Name], 
--       [ONA].[Last Name],[OFA].[Owner Group ID],[OFA].[Owner Number],[OFA].[Owner Sequence]
--FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
--     INNER JOIN [edw].[dimName] AS [ONA]
--     ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
--     INNER JOIN [edw].[dimAddress] AS [OAD]
--     ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
--     INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
--        AND [FO].[Folio Status Code] = '01'
--WHERE [OFA].[Roll Year] = 2017
--AND [FO].[dimFolio_SK]  = 4736349
      --AND [FO].[Folio Number] = '0121303538000'
	  ;

--SELECT TOP (1000) [bridgeOwnerFolioAddress_SK]
--      ,[dimRollYear_SK]
--      ,[dimProperty_SK]
--      ,[dimFolio_SK]
--      ,[dimAddress_SK]
--      ,[dimName_SK]
--      ,[dimFolio_BK]
--      ,[dimAddress_BK]
--      ,[dimName_BK]
--      ,[Roll Year]
--      ,[Owner Number]
--      ,[Owner Sequence]
--      ,[IAS_JUR]
--      ,[System Property ID]
--      ,[Primary Owner Flag]
--      ,[Version number of this record]
--      ,[Current Record Indicator]
--      ,[Care Of]
--      ,[Percent Of Ownership For Primary Owner]
--      ,[Party Type]
--      ,[Property Name Status]
--      ,[Suppress Assessment Notice]
--      ,[Assessment Notice Returned]
--      ,[Agent Expiration]
--      ,[Agent Type]
--      ,[Equity Type]
--      ,[Owner Group ID]
--      ,[Sequence]
--      ,[Danger Code]
--      ,[Suppress Tax Notice]
--      ,[Bulk Code]
--      ,[Tenant Mailout Recipient]
--      ,[Deactivate date]
--      ,[Iasworld Unique Row Identifier]
--      ,[PIN Number]
--      ,[Related PIN Number]
--      ,[NA000_OID]
--      ,[LA000_OID]
--      ,[RA000_OID]
--  FROM [EDW].[edw].[bridgeOwnerFolioAddress]