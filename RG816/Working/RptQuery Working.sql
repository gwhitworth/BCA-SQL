DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
--DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
--SET @p_JR = '213';
SELECT [RD].[Regional District Code], 
       [RD].[Regional District desc], 
       [MT].[Minor Tax Code], 
       [MT].[Minor Tax desc] AS [Minor Tax], 
       
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
	   '(AA'+[AG].[Area Code]+')' AS [Area Code], 
       [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       COUNT(distinct [FA].[dimFolio_SK]) AS [Folios], 
       COUNT( ([PC].[Property Class Code] + [FA].[dimFolio_SK]) )/2 AS [Occurrences], 
       SUM([Gen Land]) AS [Gen Land], 
       SUM([Gen Improvements]) AS [Gen Improvements], 
       SUM([Gen Total]) AS [Gen Total], 
       SUM([Hosp Land]) AS [Hosp Land], 
       SUM([Hosp Improvements]) AS [Hosp Improvements], 
       SUM([Hosp Total]) AS [Hosp Total]
FROM
(
    SELECT distinct [A].[dimFolio_SK], 
           [A].[dimAssessmentGeography_SK], 
           [A].[dimJurisdiction_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           [A].[dimPropertyClass_SK], 

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
         INNER JOIN [edw].[dimRollCycle] AS [B]
         ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
			AND [FO].[BC Hydro Flag] is null
    WHERE [A].[dimRollYear_SK] = @p_RY
          AND [B].[Cycle Number] = @p_CN
         --AND ([Net Other Total Value] + [Net General Total Value]  > 0)
    GROUP BY [A].[dimFolio_SK], 
             [A].[dimPropertyClass_SK], 
             [A].[dimAssessmentGeography_SK], 
             [A].[dimJurisdiction_SK], 
             [BMT].[dimMinorTaxCode_SK]
) AS [FA]

LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--AND [AG].[Area Code] BETWEEN '01' AND '27'
AND [dimRollCategory_BK] = '1'
LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
ON [BJRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
LEFT OUTER JOIN [edw].[dimRegionalDistrict] AS [RD]
ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
LEFT OUTER JOIN [edw].[dimMinorTaxCode] AS [MT]
ON [MT].[dimMinorTaxCode_SK] = [FA].[dimMinorTaxCode_SK]
--LEFT OUTER JOIN
--(
--    SELECT DISTINCT 
--           [FA].[dimFolio_SK], 
		   
--           [Property Class Occurrence] AS [Occurrence]
--    FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
--         INNER JOIN [edw].[factValuesByAssessmentCodePropertyClass] AS [FA2]
--         ON [fa].[dimFolio_SK] = [fa2].[dimFolio_SK]
--         INNER JOIN [edw].[dimPropertyClass] AS [PC]
--         ON [FA2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
--         ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--            AND [dimRollCategory_BK] = '1'
--         INNER JOIN [edw].[dimFolio] AS [FO]
--         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
--            AND [FO].[dimFolioStatus_BK] = '01'
--    WHERE [Assessment Code] = '01'
--          and [fa].[Roll Year] = @p_RY
--          AND [Cycle Number] = @p_CN
--          AND [FA].[dimRollType_SK] = 11
--          AND ([Net Other Total Value] > 0
--               OR [Net General Total Value] > 0)
--) AS [OC]
--ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [RD].[Regional District Code] = @p_RD
	  AND [MT].[Minor Tax Category Code] = 'SM'
	  --AND ([Gen Total]+[Hosp Total])>0
GROUP BY [RD].[Regional District Code], 
         [RD].[Regional District desc], 
         [MT].[Minor Tax Code], 
         [MT].[Minor Tax desc], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc], 
         '(AA'+[AG].[Area Code]+')', 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc]
ORDER BY [RD].[Regional District Code], 
         [MT].[Minor Tax Code], 
         [Area Code], 
         [Jurisdiction Code], 
         [PC].[Property Class Code];