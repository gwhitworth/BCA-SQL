/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [dimAssessmentOffice_SK]
      ,[dimAssessmentOffice_BK]
      ,[dimArea_BK]
      ,[dimArea_SK]
      ,[Address Line Number]
      ,[Assessment Office Address Line]
  FROM [EDW].[edw].[dimAssessmentOffice]
  ORDER BY [dimArea_SK]