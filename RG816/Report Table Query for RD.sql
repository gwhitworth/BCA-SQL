DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
DECLARE @p_MTC CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '361';
SET @p_MTC = 'SM';
SELECT DISTINCT 
       [dimMinorTaxCode_SK], 
       [dimJurisdiction_SK], 
       [Minor Tax Code], 
       [Jurisdiction Code]
FROM [EDW].[edw].[bridgeFolioMinorTax]
WHERE [Regional District Code] IN (@p_RD)
      AND [Roll Year] = @p_RY
      AND [Minor Tax Category Code] = @p_MTC
ORDER BY [Minor Tax Code], 
         [Jurisdiction Code];