/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [EDW].[edw].[dimProperty]
  WHERE [dimProperty_SK] = 1137874

SELECT TOP (1000) [dimProperty_SK]
      ,[SITUS_dimCountry_BK]
      ,[SITUS_dimProvince_BK]
      ,[SITUS_dimCity_BK]
      ,[SITUS_dimStreetDirection_BK]
      ,[SITUS Full Address]
      ,[SITUS Address Number Prefix]
      ,[SITUS Street Number]
      ,[SITUS Street Direction]
      ,[SITUS Address Street Name]
      ,[SITUS Street Suffix]
      ,[SITUS Street Type]
      ,[SITUS City]
      ,[SITUS Province]
      ,[SITUS Unit Description]
      ,[SITUS Building/Unit Number]
      ,[SITUS Address Location Line 2]
      ,[SITUS Postal Code]
  FROM [EDW].[edw].[dimProperty]
  WHERE [dimProperty_SK] = 1137874