/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      [General Exemptions Land Value]
      ,[General Exemptions Building Value]
      ,[General Exemptions Total Value]
      ,[Other Exemptions Land Value]
      ,[Other Exemptions Building Value]
      ,[Other Exemptions Total Value]
      ,[School Exemptions Land Value]
      ,[School Exemptions Building Value]
      ,[School Exemptions Total Value]
      
  FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass]
  where dimProperty_SK = 392543