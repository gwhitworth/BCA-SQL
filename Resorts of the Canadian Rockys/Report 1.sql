SELECT DISTINCT 
       [edw].[dimAssessmentGeography].[Roll Year] AS [ROLLYEAR], 
       [edw].[dimAssessmentGeography].[Region Desc] AS [REGION], 
       [edw].[dimAssessmentGeography].[Area Code] AS [AREA], 
       [edw].[dimAssessmentGeography].[Jurisdiction Code] AS [JUR], 
       [edw].[dimProperty].[Roll Number] AS [ROLL NUM], 
       [edw].[dimAssessmentGeography].[Neighbourhood Code] AS [NEIGH], 
       [edw].[dimActualUse].[Property Type Code] AS [PROPERTY TYPE], 
       [edw].[dimActualUse].[Actual Use Code] AS [PRIMARY ACTUAL USE], 
       [edw].[dimManualClass].[Manual Class Code] AS [PRED MANUAL CLASS], 
       [edw].[dimProperty].[SITUS Full Address] AS [PROPERTY ADDRESS], 
       [edw].[dimParcel].[PID Display] AS [PID], 
       [edw].[dimParcel].[Legal Description] AS [LEGAL DESCRIPTION], 
       '' AS [LAND TYPE NAME], 
       [edw].[FactPropertyInventorySummary].[Land Square Feet], 
       [edw].[FactPropertyInventorySummary].[Land Depth] AS [LAND DEPTH], 
       --[edw].[FactRollSummary].[Total Actual Value] AS [ACTUAL TOTAL], 
       --[edw].[FactRollSummary].[Total Land Value] AS [ACTUAL LAND], 
       --[edw].[FactRollSummary].[Total Building Value] AS [ACTUAL IMPR], 
       [edw].[dimPropertyClass].[Property Class] AS [PROPERTY CLASS], 
       [edw].[dimRegionalDistrict].[Regional District] AS [REGIONAL DISTRICT], 
       [edw].[FactPropertyInventorySummary].[Outbuilding Count] AS [BLDG COUNT], 
       '' AS [BUILDING TYPE], 
       [edw].[dimResidential].[Building Id] AS [BUILDING ID], 
       [edw].[FactPropertyInventorySummary].[Year Built] AS [YEAR BUILT], 
       [edw].[FactPropertyInventorySummary].[Total Living Area] AS [TOTAL FINISHED AREA], 
       [edw].[FactPropertyInventorySummary].[Number Full Bathrooms] AS [NUMBER_OF_BATHROOMS], 
       [edw].[FactPropertyInventorySummary].[Number Bedrooms] AS [NUMBER OF BEDROOMS], 
       [edw].[FactPropertyInventorySummary].[Land Units] AS [STRATA UNIT AREA], 
       '' AS [PREDOMINANT OCCUPANCY], 
       [edw].[dimManualClass].[Stories] AS [NUMBER OF STOREY], 
       [edw].[FactPropertyInventorySummary].[Unfinished Basement Area] AS [GROSS BUILDING AREA], 
       '' AS [GROSS LEASABLE AREA], 
       '' AS [NET LEASABLE AREA], 
       [edw].[dimManualClass].[Main Building Flag]
FROM [edw].[FactRollSummary]
     INNER JOIN [edw].[dimAssessmentGeography]
     ON [edw].[FactRollSummary].[dimAssessmentGeography_SK] = [edw].[dimAssessmentGeography].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimManualClass]
     ON [edw].[FactRollSummary].[dimManualClass_SK] = [edw].[dimManualClass].[dimManualClass_SK]
     INNER JOIN [edw].[dimActualUse]
     ON [edw].[FactRollSummary].[dimActualUse_SK] = [edw].[dimActualUse].[dimActualUse_SK]
     INNER JOIN [edw].[dimParcel]
     INNER JOIN [edw].[bridgeParcelProperty]
                ON [edw].[dimParcel].[dimParcel_SK] = [edw].[bridgeParcelProperty].[dimParcel_SK]
     INNER JOIN [edw].[dimProperty]
                ON [edw].[bridgeParcelProperty].[dimProperty_SK] = [edw].[dimProperty].[dimProperty_SK]
     ON [edw].[FactRollSummary].[dimProperty_SK] = [edw].[dimProperty].[dimProperty_SK]
     INNER JOIN [edw].[FactPropertyInventorySummary]
     ON [edw].[FactRollSummary].[dimProperty_SK] = [edw].[FactPropertyInventorySummary].[dimProperty_SK]
     INNER JOIN [edw].[dimPropertyClass]
     ON [edw].[FactPropertyInventorySummary].[dimPropertyClass_SK] = [edw].[dimPropertyClass].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimRegionalDistrict]
     ON [edw].[FactPropertyInventorySummary].[dimRegionalDistrict_SK] = [edw].[dimRegionalDistrict].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[dimResidential]
     ON [edw].[dimProperty].[dimProperty_SK] = [edw].[dimResidential].[dimProperty_SK]
WHERE([edw].[dimAssessmentGeography].[Area Code] = '22')
     AND ([edw].[dimAssessmentGeography].[Neighbourhood Code] IN('701041', '718505'))
     AND (NOT([edw].[dimManualClass].[Manual Class Code] IN('C424', 'D424')))
AND (NOT([edw].[dimActualUse].[Actual Use Code] IN('287', '040')))
AND ([edw].[dimAssessmentGeography].[Roll Year] = 2018);