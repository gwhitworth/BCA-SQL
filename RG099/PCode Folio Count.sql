DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '213';   
SELECT ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code]) AS [PCLASS], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [CNT]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [AG].[Jurisdiction Code] = @p_JR
	  AND [PC].[Property Class Code] = '01' AND [PC].[Property Sub Class Code] IS NOT NULL
GROUP BY ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])
ORDER BY [PCLASS];

SELECT ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code]) AS [PCLASS], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [CNT]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [AG].[Jurisdiction Code] = @p_JR
	  AND [PC].[Property Class Code] = '02' AND [PC].[Property Sub Class Code] IS NOT NULL
	  AND (([PC].[Property Sub Class Code] = '0201' AND [FA].[Net General Land Value] > 0)
	  OR ([PC].[Property Sub Class Code] = '0202'))
GROUP BY ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])
ORDER BY [PCLASS];

SELECT ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code]) AS [PCLASS], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [CNT]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [AG].[Jurisdiction Code] = @p_JR
	  AND [PC].[Property Class Code] > '02'  AND [FA].[Net General Land Value] > 0
GROUP BY ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])
ORDER BY [PCLASS];