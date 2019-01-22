TRUNCATE TABLE [EDW].[dbo].[NAME_ADDRESS_LINES];
GO
INSERT INTO [EDW].[dbo].[NAME_ADDRESS_LINES]
([dimFolio_SK], 
 [dimRollYear], 
 [dimFolio_BK], 
 [ADRS_LINE1], 
 [ADRS_LINE2], 
 [ADRS_LINE3], 
 [ADRS_LINE4], 
 [ADRS_LINE5]
)
       SELECT [B].[dimFolio_SK], 
              [B].[dimRollYear_SK], 
              [B].[dimFolio_BK], 
       (
           SELECT [dbo].[FNC_FORMAT_ADDRESS]([TMP].[dimCity_BK], [TMP].[dimCountry_BK], NULL, [TMP].[dimStreetDirection_BK], [TMP].[Postal/Zip Code], [TMP].[dimProvince_BK], [TMP].[Address Street Name], [TMP].[Street Number], [TMP].[dimStreetType_BK], [TMP].[Address Unit], [TMP].[Floor No.], 'N/A', [TMP].[Attention], [TMP].[Site], [TMP].[Compartment], [TMP].[Delivery Mode], [TMP].[Delivery Mode Value], '', '', 50, 1)
       ), 
       (
           SELECT [dbo].[FNC_FORMAT_ADDRESS]([TMP].[dimCity_BK], [TMP].[dimCountry_BK], NULL, [TMP].[dimStreetDirection_BK], [TMP].[Postal/Zip Code], [TMP].[dimProvince_BK], [TMP].[Address Street Name], [TMP].[Street Number], [TMP].[dimStreetType_BK], [TMP].[Address Unit], [TMP].[Floor No.], 'N/A', [TMP].[Attention], [TMP].[Site], [TMP].[Compartment], [TMP].[Delivery Mode], [TMP].[Delivery Mode Value], '', '', 50, 2)
       ), 
       (
           SELECT [dbo].[FNC_FORMAT_ADDRESS]([TMP].[dimCity_BK], [TMP].[dimCountry_BK], NULL, [TMP].[dimStreetDirection_BK], [TMP].[Postal/Zip Code], [TMP].[dimProvince_BK], [TMP].[Address Street Name], [TMP].[Street Number], [TMP].[dimStreetType_BK], [TMP].[Address Unit], [TMP].[Floor No.], 'N/A', [TMP].[Attention], [TMP].[Site], [TMP].[Compartment], [TMP].[Delivery Mode], [TMP].[Delivery Mode Value], '', '', 50, 3)
       ), 
       (
           SELECT [dbo].[FNC_FORMAT_ADDRESS]([TMP].[dimCity_BK], [TMP].[dimCountry_BK], NULL, [TMP].[dimStreetDirection_BK], [TMP].[Postal/Zip Code], [TMP].[dimProvince_BK], [TMP].[Address Street Name], [TMP].[Street Number], [TMP].[dimStreetType_BK], [TMP].[Address Unit], [TMP].[Floor No.], 'N/A', [TMP].[Attention], [TMP].[Site], [TMP].[Compartment], [TMP].[Delivery Mode], [TMP].[Delivery Mode Value], '', '', 50, 4)
       ), 
       (
           SELECT [dbo].[FNC_FORMAT_ADDRESS]([TMP].[dimCity_BK], [TMP].[dimCountry_BK], NULL, [TMP].[dimStreetDirection_BK], [TMP].[Postal/Zip Code], [TMP].[dimProvince_BK], [TMP].[Address Street Name], [TMP].[Street Number], [TMP].[dimStreetType_BK], [TMP].[Address Unit], [TMP].[Floor No.], 'N/A', [TMP].[Attention], [TMP].[Site], [TMP].[Compartment], [TMP].[Delivery Mode], [TMP].[Delivery Mode Value], '', '', 50, 5)
       )
       FROM [dbo].[dimAddressTbl] AS [TMP]
            INNER JOIN [dbo].[bridgeOwnerFolioAddressTbl] AS [B]
            ON [TMP].[dimAddress_SK] = [B].[dimAddress_SK];

GO
SELECT TOP (1000) *  FROM [EDW].[dbo].[NAME_ADDRESS_LINES]