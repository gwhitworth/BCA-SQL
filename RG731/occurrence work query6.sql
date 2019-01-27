DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';  
SELECT distinct -- fa.[dimFolio_SK], 
--[RD].[Regional District Code], 
----       [RD].[Regional District desc], 
  --     '(AA'+[AG].[Area Code]+')' AS [Area Code], 
      --[AG].[Jurisdiction Code],
	    
       --[AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
       --[MT].[BCA Code], 
       --[MT].[Minor Tax desc] AS [Minor Tax], 
       --[Property Class Code],
	   --, 
       --[Property Sub Class Code],
	   [FA].dimFolio_SK,
	   [Property Class Code],
       [Property Class Occurrence] AS [Occurrence]
FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
inner join [edw].[factValuesByAssessmentCodePropertyClass] as [FA2]
on fa.dimFolio_SK = fa2.dimFolio_SK
inner join [edw].[dimFolio] as [FO] on fo.dimFolio_SK = fa.dimFolio_SK and fo.dimFolioStatus_BK = '01'
--INNER JOIN [edw].[dimPropertyClass] AS [PC]
--ON [FA2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
--ON [BJRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
--INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
--ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
--INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
WHERE [Assessment Code] = '02'
      AND fa.[Roll Year] = 2017 and fo.[Jurisdiction Code] = '361' and [cycle number] = -1
	  and [Property Class Code] = '01' and [Property Sub Class Code] is null
     -- AND [Property Class Occurrence] > 3;\
--group by       [AG].[Jurisdiction Code],
	    
--       --[AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
--       --[MT].[BCA Code], 
--       --[MT].[Minor Tax desc] AS [Minor Tax], 
--	   [AG].[Jurisdiction Code],
--       [Property Class Code]
	   --, 
       --[Property Sub Class Code]

--order by [Property Class Code], [Property Sub Class Code]
Order by fa.dimFolio_SK