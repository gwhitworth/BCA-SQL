DECLARE @p_RY INT;;
DECLARE @p_CN INT
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '213';
SELECT [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction Desc], 
       [FO].[School District Code],
       CASE
           WHEN [PC].[Property Sub Class Code] = '0202'
           THEN 999
           WHEN [PC].[Property Sub Class Code] = '0106'
           THEN 26
           ELSE [PC].[RowSortOrder]
       END AS [RowSortOrder], 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
	   --COUNT(DISTINCT
	   --CASE
    --       WHEN [PC].[Property Class Code] = '01'
    --       THEN [FA].[dimFolio_SK]
		  -- WHEN [PC].[Property Sub Class] = '0201'
    --       THEN [FA].[dimFolio_SK]
    --       WHEN [PC].[Property Class Code] >= '02'
    --       THEN [FA].[dimFolio_SK]
		  -- ELSE 5
       --END)  AS [Folio_Count],
	   SUM([FCNT].[CNT])  AS [Folio_Count],
       --COUNT(DISTINCT [FA].[dimFolio_SK]) AS [Folio_Count], 
       0 AS [Occurrences], 
       --COUNT([OC].[dimFolio_SK]) AS [Occurrences], 
       SUM([FA].[Gross General Land Value]) AS [Gross_Gen_Land], 
       SUM([FA].[Gross General Building Value]) AS [Gross_Gen_Improvements], 
       SUM([FA].[General Exemptions Land Value]) AS [Exempt_Gen_Land], 
       SUM([FA].[General Exemptions Building Value]) AS [Exempt_Gen_Improvements], 
       SUM([FA].[Net General Land Value]) AS [Net_Gen_Land], 
       SUM([FA].[Net General Building Value]) AS [Net_Gen_Improvements], 
       SUM([FA].[Gross Other Land Value]) AS [Gross_Hosp_Land], 
       SUM([FA].[Gross Other Building Value]) AS [Gross_Hosp_Improvements], 
       SUM([FA].[Other Exemptions Land Value]) AS [Exempt_Hosp_Land], 
       SUM([FA].[Other Exemptions Building Value]) AS [Exempt_Hosp_Improvements], 
       SUM([FA].[Net Other Land Value]) AS [Net_Hosp_Land], 
       SUM([FA].[Net Other Building Value]) AS [Net_Hosp_Improvements], 
       SUM([FA].[Gross School Land Value]) AS [Gross_School_Land], 
       SUM([FA].[Gross School Building Value]) AS [Gross_School_Improvements], 
       SUM([FA].[School Exemptions Land Value]) AS [Exempt_School_Land], 
       SUM([FA].[School Exemptions Building Value]) AS [Exempt_School_Improvements], 
       SUM([FA].[Net School Land Value]) AS [Net_School_Land], 
       SUM([FA].[Net School Building Value]) AS [Net_School_Improvements]
