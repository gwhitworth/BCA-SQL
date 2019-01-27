DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';  
SELECT --[dimFolio_SK], 
--[RD].[Regional District Code], 
--       [RD].[Regional District desc], 
--       '(AA'+[AG].[Area Code]+')' AS [Area Code], 
      -- [AG].[Jurisdiction Code],
	    
       --[AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
       --[MT].[BCA Code], 
       --[MT].[Minor Tax desc] AS [Minor Tax], 
       [PC].[Property Class Code], 
       [PC].[Property Sub Class Code],
	   [FA].*
       --[Property Class Occurrence] AS [Occurrence]
FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
inner join [edw].[factValuesByAssessmentCodePropertyClass] as [FA2]
on fa.dimFolio_SK = fa2.dimFolio_SK
INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
--ON [BJRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
--INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
--ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
--INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
WHERE [Assessment Code] = '01'
      AND fa.[Roll Year] = 2017 and [Jurisdiction Code] = '361' and [cycle number] = -1
     -- AND [Property Class Occurrence] > 3;\
	 
Order by fa.dimFolio_SK