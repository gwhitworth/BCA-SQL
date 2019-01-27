DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';
SELECT TOP 300 [A].[dimFolio_SK], 
               [dimPropertyClass_SK], 
               [dimAssessmentGeography_SK], 
               [A].[dimJurisdiction_SK], 
               [BMT].[dimMinorTaxCode_SK], 
               SUM([Net Other Land Value]) AS [Hosp Land], 
               SUM([Net Other Building Value]) AS [Hosp Improvements]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
     INNER JOIN [edw].[dimRollCycle] AS [B]
     ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
WHERE [Current Cycle Flag] = 'Yes'
      AND [A].[dimRollYear_SK] = @p_RY
      AND [B].[Cycle Number] = @p_CN
GROUP BY [A].[dimFolio_SK], 
         [dimPropertyClass_SK], 
         [dimAssessmentGeography_SK], 
         [A].[dimJurisdiction_SK], 
         [BMT].[dimMinorTaxCode_SK];