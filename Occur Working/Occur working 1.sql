DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT distinct [FAV].[dimFolio_SK]--, 
--       [FAV].[Property Class Code], 
       --pc.[Property Sub Class Code],

       --cOUNT([FAV].[dimFolio_SK]) - 1
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [RC].[dimRollCycle_SK] = [FAV].[dimRollCycle_SK]
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BRD]
     ON [BRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [FAV].[dimFolio_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [MT].[dimMinorTaxCode_SK] = [BMT].[dimMinorTaxCode_SK]
WHERE [FAV].[dimRollYear_SK] = @p_RY
      AND [AG].[Roll Category Code] = '1'
      AND [FAV].[Property Class Code] = '01'
      AND [RC].[Cycle Number] = @p_CN
      --AND [Assessment Code] = '01'
      AND [FAV].[dimRollType_SK] = 11 --Completed ROLL
      AND [MT].[Minor Tax Category Code] = 'SM'
      --AND [MT].[Minor Tax Code] IN('01-36103B', '01-36203B', '01-40103A')
      AND [FAV].[Current Cycle Flag] = 'Yes'
      AND [MT].[Minor Tax Code] IN('01-36103B')
     AND [PC].[Property Class Code] = '01'
	 and [fav].[dimFolio_SK] IN(24368)
--GROUP BY [FAV].[dimFolio_SK]
--, 
--         [FAV].[Property Class Code]
--,pc.[Property Sub Class Code]
--HAVING COUNT([FAV].[dimFolio_SK]) > 1
ORDER BY [FAV].[dimFolio_SK];
--order by [FAV].[Property Class Code],pc.[Property Sub Class Code]