DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '234';
SELECT [RT].[Grant Roll Prefix], 
       [Roll Type Desc], 
       COUNT([dimFolio_SK]) AS [Folio Count]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimRollType] AS [RT]
     ON [RT].[dimRollType_SK] = [FA].[dimRollType_SK]
     INNER JOIN [edw].[dimJurisdiction] AS [JR]
     ON [JR].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
WHERE [RT].[Roll Class Code] = 'GR'
      AND [JR].[Jurisdiction Code] = @p_JR
GROUP BY [RT].[Grant Roll Prefix], 
         [Roll Type Desc]
ORDER BY [RT].[Grant Roll Prefix];