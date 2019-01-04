DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_JR CHAR(3);
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '213';
SET @p_NH = '213101';

SELECT *  FROM [edw].[FactActualAmounts]
where [dimFolio_SK] in
(SELECT [FO].[dimFolio_SK]

FROM [edw].[FactActualAmounts] AS [FA]
     INNER JOIN
(
    SELECT DISTINCT 
           [dimFolio_SK], 
		   [dimPropertyClass_SK], 
           IIF(SUM([Gross General Land Value]) = 0, NULL, SUM([Gross General Land Value])) AS [Gross_Gen_Land], 
           IIF(SUM([Gross General Building Value]) = 0, NULL, SUM([Gross General Building Value])) AS [Gross_Gen_Improvements], 
           IIF(SUM([General Exemptions Land Value]) = 0, NULL, SUM([General Exemptions Land Value])) AS [Exempt_Gen_Land], 
           IIF(SUM([General Exemptions Building Value]) = 0, NULL, SUM([General Exemptions Building Value])) AS [Exempt_Gen_Improvements], 
           IIF(SUM([Net General Land Value]) = 0, NULL, SUM([Net General Land Value])) AS [Net_Gen_Land], 
           IIF(SUM([Net General Building Value]) = 0, NULL, SUM([Net General Building Value])) AS [Net_Gen_Improvements], 
           IIF(SUM([Gross Other Land Value]) = 0, NULL, SUM([Gross Other Land Value])) AS [Gross_Hosp_Land], 
           IIF(SUM([Gross Other Building Value]) = 0, NULL, SUM([Gross Other Building Value])) AS [Gross_Hosp_Improvements], 
           IIF(SUM([Other Exemptions Land Value]) = 0, NULL, SUM([Other Exemptions Land Value])) AS [Exempt_Hosp_Land], 
           IIF(SUM([Other Exemptions Building Value]) = 0, NULL, SUM([Other Exemptions Building Value])) AS [Exempt_Hosp_Improvements], 
           IIF(SUM([Net Other Land Value]) = 0, NULL, SUM([Net Other Land Value])) AS [Net_Hosp_Land], 
           IIF(SUM([Net Other Building Value]) = 0, NULL, SUM([Net Other Building Value])) AS [Net_Hosp_Improvements], 
           IIF(SUM([Gross School Land Value]) = 0, NULL, SUM([Gross School Land Value])) AS [Gross_School_Land], 
           IIF(SUM([Gross School Building Value]) = 0, NULL, SUM([Gross School Building Value])) AS [Gross_School_Improvements], 
           IIF(SUM([School Exemptions Land Value]) = 0, NULL, SUM([School Exemptions Land Value])) AS [Exempt_School_Land], 
           IIF(SUM([School Exemptions Building Value]) = 0, NULL, SUM([School Exemptions Building Value])) AS [Exempt_School_Improvements], 
           IIF(SUM([Net School Land Value]) = 0, NULL, SUM([Net School Land Value])) AS [Net_School_Land], 
           IIF(SUM([Net School Building Value]) = 0, NULL, SUM([Net School Building Value])) AS [Net_School_Improvements]
    FROM [edw].[FactAllAssessedAmounts]
    GROUP BY [dimFolio_SK],[dimPropertyClass_SK]
) AS [FA2]
     ON [FA].[dimFolio_SK] = [FA2].[dimFolio_SK]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]

     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA2].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           SUM([Property Class Occurrence]) AS [OCRCNT]
    FROM [edw].[FactPropertyClassOccurrenceCount]
    GROUP BY [dimFolio_SK]
) AS [OC]
     ON [FA2].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [AG].[Neighbourhood Code] = @p_NH
	  AND [PC].[Property Sub Class Code] = '0105' 
	  AND [Current Cycle Flag] = 'Yes'
	  AND [Exempt Tax Code] = '97')

--ORDER BY [FO].[dimFolio_SK]