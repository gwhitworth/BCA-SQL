DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';    
SELECT DISTINCT 
       [A].[dimFolio_SK], 
       [dimPropertyClass_SK], 
       [dimAssessmentGeography_SK], 
       [A].[dimJurisdiction_SK], 
       [BMT].[dimMinorTaxCode_SK],
	   sum([Occurrence]), 
       SUM([Net Other Land Value]) AS [Hosp Land], 
       SUM([Net Other Building Value]) AS [Hosp Improvements]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
     INNER JOIN [edw].[dimRollCycle] AS [B]
     ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
INNER JOIN
(
SELECT DISTINCT 
       [FA].[dimFolio_SK], 
       [Property Class Code], 
       [Property Class Occurrence] AS [Occurrence]
FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
     INNER JOIN [edw].[factValuesByAssessmentCodePropertyClass] AS [FA2]
     ON [fa].[dimFolio_SK] = [fa2].[dimFolio_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
WHERE [Assessment Code] = '02'
      AND [fa].[Roll Year] = @p_RY
      AND [Jurisdiction Code] = '361'
      AND [Cycle Number] = @p_CN
      AND [Property Sub Class Code] IS NULL
	  AND [Current Cycle Flag] = 'Yes'
) AS [OC]
ON [A].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [Current Cycle Flag] = 'Yes'
      AND [A].[dimRollYear_SK] = @p_RY
      AND [B].[Cycle Number] = @p_CN
GROUP BY [A].[dimFolio_SK], 
         [dimPropertyClass_SK], 
         [dimAssessmentGeography_SK], 
         [A].[dimJurisdiction_SK], 
         [BMT].[dimMinorTaxCode_SK];