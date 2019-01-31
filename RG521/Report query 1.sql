DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_MTC INT;

SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_MTC = 12;  --SERVICE AREA

SELECT [RD].[Regional District Code], 
       [RD].[Regional District desc], 
       [MT].[BCA Code] AS [Code], 
       [AG].[Jurisdiction Code] AS [Jur Code], 
       [AG].[Area Code] AS [AA], 
       [MT].[Minor Tax desc] AS [Minor Tax Title], 
       COUNT(distinct [FA].[dimFolio_SK]) AS [Folios], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN ([FA].[Net General Value] + [Net Other Value] + [FA].[Net School Value])
               ELSE 0
           END) AS [Net Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN ([FA].[Net General Value] + [Net Other Value] + [FA].[Net School Value])
               ELSE 0
           END) AS [Net Impr],
		SUM([FA].[Net General Value] + [Net Other Value] + [FA].[Net School Value]) AS [Net Total]
FROM [EDW].[edw].[FactAssessedValue] AS [FA]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
     ON [BJRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
     ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BFMT]
     ON [BFMT].[dimFolio_SK] = [FA].[dimFolio_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [MT].[dimMinorTaxCode_SK] = [BFMT].[dimMinorTaxCode_SK]
WHERE [Current Cycle Flag] = 'Yes'
      AND [FA].[dimRollYear_SK] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND ([FA].[Net General Value] + [Net Other Value] + [FA].[Net School Value]) > 0
	  AND [MT].[dimMinorTaxCategory_SK] = @p_MTC
	  AND [RD].[Regional District Code] < '88'
GROUP BY [RD].[Regional District Code], 
         [RD].[Regional District desc], 
         [MT].[BCA Code], 
         [AG].[Jurisdiction Code], 
         [AG].[Area Code], 
         [MT].[Minor Tax desc]
ORDER BY [RD].[Regional District Code], 
         [MT].[BCA Code], 
         [AG].[Jurisdiction Code], 
         [AG].[Area Code], 
         [MT].[Minor Tax desc];