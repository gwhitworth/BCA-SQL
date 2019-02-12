DECLARE @p_RY INT
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
--DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
--SET @p_JR = '213';
SELECT [A].[dimFolio_SK], 
       [A].[dimAssessmentGeography_SK], 
       [A].[dimJurisdiction_SK], 
       [BMT].[dimMinorTaxCode_SK], 

       [PC].[dimPropertyClass_SK], 
       SUM(CASE [A].[dimAssessmentType_SK]
               WHEN 10
               THEN [A].[Net General Land Value]
               ELSE NULL
           END) AS [Gen Land], 
       SUM(CASE [A].[dimAssessmentType_SK]
               WHEN 11
               THEN [Net General Building Value]
               ELSE NULL
           END) AS [Gen Improvements], 
       SUM([Net General Total Value]) AS [Gen Total], 
       SUM(CASE [A].[dimAssessmentType_SK]
               WHEN 10
               THEN [Net Other Land Value]
               ELSE NULL
           END) AS [Hosp Land], 
       SUM(CASE [A].[dimAssessmentType_SK]
               WHEN 11
               THEN [Net Other Building Value]
               ELSE NULL
           END) AS [Hosp Improvements], 
       SUM([Net Other Total Value]) AS [Hosp Total]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [PC].[dimPropertyClass_SK] = [A].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimRollCycle] AS [B]
     ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
        AND [FO].[dimFolioStatus_BK] = '01'

WHERE [A].[dimRollYear_SK] = @p_RY
      AND [B].[Cycle Number] = @p_CN
      AND ([Net Other Total Value] + [Net General Total Value] > 0)
	  AND dimMinorTaxCode_SK = 4664
      --AND ([PC].[Property Sub Class Code] <> '0202'
      --     OR [PC].[Property Sub Class Code] IS NULL)
and [PC].[dimPropertyClass_SK] = 54
GROUP BY [A].[dimFolio_SK], 
         [PC].[dimPropertyClass_SK], 
         [A].[dimAssessmentGeography_SK], 
         [A].[dimJurisdiction_SK], 
         [BMT].[dimMinorTaxCode_SK];