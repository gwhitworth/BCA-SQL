/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT	*
--  FROM [EDW].[edw].[dimProperty]
--  --WHERE [Folio Number] = '0121303503030'
--  WHERE [Postal Code] = 'V9B 6C8' OR [SITUS Postal Code] = 'V9B 6C8'


SELECT	*
  FROM [EDW].[edw].[dimProperty]

  --WHERE --[Street Name] like '%ISLAND HWY%' 
  --WHERE [Postal Code] = 'V8W 3G3'
  WHERE [Roll Number] = '03523000' AND [Jurisdiction Code] = '213'
  --OR 
  --[SITUS Full Address] like '%1740 ISLAND HWY%' 
  --AND [Roll Year] = 2018