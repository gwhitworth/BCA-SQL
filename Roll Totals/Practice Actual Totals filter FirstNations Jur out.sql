DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
--DECLARE @p_JR CHAR(3);
--DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
--SET @p_JR = '213';
--SET @p_RD = '03';    
SELECT [FA].[dimFolio_SK], 
       [dimPropertyClass_SK], 
       SUM([Actual Land Value]) AS [Actual Land Value]
FROM [edw].[FactTotalAllAmounts] AS [FA]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [AG].[dimAssessmentGeography_SK] = [FA].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimJurisdiction] AS [JR]
     ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimJurisdictionType] AS [JT]
     ON [JR].[dimJurisdictionType_SK] = [JT].[dimJurisdictionType_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [Cycle Number] = @p_CN
      AND [dimPropertyClass_SK] = 47
      AND [JT].[Jurisdiction Type Code] IN('C', 'D', 'T', 'V', 'R')
GROUP BY [FA].[dimFolio_SK], 
         [dimPropertyClass_SK];