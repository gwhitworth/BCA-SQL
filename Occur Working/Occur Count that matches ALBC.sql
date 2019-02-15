DECLARE @p_RY INT;;
DECLARE @p_CN INT
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '361';
--SELECT distinct [A].[dimFolio_SK], 
--          [A].[dimAssessmentGeography_SK], 
--          [BMT].[dimMinorTaxCode_SK], 
--          [A].[dimPropertyClass_SK], 
--          [PC].[Property Class Code]
--   FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
--        LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
--        ON [A].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--        INNER JOIN [edw].[dimRollCycle] AS [B]
--        ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
--        INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
--        ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
--           AND [BMT].[Minor Tax Category Code] = 'SM'
--        INNER JOIN [edw].[dimFolio] AS [FO]
--        ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
--           AND [FO].[dimFolioStatus_BK] = '01'
--        LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
--        ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--           AND [AG].[dimRollCategory_BK] = '1'
--        LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
--        ON [BJRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
--        LEFT OUTER JOIN [edw].[dimRegionalDistrict] AS [RD]
--        ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
--   WHERE [A].[dimRollYear_SK] = @p_RY
--         AND [B].[Cycle Number] = @p_CN
--         --AND ([Net General Total Value] > 0)
--         AND [AG].[Jurisdiction Code] = @p_JR
--         AND [A].[dimPropertyClass_SK] BETWEEN 47 AND 52

SELECT [Jurisdiction Code],[dimMinorTaxCode_SK],[PCLASS], COUNT(*)
FROM
(
    SELECT distinct [A].[dimFolio_SK],
	[AG].[Jurisdiction Code], 
           --[A].[dimAssessmentGeography_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           [A].[dimPropertyClass_SK], 
           [PC].[Property Class Code] AS [PCLASS]--, 
           --SUM([A].[Net General Land Value]) AS [Land], 
           --SUM([Net General Building Value]) AS [Building], 
           --[Net General Total Value] AS [Gen Total]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
         LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [A].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimRollCycle] AS [B]
         ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
            AND [BMT].[Minor Tax Category Code] = 'SM'
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
         LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            AND [AG].[dimRollCategory_BK] = '1'
         LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
         ON [BJRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
         LEFT OUTER JOIN [edw].[dimRegionalDistrict] AS [RD]
         ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
    WHERE [A].[dimRollYear_SK] = @p_RY
          AND [B].[Cycle Number] = @p_CN
          --AND ([Net General Total Value] > 0)
          --AND [AG].[Jurisdiction Code] = @p_JR
		  AND ([PC].[Property Class Code] > '02' OR [PC].[Property Sub Class Code] is not null)
          --AND [A].[dimPropertyClass_SK] BETWEEN 47 AND 52
    --GROUP BY [A].[dimFolio_SK], 
    --         [A].[dimAssessmentGeography_SK], 
    --         [BMT].[dimMinorTaxCode_SK], 
    --         [A].[dimPropertyClass_SK], 
    --         [PC].[Property Class Code]
) AS [A]
WHERE [Jurisdiction Code] = '401'
GROUP BY [Jurisdiction Code],[dimMinorTaxCode_SK],[PCLASS]
ORDER BY [Jurisdiction Code],[dimMinorTaxCode_SK],[PCLASS]

--ORDER BY [A].[dimFolio_SK], 
--         [A].[dimPropertyClass_SK],
--		 [PC].[Property Class Code];
--SELECT DISTINCT 
--       [A].[dimFolio_SK], 
--       [A].[dimAssessmentGeography_SK], 
--       [BMT].[dimMinorTaxCode_SK], 
--       [A].[dimPropertyClass_SK], 
--       SUM([A].[Net other Land Value]), 
--       SUM([Net Other Building Value]), 
--       SUM([Net Other Total Value]) AS [Gen Total]
--FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
--     INNER JOIN [edw].[dimRollCycle] AS [B]
--     ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
--     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
--     ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
--        AND [BMT].[Minor Tax Category Code] = 'SM'
--     INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
--        AND [FO].[dimFolioStatus_BK] = '01'
--     LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
--     ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--        --AND [AG].[Area Code] BETWEEN '01' AND '27'
--        AND [AG].[dimRollCategory_BK] = '1'
--     LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
--     ON [BJRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
--     LEFT OUTER JOIN [edw].[dimRegionalDistrict] AS [RD]
--     ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
--WHERE [A].[dimRollYear_SK] = @p_RY
--      AND [B].[Cycle Number] = @p_CN
--      --AND ([Net other Total Value] > 0)
--      AND [AG].[Jurisdiction Code] = @p_JR
--      AND [A].[dimPropertyClass_SK] < 53
--GROUP BY [A].[dimFolio_SK], 
--         [A].[dimAssessmentGeography_SK], 
--         [BMT].[dimMinorTaxCode_SK], 
--         [A].[dimPropertyClass_SK]
--ORDER BY [A].[dimFolio_SK], 
--         [A].[dimPropertyClass_SK];
--SELECT DISTINCT 
--       [A].[dimFolio_SK], 
--       [A].[dimAssessmentGeography_SK], 
--       [A].[dimJurisdiction_SK], 
--       [BMT].[dimMinorTaxCode_SK], 
--       [A].[dimPropertyClass_SK], 
--       SUM(CASE [A].[dimAssessmentType_SK]
--               WHEN 10
--               THEN [A].[Net General Land Value]
--               ELSE NULL
--           END) AS [Gen Land], 
--       SUM(CASE [A].[dimAssessmentType_SK]
--               WHEN 11
--               THEN [Net General Building Value]
--               ELSE NULL
--           END) AS [Gen Improvements], 
--       SUM([Net General Total Value]) AS [Gen Total], 
--       SUM(CASE [A].[dimAssessmentType_SK]
--               WHEN 10
--               THEN [Net Other Land Value]
--               ELSE NULL
--           END) AS [Hosp Land], 
--       SUM(CASE [A].[dimAssessmentType_SK]
--               WHEN 11
--               THEN [Net Other Building Value]
--               ELSE NULL
--           END) AS [Hosp Improvements], 
--       SUM([Net Other Total Value]) AS [Hosp Total]
--FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
--     INNER JOIN [edw].[dimRollCycle] AS [B]
--     ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
--     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
--     ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
--        AND [BMT].[Minor Tax Category Code] = 'SM'
--     INNER JOIN [edw].[dimFolio] AS [FO]
--     ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
--        AND [FO].[dimFolioStatus_BK] = '01'
--     LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
--     ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--        --AND [AG].[Area Code] BETWEEN '01' AND '27'
--        AND [AG].[dimRollCategory_BK] = '1'
--     LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
--     ON [BJRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
--     LEFT OUTER JOIN [edw].[dimRegionalDistrict] AS [RD]
--     ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
--WHERE [A].[dimRollYear_SK] = @p_RY
--      AND [B].[Cycle Number] = @p_CN
--      AND ([Net other Total Value] > 0)
--      AND [AG].[Jurisdiction Code] = @p_JR
---- and [A].[dimPropertyClass_SK] = 48
----AND ([Net Other Total Value] + [Net General Total Value]  > 0)
--GROUP BY [A].[dimFolio_SK], 
--         [A].[dimPropertyClass_SK], 
--         [A].[dimAssessmentGeography_SK], 
--         [A].[dimJurisdiction_SK], 
--         [BMT].[dimMinorTaxCode_SK]
--ORDER BY [A].[dimFolio_SK], 
--         [A].[dimPropertyClass_SK];