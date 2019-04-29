SELECT DISTINCT 
       [AG].[Roll Year] AS [ROLLYEAR], 
       [AG].[Region Desc] AS [REGION], 
       [AG].[Area Code] AS [AREA], 
       [AG].[Jurisdiction Code] AS [JUR], 
       [PR].[Roll Number] AS [ROLL NUM], 
       [AG].[Neighbourhood Code] AS [NEIGH], 
       [AU].[Actual Use Category Desc] AS [PROPERTY TYPE], 
       [AU].[Actual Use Code]+' '+[AU].[Actual Use Desc] AS [PRIMARY ACTUAL USE], 
       [MC].[Manual Class Code] AS [PRED MANUAL CLASS], 
       [PR].[SITUS Full Address] AS [PROPERTY ADDRESS], 
       [PAR].[PID] AS [PID], 
       [PAR].[Legal Description] AS [LEGAL DESCRIPTION], 
       '' AS [LAND TYPE NAME], 
       [FACT].[Land Square Feet], 
       [FACT].[Land Depth] AS [LAND DEPTH], 
       [FACT2].[Actual Total Value] AS [ACTUAL TOTAL], 
       [FACT2].[Actual Land Value] AS [ACTUAL LAND], 
       [FACT2].[Actual Building Value] AS [ACTUAL IMPR], 
       [PCODES].[PropertyClassCodeList] AS [PROPERTY CLASS], 
       [RD].[Regional District] AS [REGIONAL DISTRICT], 
       [FACT].[Outbuilding Count] AS [BLDG COUNT], 
       [AU].[Actual Use Category Desc] AS [BUILDING TYPE], 
       [RES].[Building Id] AS [BUILDING ID], 
       [FACT].[Year Built] AS [YEAR BUILT], 
       [FACT].[Total Living Area] AS [TOTAL FINISHED AREA], 
       [FACT].[Number Full Bathrooms] AS [NUMBER_OF_BATHROOMS], 
       [FACT].[Number Bedrooms] AS [NUMBER OF BEDROOMS], 
       [FACT].[Land Units] AS [STRATA UNIT AREA], 
       '' AS [PREDOMINANT OCCUPANCY], 
       [MC].[Stories] AS [NUMBER OF STOREY], 
       ([FACT].[Unfinished Basement Area] + [FACT].[Total Living Area]) AS [GROSS BUILDING AREA], 
       '' AS [GROSS LEASABLE AREA], 
       '' AS [NET LEASABLE AREA], 
       [MC].[Main Building Flag]
FROM [edw].[FactPropertyInventorySummary] AS [FACT]
     INNER JOIN
(
    SELECT [dimProperty_SK], 
           SUM([Actual Land Value]) AS [Actual Land Value], 
           SUM([Actual Building Value]) AS [Actual Building Value], 
           SUM([Actual Total Value]) AS [Actual Total Value]
    FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass]
    WHERE [Actual Total Value] > 0
    GROUP BY [dimProperty_SK]
) AS [FACT2]
     ON [FACT2].[dimProperty_SK] = [FACT].[dimProperty_SK]
     INNER JOIN
(
    SELECT [dimRollYear_SK], 
           [dimProperty_SK], 
           [PropertyClassCodeList]
    FROM [EDW].[edw].[dimPropertyPropertyClassLists]
) AS [PCODES]
     ON [PCODES].[dimProperty_SK] = [FACT].[dimProperty_SK]
        AND [PCODES].[dimRollYear_SK] = [FACT].[dimRollYear_SK]
     LEFT JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Area Code] = '22'
        AND ([AG].[Neighbourhood Code] IN('701041', '718505'))
     LEFT JOIN [edw].[dimManualClass] AS [MC]
     ON [FACT].[dimManualClass_SK] = [MC].[dimManualClass_SK]
        AND (NOT([MC].[Manual Class Code] IN('C424', 'D424')))
     LEFT JOIN [edw].[dimActualUse] AS [AU]
     ON [FACT].[dimActualUse_SK] = [AU].[dimActualUse_SK]
        AND (NOT([AU].[Actual Use Code] IN('287', '040')))
     LEFT JOIN [edw].[dimProperty] AS [PR]
     ON [FACT].[dimProperty_SK] = [PR].[dimProperty_SK]
     LEFT JOIN [edw].[bridgeParcelProperty]
     ON [PR].[dimProperty_SK] = [edw].[bridgeParcelProperty].[dimProperty_SK]
     LEFT JOIN [edw].[dimParcel] AS [PAR]
     ON [edw].[bridgeParcelProperty].[dimParcel_SK] = [PAR].[dimParcel_SK]
     LEFT JOIN [edw].[dimRegionalDistrict] AS [RD]
     ON [FACT].[dimRegionalDistrict_SK] = [RD].[dimRegionalDistrict_SK]
     LEFT JOIN [edw].[dimResidential] AS [RES]
     ON [PR].[dimProperty_SK] = [RES].[dimProperty_SK]
WHERE [AG].[Roll Year] = 2018
ORDER BY [AREA], 
         [JUR], 
         [ROLL NUM];