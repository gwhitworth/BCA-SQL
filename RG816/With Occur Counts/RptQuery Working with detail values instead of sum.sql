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
SELECT [RD].[Regional District Code], 
       [RD].[Regional District desc], 
       [MT].[Minor Tax Code], 
       [MT].[Minor Tax desc] AS [Minor Tax], 
       '(AA'+[AG].[Area Code]+')' AS [Area Code], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
       [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       COUNT(distinct [FA].[dimFolio_SK]) AS [Folios], 
       SUM([Gen Land]) AS [Gen Land], 
       SUM([Gen Improvements]) AS [Gen Improvements], 
       SUM([Gen Total]) AS [Gen Total], 
       SUM([Hosp Land]) AS [Hosp Land], 
       SUM([Hosp Improvements]) AS [Hosp Improvements], 
       SUM([Hosp Total]) AS [Hosp Total]
FROM
(
    SELECT distinct [FA].[dimFolio_SK], 
           [FA].[dimAssessmentGeography_SK], 
           --[FA].[dimJurisdiction_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           [PC].[dimPropertyClass_SK], 
           CASE [FA].[dimAssessmentType_SK]
                   WHEN 10
                   THEN [FA].[Net General Land Value]
                   ELSE 0
               END AS [Gen Land], 
           CASE [FA].[dimAssessmentType_SK]
                   WHEN 11
                   THEN [Net General Building Value]
                   ELSE 0
               END AS [Gen Improvements], 
           [Net General Total Value] AS [Gen Total], 
           CASE [FA].[dimAssessmentType_SK]
                   WHEN 10
                   THEN [Net Other Land Value]
                   ELSE 0
               END AS [Hosp Land], 
           CASE [FA].[dimAssessmentType_SK]
                   WHEN 11
                   THEN [Net Other Building Value]
                   ELSE 0
               END AS [Hosp Improvements], 
           [Net Other Total Value] AS [Hosp Total]



           --SUM(CASE [FA].[dimAssessmentType_SK]
           --        WHEN 10
           --        THEN [FA].[Net General Land Value]
           --        ELSE 0
           --    END) AS [Gen Land], 
           --SUM(CASE [FA].[dimAssessmentType_SK]
           --        WHEN 11
           --        THEN [Net General Building Value]
           --        ELSE 0
           --    END) AS [Gen Improvements], 
           --SUM([Net General Total Value]) AS [Gen Total], 
           --SUM(CASE [FA].[dimAssessmentType_SK]
           --        WHEN 10
           --        THEN [Net Other Land Value]
           --        ELSE 0
           --    END) AS [Hosp Land], 
           --SUM(CASE [FA].[dimAssessmentType_SK]
           --        WHEN 11
           --        THEN [Net Other Building Value]
           --        ELSE 0
           --    END) AS [Hosp Improvements], 
           --SUM([Net Other Total Value]) AS [Hosp Total]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [PC].[dimPropertyClass_SK] = [FA].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimRollCycle] AS [RC]
         ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [FA].[dimFolio_SK]

    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [RC].[Cycle Number] = @p_CN
    --GROUP BY [FA].[dimFolio_SK], 
    --         [PC].[dimPropertyClass_SK], 
    --         [FA].[dimAssessmentGeography_SK], 
    --         --[FA].[dimJurisdiction_SK], 
    --         [BMT].[dimMinorTaxCode_SK]
) AS [FA]
LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
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