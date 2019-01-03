SELECT [edw].[dimProperty].[Roll Year], 
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
                 [edw].[factValuesByAssessmentCodePropertyClass].[Actual Land Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Actual Building Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Actual Total Value], 
                 [edw].[dimParcel].[PID Display], 
                 [edw].[dimParcel].[Legal Text], 
                 [edw].[dimParcel].[Legal Description], 
                 [edw].[dimProperty].[SITUS Postal Code], 
                 [edw].[dimPropertyOwnerAddresses].[Owner 1 Equity Type Code], 
                 [edw].[dimPropertyOwnerAddresses].[Owner 1 Party Type Desc], 
                 [edw].[dimPropertyOwnerAddresses].[Owner 1 Name], 
                 [edw].[dimPropertyOwnerAddresses].[Owner 1 Address], 
                 [edw].[dimRegionalHospitalDistrict].[Region Hospital District Code], 
                 [edw].[bridgeJurisdictionRegionalDistrict].[Regional District Code], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net General Land Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net General Building Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net General Total Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net Other Land Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net Other Building Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net Other Total Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net School Land Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net School Building Value], 
                 [edw].[factValuesByAssessmentCodePropertyClass].[Net School Total Value]
				 --,
				 --[PID_LST].LST
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

	---- INNER JOIN (SELECT A.[dimParcel_SK],
	----	(SELECT [dbo].[FNC_FORMAT_Property_ID_List](STUFF((SELECT '; ' + CAST(B.[PID] AS VARCHAR(50))
	----										FROM [edw].[dimParcel] AS B
	----										WHERE B.[dimParcel_SK] = A.[dimParcel_SK]
	----										ORDER BY B.[PID]
	----										FOR XML PATH('')), 1, 1, ''))) AS [LST]
	----FROM [edw].[dimParcel] AS A
	----WHERE A.[Roll Year] = 2017
	----GROUP BY A.[dimParcel_SK]) as [PID_LST]
 ----    ON [edw].[dimParcel].[dimParcel_SK] = [PID_LST].[dimParcel_SK]

WHERE [edw].[dimProperty].[Roll Year] = 2017;