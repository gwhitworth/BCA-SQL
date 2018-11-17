DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
DECLARE @p_EC CHAR(1);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';
SET @p_EC = 'H'
SELECT DISTINCT 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [ED]
     ON [ED].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [RD].[Regional District Code] = @p_RD
      AND [ED].[BCA Code] = @p_EC
ORDER BY [Jurisdiction];