DECLARE @p_RY INT;;
DECLARE @p_CN INT
DECLARE @p_AR CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SELECT 
       [FA].*
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     --INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     --ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     --   AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
		AND [FO].[BC Hydro Flag] IS  NULL
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
	 AND [RC].[Cycle Number] = @p_CN
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [FA].[dimArea_SK] = 18
      AND [PC].[Property Class Code] IN('08')
	  AND [Current Cycle Flag] = 'Yes'
     --AND [FA].[Net General Land Value] > 0
ORDER BY [FO].[dimFolio_SK];

SELECT 
       [FA].[dimFolio_SK],ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code]) AS [PCLASS],

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
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     --INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     --ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     --   AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
		AND [FO].[BC Hydro Flag] IS  NULL
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
	 AND [RC].[Cycle Number] = @p_CN
WHERE [FA].[dimRollYear_SK] = @p_RY
      --AND [FA].[dimArea_SK] = 18
      AND [PC].[Property Class Code] IN('08')
	  AND [Current Cycle Flag] = 'Yes'
     AND ([FA].[Net General Total Value] + [FA].[Net Other Total Value] + [FA].[Net School Total Value] > 0 )
GROUP BY [FA].[dimFolio_SK],ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])
ORDER BY [FA].[dimFolio_SK];
