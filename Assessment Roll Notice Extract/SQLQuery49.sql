/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [EDW].[edw].[dimProperty]
WHERE [Roll Number] = '03523000' AND [Jurisdiction Code] = '213' AND [Roll Year] = 2019