DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_MTC CHAR(9);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_MTC = '01-40103F';
--SET @p_MTC = '01-36103B';
--SET @p_MTC = '01-36203B';
SELECT [Jurisdiction Code], 
       [Minor Tax Code], 
       COUNT(*) AS [CNT]
FROM
(
    SELECT [FA].[dimFolio_SK],[BMT].[Jurisdiction Code], 
           [BMT].[Minor Tax Code],[Net Other Land Value],[Net Other Building Value]
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
          AND [Property Class Code] = '02'
          AND [Net Other Building Value] > 0
) AS [TMP]
GROUP BY [Jurisdiction Code], 
         [Minor Tax Code];