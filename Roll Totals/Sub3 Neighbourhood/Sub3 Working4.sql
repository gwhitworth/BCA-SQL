DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_JR CHAR(3);
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '213';
SET @p_NH = '213101';
SELECT [FA].[Roll Year], 
       [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction Desc], 
       [FO].[School District Code], 
       [AG].[Neighbourhood Code], 
       [AG].[Neighbourhood], 
       IIF([PC].[Property Sub Class Code] = '0202', 999, [PC].[RowSortOrder]) AS [RowSortOrder], 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class],
	   [PC].[Property Sub Class Code]
	   ,[FO].[dimFolio_SK],
		[FA].[Current Cycle Flag],
	  --,[FA].[Exempt Tax Code],
	  --[FA].[dimRollType_BK]
       sum([FA].[Actual Land Value]), 
       sum([FA].[Actual Building Value])
	   --[Net_Gen_Land], 
    --   [Net_Gen_Improvements]
	   --,
       --COUNT([OCRCNT]) AS [Folio_Count], 
       --SUM(CASE
       --        WHEN [FA].[Actual Land Value] > 0
       --             OR [FA].[Actual Building Value] > 0
       --        THEN [OCRCNT]
       --        ELSE 0
       --    END) AS [Occurrences], 
       --SUM([FA].[Actual Land Value]) AS [Actual Land Value], 
       --SUM([FA].[Actual Building Value]) AS [Actual Building Value], 
       --SUM([FA].[Actual Land Value]) + SUM([FA].[Actual Building Value]) AS [Actual - Total], 
       --SUM([Gross_Gen_Land]) AS [Gross_Gen_Land], 
       --SUM([Gross_Gen_Improvements]) AS [Gross_Gen_Improvements], 
       --SUM([Exempt_Gen_Land]) AS [Exempt_Gen_Land], 
       --SUM([Exempt_Gen_Improvements]) AS [Exempt_Gen_Improvements], 
       --SUM([Net_Gen_Land]) AS [Net_Gen_Land], 
       --SUM([Net_Gen_Improvements]) AS [Net_Gen_Improvements], 
       --SUM([Gross_Hosp_Land]) AS [Gross_Hosp_Land], 
       --SUM([Gross_Hosp_Improvements]) AS [Gross_Hosp_Improvements], 
       --SUM([Exempt_Hosp_Land]) AS [Exempt_Hosp_Land], 
       --SUM([Exempt_Hosp_Improvements]) AS [Exempt_Hosp_Improvements], 
       --SUM([Net_Hosp_Land]) AS [Net_Hosp_Land], 
       --SUM([Net_Hosp_Improvements]) AS [Net_Hosp_Improvements], 
       --SUM([Gross_School_Land]) AS [Gross_School_Land], 
       --SUM([Gross_School_Improvements]) AS [Gross_School_Improvements], 
       --SUM([Exempt_School_Land]) AS [Exempt_School_Land], 
       --SUM([Exempt_School_Improvements]) AS [Exempt_School_Improvements], 
       --SUM([Net_School_Land]) AS [Net_School_Land], 
       --SUM([Net_School_Improvements]) AS [Net_School_Improvements]
FROM [edw].[FactTotalAllAmounts] AS [FA]
--     INNER JOIN
--(
--    SELECT DISTINCT 
--           [dimFolio_SK], 
--		   [dimPropertyClass_SK], 
--           IIF(SUM([Gross General Land Value]) = 0, NULL, SUM([Gross General Land Value])) AS [Gross_Gen_Land], 
--           IIF(SUM([Gross General Building Value]) = 0, NULL, SUM([Gross General Building Value])) AS [Gross_Gen_Improvements], 
--           IIF(SUM([General Exemptions Land Value]) = 0, NULL, SUM([General Exemptions Land Value])) AS [Exempt_Gen_Land], 
--           IIF(SUM([General Exemptions Building Value]) = 0, NULL, SUM([General Exemptions Building Value])) AS [Exempt_Gen_Improvements], 
--           IIF(SUM([Net General Land Value]) = 0, NULL, SUM([Net General Land Value])) AS [Net_Gen_Land], 
--           IIF(SUM([Net General Building Value]) = 0, NULL, SUM([Net General Building Value])) AS [Net_Gen_Improvements], 
--           IIF(SUM([Gross Other Land Value]) = 0, NULL, SUM([Gross Other Land Value])) AS [Gross_Hosp_Land], 
--           IIF(SUM([Gross Other Building Value]) = 0, NULL, SUM([Gross Other Building Value])) AS [Gross_Hosp_Improvements], 
--           IIF(SUM([Other Exemptions Land Value]) = 0, NULL, SUM([Other Exemptions Land Value])) AS [Exempt_Hosp_Land], 
--           IIF(SUM([Other Exemptions Building Value]) = 0, NULL, SUM([Other Exemptions Building Value])) AS [Exempt_Hosp_Improvements], 
--           IIF(SUM([Net Other Land Value]) = 0, NULL, SUM([Net Other Land Value])) AS [Net_Hosp_Land], 
--           IIF(SUM([Net Other Building Value]) = 0, NULL, SUM([Net Other Building Value])) AS [Net_Hosp_Improvements], 
--           IIF(SUM([Gross School Land Value]) = 0, NULL, SUM([Gross School Land Value])) AS [Gross_School_Land], 
--           IIF(SUM([Gross School Building Value]) = 0, NULL, SUM([Gross School Building Value])) AS [Gross_School_Improvements], 
--           IIF(SUM([School Exemptions Land Value]) = 0, NULL, SUM([School Exemptions Land Value])) AS [Exempt_School_Land], 
--           IIF(SUM([School Exemptions Building Value]) = 0, NULL, SUM([School Exemptions Building Value])) AS [Exempt_School_Improvements], 
--           IIF(SUM([Net School Land Value]) = 0, NULL, SUM([Net School Land Value])) AS [Net_School_Land], 
--           IIF(SUM([Net School Building Value]) = 0, NULL, SUM([Net School Building Value])) AS [Net_School_Improvements]
--    FROM [edw].[FactAllAssessedAmounts]
--    GROUP BY [dimFolio_SK],[dimPropertyClass_SK]
--) AS [FA2]
--     ON [FA].[dimFolio_SK] = [FA2].[dimFolio_SK]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]

     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           SUM([Property Class Occurrence]) AS [OCRCNT]
    FROM [edw].[FactPropertyClassOccurrenceCount]
    GROUP BY [dimFolio_SK]
) AS [OC]
     ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [AG].[Neighbourhood Code] = @p_NH
	  AND [PC].[Property Sub Class Code] = '0105'
	  --AND [FA].[Current Cycle Flag] = 'Yes'
	  --AND [FA].[Exempt Tax Code] = '00'

group by [FA].[Roll Year], 
       [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
       [FO].[School District Code], 
       [AG].[Neighbourhood Code], 
       [AG].[Neighbourhood], 
       IIF([PC].[Property Sub Class Code] = '0202', 999, [PC].[RowSortOrder]), 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END, 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]),
	   [PC].[Property Sub Class Code]
	   ,[FO].[dimFolio_SK],
		[FA].[Current Cycle Flag]
ORDER BY [FO].[dimFolio_SK]