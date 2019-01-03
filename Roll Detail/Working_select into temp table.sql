IF OBJECT_ID('tempdb..#PIDLST') IS NOT NULL DROP TABLE #PIDLST
GO
SELECT * INTO #PIDLST FROM
(SELECT top 200 [A].[Folio Number], 
(
    SELECT [dbo].[FNC_FORMAT_Property_ID_List]
    (STUFF(
    (
        SELECT DISTINCT '; '+ [B].[PID]
        FROM [edw].[dimParcel] AS [B]
                INNER JOIN [edw].[bridgeParcelFolio] AS [C]
                ON [B].[dimParcel_SK] = [C].[dimParcel_SK]
        WHERE [C].[Folio Number] = [A].[Folio Number]
        ORDER BY '; '+ [B].[PID] FOR XML PATH('')
    ), 1, 1, '')
    )
) AS [LST]
FROM [edw].[bridgeParcelFolio] AS [A]
WHERE [A].[Roll Year] = 2017
GROUP BY [A].[Folio Number]) AS JUNK
GO
SELECT top 200 [edw].[dimProperty].[Roll Year], 
       [edw].[dimProperty].[Area Code], 
       [edw].[dimProperty].[Jurisdiction Code], 
       [edw].[dimProperty].[Roll Number], 
       [edw].[dimSchoolDistrict].[School District Code], 
       [edw].[dimProperty].[SITUS Street Number], 
       [edw].[dimProperty].[SITUS Building/Unit Number], 
       [edw].[dimProperty].[SITUS Street Direction], 
       [edw].[dimProperty].[SITUS Address Street Name], 
       [edw].[factValuesByAssessmentCodePropertyClass].[dimRollYear_SK], 
       [edw].[dimManualClass].[Manual Class Code], 
       [edw].[dimNeighbourhood].[Neighbourhood Code], 
       [edw].[dimElectoralDistrict].[Electoral District Code], 
       [edw].[dimProperty].[Primary Actual Use Code], 
       [edw].[factValuesByAssessmentCodePropertyClass].[Property Class Code], 
       --[edw].[dimProperty].[Property ID], 
       --[PID], 
       --[edw].[dimParcel].[PID Display], 
       [edw].[dimParcel].[Legal Text], 
       --[edw].[dimParcel].[Legal Description], 
       [edw].[dimProperty].[SITUS Postal Code], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Equity Type Code], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Party Type Desc], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Name], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Address], 
       [edw].[dimRegionalHospitalDistrict].[Region Hospital District Code], 
       [edw].[bridgeJurisdictionRegionalDistrict].[Regional District Code], 
       [PID_LST].[LST], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Actual Land Value]) AS [Actual Land Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Actual Building Value]) AS [Actual Building Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Actual Total Value]) AS [Actual Total Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net General Land Value]) AS [Net General Land Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net General Building Value]) AS [Net General Building Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net General Total Value]) AS [Net General Total Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net Other Land Value]) AS [Net Other Land Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net Other Building Value]) AS [Net Other Building Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net Other Total Value]) AS [Net Other Total Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net School Land Value]) AS [Net School Land Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net School Building Value]) AS [Net School Building Value], 
       Sum([edw].[factValuesByAssessmentCodePropertyClass].[Net School Total Value]) AS [Net School Total Value]
FROM [edw].[dimProperty]
     INNER JOIN [edw].[dimSchoolDistrict]
     ON [edw].[dimProperty].[dimSchoolDistrict_SK] = [edw].[dimSchoolDistrict].[dimSchoolDistrict_SK]
     INNER JOIN [edw].[factValuesByAssessmentCodePropertyClass]
     ON [edw].[dimProperty].[dimProperty_SK] = [edw].[factValuesByAssessmentCodePropertyClass].[dimProperty_SK]
     INNER JOIN [edw].[dimManualClass]
     ON [edw].[factValuesByAssessmentCodePropertyClass].[dimManualClass_SK] = [edw].[dimManualClass].[dimManualClass_SK]
     INNER JOIN [edw].[dimNeighbourhood]
     ON [edw].[dimProperty].[dimNeighbourhood_SK] = [edw].[dimNeighbourhood].[dimNeighbourhood_SK]
     INNER JOIN [edw].[dimElectoralDistrict]
     ON [edw].[dimProperty].[dimElectoralDistrict_SK] = [edw].[dimElectoralDistrict].[dimElectoralDistrict_SK]
     INNER JOIN [edw].[bridgeParcelFolio]
     ON [edw].[factValuesByAssessmentCodePropertyClass].[dimFolio_SK] = [edw].[bridgeParcelFolio].[dimFolio_SK]
     INNER JOIN [edw].[dimParcel]
     ON [edw].[bridgeParcelFolio].[dimParcel_SK] = [edw].[dimParcel].[dimParcel_SK]
     INNER JOIN [edw].[dimPropertyOwnerAddresses]
     ON [edw].[dimProperty].[dimProperty_SK] = [edw].[dimPropertyOwnerAddresses].[dimProperty_SK]
     INNER JOIN [edw].[dimRegionalHospitalDistrict]
     ON [edw].[factValuesByAssessmentCodePropertyClass].[dimRegionalHospitalDistrict_SK] = [edw].[dimRegionalHospitalDistrict].[dimRegionalHospitalDistrict_SK]
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict]
     ON [edw].[dimProperty].[dimJurisdiction_SK] = [edw].[bridgeJurisdictionRegionalDistrict].[dimJurisdiction_SK]
	 INNER JOIN #PIDLST AS [PID_LST] ON [edw].[bridgeParcelFolio].[Folio Number] = [PID_LST].[Folio Number]

WHERE [edw].[dimProperty].[Roll Year] = 2017
GROUP BY [edw].[dimProperty].[Roll Year], 
       [edw].[dimProperty].[Area Code], 
       [edw].[dimProperty].[Jurisdiction Code], 
       [edw].[dimProperty].[Roll Number], 
       [edw].[dimSchoolDistrict].[School District Code], 
       [edw].[dimProperty].[SITUS Street Number], 
       [edw].[dimProperty].[SITUS Building/Unit Number], 
       [edw].[dimProperty].[SITUS Street Direction], 
       [edw].[dimProperty].[SITUS Address Street Name], 
       [edw].[factValuesByAssessmentCodePropertyClass].[dimRollYear_SK], 
       [edw].[dimManualClass].[Manual Class Code], 
       [edw].[dimNeighbourhood].[Neighbourhood Code], 
       [edw].[dimElectoralDistrict].[Electoral District Code], 
       [edw].[dimProperty].[Primary Actual Use Code], 
       [edw].[factValuesByAssessmentCodePropertyClass].[Property Class Code], 
       --[edw].[dimProperty].[Property ID], 
       --[PID], 
       --[edw].[dimParcel].[PID Display], 
       [edw].[dimParcel].[Legal Text], 
       --[edw].[dimParcel].[Legal Description], 
       [edw].[dimProperty].[SITUS Postal Code], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Equity Type Code], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Party Type Desc], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Name], 
       [edw].[dimPropertyOwnerAddresses].[Owner 1 Address], 
       [edw].[dimRegionalHospitalDistrict].[Region Hospital District Code], 
       [edw].[bridgeJurisdictionRegionalDistrict].[Regional District Code]
	   , [PID_LST].[LST];