  SELECT DISTINCT
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[ADD].[dimCity_BK],[ADD].[dimCountry_BK],NULL,[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value],'','',50,1)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[ADD].[dimCity_BK],[ADD].[dimCountry_BK],NULL,[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value],'','',50,2)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[ADD].[dimCity_BK],[ADD].[dimCountry_BK],NULL,[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value],'','',50,3)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[ADD].[dimCity_BK],[ADD].[dimCountry_BK],NULL,[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value],'','',50,4)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[ADD].[dimCity_BK],[ADD].[dimCountry_BK],NULL,[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value],'','',50,5)
	)
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [BFA]
  INNER JOIN[edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BFA].[dimAddress_SK]
  WHERE [BFA].[dimProperty_SK] = 1137874
