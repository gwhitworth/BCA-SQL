DECLARE @ResultVar VARCHAR(max)
DECLARE @AddrLine1 VARCHAR(max)
DECLARE @AddrLine2 VARCHAR(max)
DECLARE @AddrLine3 VARCHAR(max)
DECLARE @AddrLine4 VARCHAR(max)
DECLARE @AddrLine5 VARCHAR(max)
WITH cte AS
(
 SELECT DISTINCT [ADD].[dimCity_BK],[ADD].[dimCountry_BK],[ADD].[Full Address],[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value]
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [BFA]
  INNER JOIN[edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BFA].[dimAddress_SK]
  WHERE [BFA].[dimProperty_SK] = 1137874
)

SELECT @AddrLine1 = [dbo].[FNC_FORMAT_ADDRESS]([dimCity_BK], [dimCountry_BK], NULL, dimStreetDirection_BK, [Postal/Zip Code], dimProvince_BK, [Address Street Name], [Street Number], dimStreetType_BK, [Address Unit], [Floor Number], [Care Of], Attention, [Site], Compartment, [Delivery Mode Desc], [Delivery Mode Value], '', '', 50, 1), 
       @AddrLine2 = [dbo].[FNC_FORMAT_ADDRESS]([dimCity_BK], [dimCountry_BK], NULL, dimStreetDirection_BK, [Postal/Zip Code], dimProvince_BK, [Address Street Name], [Street Number], dimStreetType_BK, [Address Unit], [Floor Number], [Care Of], Attention, [Site], Compartment, [Delivery Mode Desc], [Delivery Mode Value], '', '', 50, 2),
	   @AddrLine3 = [dbo].[FNC_FORMAT_ADDRESS]([dimCity_BK], [dimCountry_BK], NULL, dimStreetDirection_BK, [Postal/Zip Code], dimProvince_BK, [Address Street Name], [Street Number], dimStreetType_BK, [Address Unit], [Floor Number], [Care Of], Attention, [Site], Compartment, [Delivery Mode Desc], [Delivery Mode Value], '', '', 50, 3),
	   @AddrLine4 = [dbo].[FNC_FORMAT_ADDRESS]([dimCity_BK], [dimCountry_BK], NULL, dimStreetDirection_BK, [Postal/Zip Code], dimProvince_BK, [Address Street Name], [Street Number], dimStreetType_BK, [Address Unit], [Floor Number], [Care Of], Attention, [Site], Compartment, [Delivery Mode Desc], [Delivery Mode Value], '', '', 50, 4),
	   @AddrLine5 = [dbo].[FNC_FORMAT_ADDRESS]([dimCity_BK], [dimCountry_BK], NULL, dimStreetDirection_BK, [Postal/Zip Code], dimProvince_BK, [Address Street Name], [Street Number], dimStreetType_BK, [Address Unit], [Floor Number], [Care Of], Attention, [Site], Compartment, [Delivery Mode Desc], [Delivery Mode Value], '', '', 50, 5)
FROM cte;
SET @ResultVar = ISNULL(@AddrLine1, + SPACE(50-LEN(@AddrLine1)) + @AddrLine2 + SPACE(50-LEN(@AddrLine2)) + @AddrLine3 + SPACE(50-LEN(@AddrLine2)) + @AddrLine4 + SPACE(50-LEN(@AddrLine2)) + @AddrLine5 + SPACE(50-LEN(@AddrLine2))