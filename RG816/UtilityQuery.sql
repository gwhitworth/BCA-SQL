DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_MTC CHAR(9);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_MTC = '01-36103B';
SELECT [AG].[Jurisdiction Code], 
       [AG].[dimJurisdiction_SK], 
       [MT].[Minor Tax Code], 
       [MT].[dimMinorTaxCode_SK], 
       SUM([Gen Land]) AS [Gen Land], 
       SUM([Gen Improvements]) AS [Gen Improvements], 
       SUM([Gen Total]) AS [Gen Total]
FROM
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [FA].[dimAssessmentGeography_SK], 
           [FA].[dimJurisdiction_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           [dimPropertyClass_SK], 
           SUM(CASE [FA].[dimAssessmentType_SK]
                   WHEN 10
                   THEN [Net General Land Value]
                   ELSE 0
               END) AS [Gen Land], 
           SUM(CASE [FA].[dimAssessmentType_SK]
                   WHEN 11
                   THEN [Net General Building Value]
                   ELSE 0
               END) AS [Gen Improvements], 
           SUM([Net General Total Value]) AS [Gen Total]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
         INNER JOIN [edw].[dimRollCycle] AS [RC]
         ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [FA].[dimFolio_SK]
    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [RC].[Cycle Number] = @p_CN
          AND [BMT].[Minor Tax Code] = @p_MTC
          AND ([Net General Total Value]) > 0
    GROUP BY [FA].[dimFolio_SK], 
             [dimPropertyClass_SK], 
             [FA].[dimAssessmentGeography_SK], 
             [FA].[dimJurisdiction_SK], 
             [BMT].[dimMinorTaxCode_SK]
) AS [FA]
INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
   AND [PC].[Property Class Code] = '02'
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
ON [BJRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
ON [MT].[dimMinorTaxCode_SK] = [FA].[dimMinorTaxCode_SK]
GROUP BY [AG].[Jurisdiction Code], 
         [AG].[dimJurisdiction_SK], 
         [MT].[Minor Tax Code], 
         [MT].[dimMinorTaxCode_SK]
ORDER BY [AG].[Jurisdiction Code], 
         [MT].[Minor Tax Code];