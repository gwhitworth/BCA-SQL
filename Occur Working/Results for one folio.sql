/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [EDW].[edw].[FactPropertyClassOccurrenceCount]
  where [dimFolio_SK] = 563
SELECT *
  FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass]
  where [dimFolio_SK] = 563