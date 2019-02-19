DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SELECT [AG].[Area],
       CASE
           WHEN [PC].[Property Sub Class Code] = '0202'
           THEN 999
           WHEN [PC].[Property Sub Class Code] = '0106'
           THEN 26
           ELSE [PC].[RowSortOrder]
       END AS [RowSortOrder],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       [PC].[Property Class Code], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [Folio_Count], 
       --COUNT([OC].[dimFolio_SK]) AS [Occurrences], 
	   0 AS [Occurrences], 
       SUM([FA].[Gross General Land Value]) AS [Gross_Gen_Land], 
       SUM([FA].[Gross General Building Value]) AS [Gross_Gen_Improvements], 
       SUM([FA].[Gross General Total Value]) AS [Gross_Gen_Total], 
       SUM([FA].[General Exemptions Land Value]) AS [Exempt_Gen_Land], 
       SUM([FA].[General Exemptions Building Value]) AS [Exempt_Gen_Improvements], 
       SUM([FA].[General Exemptions Total Value]) AS [Exempt_Gen_Total], 
       SUM([FA].[Net General Land Value]) AS [Net_Gen_Land], 
       SUM([FA].[Net General Building Value]) AS [Net_Gen_Improvements], 
       SUM([FA].[Net General Total Value]) AS [Net_Gen_Total], 
       SUM([FA].[Gross Other Land Value]) AS [Gross_Hosp_Land], 
       SUM([FA].[Gross Other Building Value]) AS [Gross_Hosp_Improvements], 
       SUM([FA].[Gross Other Total Value]) AS [Gross_Hosp_Total], 
       SUM([FA].[Other Exemptions Land Value]) AS [Exempt_Hosp_Land], 
       SUM([FA].[Other Exemptions Building Value]) AS [Exempt_Hosp_Improvements], 
       SUM([FA].[Other Exemptions Total Value]) AS [Exempt_Hosp_Total], 
       SUM([FA].[Net Other Land Value]) AS [Net_Hosp_Land], 
       SUM([FA].[Net Other Building Value]) AS [Net_Hosp_Improvements], 
       SUM([FA].[Net Other Total Value]) AS [Net_Hosp_Total], 
       SUM([FA].[Gross School Land Value]) AS [Gross_School_Land], 
       SUM([FA].[Gross School Building Value]) AS [Gross_School_Improvements], 
       SUM([FA].[Gross School Total Value]) AS [Gross_School_Total], 
       SUM([FA].[School Exemptions Land Value]) AS [Exempt_School_Land], 
       SUM([FA].[School Exemptions Building Value]) AS [Exempt_School_Improvements], 
       SUM([FA].[School Exemptions Total Value]) AS [Exempt_School_Total], 
       SUM([FA].[Net School Land Value]) AS [Net_School_Land], 
       SUM([FA].[Net School Building Value]) AS [Net_School_Improvements], 
       SUM([FA].[Net School Total Value]) AS [Net_School_Total]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     LEFT OUTER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        --AND [AG].[Roll Category Code] = '1'
     LEFT OUTER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        --AND [FO].[Folio Status Code] = '01'
     LEFT OUTER JOIN [edw].[dimRollCycle] AS [RC]
     ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
--     INNER JOIN
--(
--    SELECT DISTINCT 
--           [FA].[dimFolio_SK], 
--           [FA].[dimArea_SK], 
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
--         INNER JOIN [edw].[dimArea] AS [AR]
--         ON [AR].[dimArea_SK] = [FA].[dimArea_SK]
--    --WHERE [FA].[Net General Total Value] > 0
--          WHERE [FA].[dimRollYear_SK] = @p_RY
--          AND [RC].[Cycle Number] = @p_CN
--          AND [AR].[Area Code] = @p_AR
--          AND ([PC].[Property Class Code] > '02'
--               OR [PC].[Property Sub Class Code] IS NOT NULL)
--) AS [OC]
--     ON [OC].[dimFolio_SK] = [FA].[dimFolio_SK]
        --AND [OC].[dimArea_SK] = [AG].[dimArea_SK]
        --AND [OC].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [RC].[Cycle Number] = @p_CN
      AND [AG].[Area Code] = @p_AR
      AND (([PC].[Property Class Code] = '01'
            AND [FA].[Gross General Total Value] > 0)
OR ([PC].[Property Class Code] <> '01'
    AND [FA].[Gross General Total Value] > 0
    OR [PC].[Property Sub Class Code] = '0202'))
GROUP BY [AG].[Area],
         CASE
             WHEN [PC].[Property Sub Class Code] = '0202'
             THEN 999
             WHEN [PC].[Property Sub Class Code] = '0106'
             THEN 26
             ELSE [PC].[RowSortOrder]
         END,
         CASE
             WHEN [PC].[Property Class Code] = '01'
             THEN 'RES'
             WHEN [PC].[Property Class Code] <> '01'
             THEN 'NONRES'
         END, 
         [PC].[Property Class Code], 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [AG].[Area], 
         [RESNONRES] DESC, 
         [RowSortOrder];