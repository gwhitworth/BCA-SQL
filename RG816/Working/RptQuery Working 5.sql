DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '361'
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
	   COUNT(distinct [FA2].[dimFolio_SK]) AS [Folios2],
       COUNT(distinct ([PC].[Property Class Code] + [FA].[dimFolio_SK]) ) AS [Occurrences], 
	   COUNT(distinct ([PC].[Property Class Code] + [FA2].[dimFolio_SK]) ) AS [Occurrences2],
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
           [BMT].[dimMinorTaxCode_SK], 
           [A].[dimPropertyClass_SK], 

		   CASE [A].[dimAssessmentType_SK]
                   WHEN 10
                   THEN [A].[Net General Land Value]
                   ELSE NULL
               END AS [Gen Land], 
           CASE [A].[dimAssessmentType_SK]
                   WHEN 11
                   THEN [Net General Building Value]
                   ELSE NULL
               END AS [Gen Improvements], 
           [Net General Total Value] AS [Gen Total]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
         INNER JOIN [edw].[dimRollCycle] AS [B]
         ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
		 AND [BMT].[Minor Tax Category Code] = 'SM'
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
    WHERE [A].[dimRollYear_SK] = @p_RY
          AND [B].[Cycle Number] = @p_CN
          AND ([Net General Total Value]  > 0)

) AS [FA]
LEFT OUTER JOIN
(
    SELECT distinct [A].[dimFolio_SK], 
           [A].[dimJurisdiction_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           [A].[dimPropertyClass_SK], 

           CASE [A].[dimAssessmentType_SK]
                   WHEN 10
                   THEN [Net Other Land Value]
                   ELSE NULL
               END AS [Hosp Land], 
           CASE [A].[dimAssessmentType_SK]
                   WHEN 11
                   THEN [Net Other Building Value]
                   ELSE NULL
               END AS [Hosp Improvements], 
           [Net Other Total Value] AS [Hosp Total]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
         INNER JOIN [edw].[dimRollCycle] AS [B]
         ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
		 AND [BMT].[Minor Tax Category Code] = 'SM'
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
    WHERE [A].[dimRollYear_SK] = @p_RY
          AND [B].[Cycle Number] = @p_CN
          AND ([Net Other Total Value] > 0)
) AS [FA2]
ON [FA].[dimFolio_SK] = [FA2].[dimFolio_SK]

LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--AND [AG].[Area Code] BETWEEN '01' AND '27'
AND [dimRollCategory_BK] = '1'
LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
ON [BJRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
LEFT OUTER JOIN [edw].[dimRegionalDistrict] AS [RD]
ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
LEFT OUTER JOIN [edw].[dimMinorTaxCode] AS [MT]
ON [MT].[dimMinorTaxCode_SK] = [FA].[dimMinorTaxCode_SK]
WHERE [RD].[Regional District Code] = @p_RD
	  
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