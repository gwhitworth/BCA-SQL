DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';
SELECT DISTINCT 
       [JR].[Jurisdiction Code]
FROM [edw].[dimFolio] AS [FO]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
     INNER JOIN [edw].[dimJurisdiction] AS [JR] ON [FO].[Jurisdiction Code] = [JR].[Jurisdiction Code]
     INNER JOIN [edw].[dimJurisdictionType] AS [JT] ON [JT].dimJurisdictionType_SK = [JR].dimJurisdictionType_SK
WHERE [FO].[Roll Year] = @p_RY
      AND [FO].[Folio Status Code] = '01'
      AND [RD].[Regional District Code] = @p_RD
      AND [JT].[Jurisdiction Type Code] IN('T', 'D', 'C', 'V')
ORDER BY [JR].[Jurisdiction Code];