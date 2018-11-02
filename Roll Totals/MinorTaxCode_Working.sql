
/****** Script for SelectTopNRows command from SSMS  ******/

DECLARE @p_RY INT;
DECLARE @p_MTC CHAR(2);
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_MTC = 'DE';
SET @p_RD = '03';
SELECT [dimMinorTaxCode_SK], 
       [dimMinorTaxCode_BK], 
       [dimRollYear_SK], 
       [dimJurisdiction_SK], 
       [dimRegionalDistrict_SK], 
       [dimElectoralDistrict_SK], 
       [dimMinorTaxCategory_SK], 
       [dimJurisdiction_BK], 
       [dimRegionalDistrict_BK], 
       [dimElectoralDistrict_BK], 
       [dimMinorTaxCategory_BK], 
       [Minor Tax Code], 
       [Minor Tax Desc], 
       [Minor Tax Annual Desc], 
       [Minor Tax], 
       [Roll Year], 
       [JUR_IAS], 
       [Minor Tax Category Code], 
       [Minor Tax Category Desc], 
       [Minor Tax Category], 
       [Jurisdiction Code], 
       [Jurisdiction Desc], 
       [Jurisdiction], 
       [Regional District Code], 
       [Regional District Desc], 
       [Regional District], 
       [Electoral District Code], 
       [Electoral District Desc], 
       [Electoral District], 
       [BCA Code], 
       [Tax Base Code], 
       [dimDataSource_SK], 
       [RowEffectiveDtm], 
       [RowCurrentYN], 
       [RowCreatedDtm], 
       [RowExpiryDtm], 
       [SSISExecutionId], 
       [RowUpdatedDtm], 
       [CDC_Operation], 
       [RowSortOrder]
FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
WHERE [Roll Year] = @p_RY
      AND [Minor Tax Category Code] = @p_MTC
      AND [Regional District Code] = @p_RD;