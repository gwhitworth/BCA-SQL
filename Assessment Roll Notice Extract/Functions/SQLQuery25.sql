/****** Script for SelectTopNRows command from SSMS  ******/
--	@p_City					varchar(50),
--	@p_Country				varchar(50),
--	@p_Freeform_Address		varchar(500),
--	@p_Directional			varchar(50) = '',
--	@p_Postal_zip			varchar(10),
--	@p_Province_State		varchar(50),
--	@p_Street_Name			varchar(50) = '',
--	@p_Street_Number		varchar(50) = '',
--	@p_Street_Type			varchar(50) = '',
--	@p_Unit_Number			varchar(50),
--	@p_Address_Floor		varchar(50),
--	@p_Address_CO			varchar(50),
--	@p_Address_Attention	varchar(50),
--	@p_Address_Site			varchar(50),
--	@p_Address_Comp			varchar(50),

--	@p_Address_Mod			varchar(50),
--	@p_Address_Mod_Value	varchar(50),
--	@p_Address_Dim			varchar(50),
--	@p_Address_Dim_Value	varchar(50)

--SELECT DISTINCT
--[Full Address]
--      ,[Country]
--      ,[Province Desc]
--      ,[City Desc]
--      ,[Street Suffix]
--      ,[Street Suffix 2]
--      ,[Street Direction Desc]
--      ,[Address Type Code]
--      ,[Address Number Suffix]
--      ,[Grid Address Number]
--      ,[Street Number]
--      ,[Address Street Name]
--      ,[Carrier Route]
--      ,[Postal Index Number]
--      ,[Postal/Zip Code]
--      ,[Address Unit Description]
--      ,[Address Unit]
--      ,[Zip Code First 5 Digits]
--      ,[Zip Code Suffix Last 4 Digits]
--      ,[Attention]
--      ,[Floor Number]
--      ,[Delivery Mode Desc]
--      ,[Delivery Mode Value]
--      ,[Site]
--      ,[Compartment]
--      ,[Delivery Installation Type Code]
--      ,[Delivery Installation Type Value]
--      ,[Street Prefix]
--  FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [BFA]
--  INNER JOIN[edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BFA].[dimAddress_SK]
--  WHERE [BFA].[dimProperty_SK] = 1137874

  SELECT --TOP 100
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[ADD].[dimCity_BK],[ADD].[dimCountry_BK],NULL,[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value],'','',50,1)
	)
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

SELECT DISTINCT [ADD].[dimCity_BK],[ADD].[dimCountry_BK],NULL,[ADD].dimStreetDirection_BK,[ADD].[Postal/Zip Code],[ADD].dimProvince_BK,
										[ADD].[Address Street Name],[ADD].[Street Number],[ADD].dimStreetType_BK,[ADD].[Address Unit],[ADD].[Floor Number],
										[BFA].[Care Of],[ADD].Attention,[ADD].[Site], [ADD].Compartment,[ADD].[Delivery Mode Desc],
										[ADD].[Delivery Mode Value]
FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [BFA]
  INNER JOIN[edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BFA].[dimAddress_SK]
  WHERE [BFA].[dimProperty_SK] = 1137874