FROM
(
    SELECT [FA].[dimFolio_SK], 
           [FA].[dimPropertyClass_SK], 
           [FA].[dimAssessmentGeography_SK], 
           [FA].[dimRollCycle_SK], 
           [FA].[Gross General Land Value], 
           [FA].[Gross General Building Value], 
           [FA].[General Exemptions Land Value], 
           [FA].[General Exemptions Building Value], 
           [FA].[Net General Land Value], 
           [FA].[Net General Building Value], 
           [FA].[Gross Other Land Value], 
           [FA].[Gross Other Building Value], 
           [FA].[Other Exemptions Land Value], 
           [FA].[Other Exemptions Building Value], 
           [FA].[Net Other Land Value], 
           [FA].[Net Other Building Value], 
           [FA].[Gross School Land Value], 
           [FA].[Gross School Building Value], 
           [FA].[School Exemptions Land Value], 
           [FA].[School Exemptions Building Value], 
           [FA].[Net School Land Value], 
           [FA].[Net School Building Value]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            AND [AG].[Roll Category Code] = '1'
    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [AG].[Jurisdiction Code] = @p_JR
          AND (([PC].[Property Class Code] = '01'
                AND [PC].[Property Sub Class Code] IS NOT NULL)
				OR ([PC].[Property Class Code] = '02' AND [PC].[Property Sub Class Code] IS NOT NULL)
               OR ([PC].[Property Class Code] > '02'
                   AND [FA].[Assessed Total Value] > 0))
) AS [FA]
INNER JOIN
(
    SELECT DISTINCT [FA].[dimFolio_SK], 
	   CASE
           --WHEN [PC].[Property Class Code] = '01'
           --THEN 1
		   WHEN [PC].[Property Sub Class Code] = '0201' AND [FA].[Net General Land Value] > 0
           THEN 1
           --WHEN [PC].[Property Class Code] >= '02'
           --THEN 1
		   ELSE 0
       END AS [CNT]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            AND [AG].[Roll Category Code] = '1'
    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [AG].[Jurisdiction Code] = @p_JR
    --      AND (([PC].[Property Class Code] = '01'
    --            AND [PC].[Property Sub Class Code] IS NOT NULL)
				--OR ([PC].[Property Class Code] = '02' AND [PC].[Property Sub Class Code] IS NOT NULL)
    --           OR ([PC].[Property Class Code] > '02'
    --               AND [FA].[Assessed Total Value] > 0))
) AS [FCNT]
ON [FA].[dimFolio_SK] = [FCNT].[dimFolio_SK]

INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
   AND [AG].[Roll Category Code] = '1'
INNER JOIN [edw].[dimFolio] AS [FO]
ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
   AND [FO].[Folio Status Code] = '01'
INNER JOIN [edw].[dimRollCycle] AS [RC]
ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
--     INNER JOIN
--(
--    SELECT DISTINCT 
--           [FA].[dimFolio_SK], 
--           [FA].[dimJurisdiction_SK], 
--           [FA].[dimPropertyClass_SK], 
--           [PC].[Property Class Code]
--    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
--         INNER JOIN [edw].[dimFolio] AS [FO]
--         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
--            AND [FO].[dimFolioStatus_BK] = '01'
--         LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
--         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--         INNER JOIN [edw].[dimRollCycle] AS [RC]
--         ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
--         INNER JOIN [edw].[dimJurisdiction] AS [JR]
--         ON [JR].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
--    WHERE [FA].[Net General Total Value] > 0
--          AND [FA].[dimRollYear_SK] = @p_RY
--          AND [RC].[Cycle Number] = @p_CN
--          AND [JR].[Jurisdiction Code] = @p_JR
--          AND ([PC].[Property Class Code] > '02'
--               OR [PC].[Property Sub Class Code] IS NOT NULL)
--) AS [OC]
--     ON [OC].[dimFolio_SK] = [FA].[dimFolio_SK]
--        AND [OC].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
--        AND [OC].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [RC].[Cycle Number] = @p_CN
      AND [AG].[Jurisdiction Code] = @p_JR
--AND (([PC].[Property Class Code] = '01' AND [PC].[Property Sub Class Code] IS NOT NULL)
----OR ([PC].[Property Class Code] = '02' AND [FA].[Net General Land Value] > 0)
--OR ([PC].[Property Class Code] > '02'AND [FA].[Net General Land Value] > 0))
--AND [FA].[Net General Land Value] > 0
--AND (([PC].[Property Class Code] = '01'
--      AND [FA].[Gross General Land Value] > 0)
--     OR ([PC].[Property Class Code] <> '01'
--         AND [FA].[Gross General Land Value] > 0
--         OR [PC].[Property Sub Class Code] = '0202'))
GROUP BY [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
         [FO].[School District Code],
         CASE
             WHEN [PC].[Property Sub Class Code] = '0202'
             THEN 999
             WHEN [PC].[Property Sub Class Code] = '0106'
             THEN 26
             ELSE [PC].[RowSortOrder]
         END, 
         [PC].[Property Class Code],
         CASE
             WHEN [PC].[Property Class Code] = '01'
             THEN 'RES'
             WHEN [PC].[Property Class Code] <> '01'
             THEN 'NONRES'
         END, 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [FO].[School District Code], 
         [RESNONRES] DESC, 
         [RowSortOrder];