/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) *
  FROM [edw].[bridgeJurisdictionRegionalHospitalDistrict]
  where [Jurisdiction Code] = '764' and dimRollYear_SK = 2017

