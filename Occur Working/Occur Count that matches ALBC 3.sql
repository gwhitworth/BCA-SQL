DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
DECLARE @p_MTC CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '361';
SET @p_MTC = 'SM';
SELECT [Jurisdiction Code], 
       [dimMinorTaxCode_SK], 
       [PCLASS], 
       COUNT(*)
FROM
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [AG].[Jurisdiction Code], 
           [BMT].[dimMinorTaxCode_SK], 
           [FA].[dimPropertyClass_SK], 
           [PC].[Property Class Code] AS [PCLASS]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimRollCycle] AS [RC]
         ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [FA].[dimFolio_SK]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
         LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            AND [AG].[dimRollCategory_BK] = '1'
         LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
         ON [BJRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
         LEFT OUTER JOIN [edw].[dimRegionalDistrict] AS [RD]
         ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [RC].[Cycle Number] = @p_CN
		   AND [BMT].[Minor Tax Category Code] = @p_MTC
          AND ([PC].[Property Class Code] > '02'
               OR [PC].[Property Sub Class Code] IS NOT NULL)
) AS [FA]
WHERE [Jurisdiction Code] = '361'
GROUP BY [Jurisdiction Code], 
         [dimMinorTaxCode_SK], 
         [PCLASS]
ORDER BY [Jurisdiction Code], 
         [dimMinorTaxCode_SK], 
         [PCLASS];