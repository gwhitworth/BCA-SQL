DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '361';
SELECT DISTINCT 
       [A].[dimFolio_SK], 
       --[PC].[dimPropertyClass_SK], 
	   
       [AG].[dimAssessmentGeography_SK], 
       [A].[dimJurisdiction_SK], 
       [BMT].[dimMinorTaxCode_SK],
	   [PC].[Property Class Code], 
       --SUM(CASE [A].[dimAssessmentType_SK]
       --        WHEN 10
       --        THEN [Net Other Land Value]
       --        ELSE NULL
       --    END) AS [Hosp Land], 
       --SUM(CASE [A].[dimAssessmentType_SK]
       --        WHEN 11
       --        THEN [Net Other Building Value]
       --        ELSE NULL
       --    END) AS [Hosp Improvements]
		   [Net Other Land Value] AS [Hosp Land],
[Net Other Building Value] AS [Hosp Improvements]
--      --SUM([Net Other Land Value]) AS [Hosp Land], 
--      --SUM([Net Other Building Value]) AS [Hosp Improvements]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
     INNER JOIN [edw].[dimRollCycle] AS [B]
     ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
	 INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [A].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [Current Cycle Flag] = 'Yes'
      AND [A].[dimRollYear_SK] = @p_RY
      AND [B].[Cycle Number] = @p_CN
      AND [Net Other Building Value]+[Net Other Land Value]>0
	  AND [AG].[Jurisdiction Code] = @p_JR
	  AND [PC].[Property Class Code] = '01'
	  AND [dimMinorTaxCode_SK] = 5024
--GROUP BY --[A].[dimFolio_SK], 
--         [PC].[dimPropertyClass_SK], 
--		 [PC].[Property Class Code],
--         [AG].[dimAssessmentGeography_SK], 
--         [A].[dimJurisdiction_SK], 
--         [BMT].[dimMinorTaxCode_SK],
--		 [PC].[Property Class Code]
ORDER BY [A].[dimFolio_SK];


SELECT DISTINCT 
       [AG].[dimAssessmentGeography_SK], 
       [A].[dimJurisdiction_SK], 
       [BMT].[dimMinorTaxCode_SK],
	   [PC].[Property Class Code], 
       SUM(CASE [A].[dimAssessmentType_SK]
               WHEN 10
               THEN [Net Other Land Value]
               ELSE NULL
           END) AS [Hosp Land], 
       SUM(CASE [A].[dimAssessmentType_SK]
               WHEN 11
               THEN [Net Other Building Value]
               ELSE NULL
           END) AS [Hosp Improvements]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
     INNER JOIN [edw].[dimRollCycle] AS [B]
     ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
	 INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [A].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [Current Cycle Flag] = 'Yes'
      AND [A].[dimRollYear_SK] = @p_RY
      AND [B].[Cycle Number] = @p_CN
      AND [Net Other Building Value]+[Net Other Land Value]>0
	  AND [AG].[Jurisdiction Code] = @p_JR
	  AND [PC].[Property Class Code] = '01'
	  AND [dimMinorTaxCode_SK] = 5024
GROUP BY [AG].[dimAssessmentGeography_SK], 
         [A].[dimJurisdiction_SK], 
         [BMT].[dimMinorTaxCode_SK],
		 [PC].[Property Class Code]
