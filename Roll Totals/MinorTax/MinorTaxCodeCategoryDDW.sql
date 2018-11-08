/****** Script for SelectTopNRows command from SSMS  ******/
SELECT[dimMinorTaxCategory_SK]
      ,[dimMinorTaxCategory_BK]
      ,[Project Number Prefix]
      ,[Minor Tax Category Code]
      ,[Minor Tax Category Desc]
      ,[Minor Tax Category]
      ,[RowSortOrder]
  FROM [EDW].[edw].[dimMinorTaxCategory]
  WHERE [dimMinorTaxCategory_SK] > 0
  ORDER BY [Minor Tax Category Code]


--  =Switch
--(Parameters!p_MTC.Value = "DE", "Defined Area Code"
--,Parameters!p_MTC.Value = "GS", "General Service Code"
--,Parameters!p_MTC.Value = "ID", "Improvement District Code"
--,Parameters!p_MTC.Value = "IT", "Islands Trust Code"
--,Parameters!p_MTC.Value = "LA", "Local Area Code"
--,Parameters!p_MTC.Value = "SA", "Service Area Code"
--,Parameters!p_MTC.Value = "SM", "Specified Municipal Code"
--,Parameters!p_MTC.Value = "SR", "Specified Regional Code"
--)

--  =Switch
--(Parameters!p_MTC.Value = "DE", "Defined Area"
--,Parameters!p_MTC.Value = "GS", "General Service"
--,Parameters!p_MTC.Value = "ID", "Improvement District"
--,Parameters!p_MTC.Value = "IT", "Islands Trust"
--,Parameters!p_MTC.Value = "LA", "Local Area"
--,Parameters!p_MTC.Value = "SA", "Service Area"
--,Parameters!p_MTC.Value = "SM", "Specified Municipal"
--,Parameters!p_MTC.Value = "SR", "Specified Regional"
--)