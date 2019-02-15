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
SELECT [dimJurisdiction_SK], 
       [dimMinorTaxCode_SK], 
       [Property Class Code], 
       COUNT(*) AS [OCNT]
FROM
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [BMT].[dimJurisdiction_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           [PC].[Property Class Code]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
         LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimRollCycle] AS [RC]
         ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [FA].[dimFolio_SK]
    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [RC].[Cycle Number] = @p_CN
          AND [BMT].[Minor Tax Category Code] = @p_MTC
          AND ([PC].[Property Class Code] > '02'
               OR [PC].[Property Sub Class Code] IS NOT NULL)
) AS [FA]
WHERE [dimJurisdiction_SK] = 879
GROUP BY [dimJurisdiction_SK], 
         [dimMinorTaxCode_SK], 
         [Property Class Code]
ORDER BY [dimJurisdiction_SK], 
         [dimMinorTaxCode_SK], 
         [Property Class Code];