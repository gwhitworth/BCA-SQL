SELECT JR.[Jurisdiction Code] + ' ' +LEFT(JR.[Jurisdiction Desc],CHARINDEX(' (',JR.[Jurisdiction Desc])) AS [Jurisdiction]
		,COUNT(DISTINCT AV.dimFolio_SK) AS Occurs
FROM edw.FactAssessedValue AV 
	 INNER JOIN edw.dimPropertyClass AS PC 
	    ON AV.dimPropertyClass_SK = PC.dimPropertyClass_SK 
     INNER JOIN edw.dimAssessmentGeography AS AG 
	    ON AV.dimAssessmentGeography_SK = AG.dimAssessmentGeography_SK
	 INNER JOIN [edw].[dimJurisdiction] AS JR
		ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK

	 INNER JOIN [edw].[dimJurisdictionType] AS JT
		ON JT.dimJurisdictionType_SK = JT.dimJurisdictionType_SK

	 INNER JOIN [edw].[dimSchoolDistrict] AS SD
		ON SD.[dimJurisdiction_SK] = JR.[dimJurisdiction_SK]
	 INNER JOIN [edw].[dimArea] AS AR
		ON JR.dimArea_SK = AR.dimArea_SK
	 INNER JOIN [edw].[dimFolio] AS FO
		ON FO.dimFolio_SK = AV.dimFolio_SK

WHERE PC.[Property Class Code] = '01'
	  AND SD.[Roll Year] = 2018
      AND SD.[School  District Code] = '05'
	  AND FO.[Folio Status Code] ='01'
	  AND AG.[Roll Category Code] = '1'
	  AND JR.[Jurisdiction Code] = '205'
	  
GROUP BY JR.[Jurisdiction Code] + ' ' +LEFT(JR.[Jurisdiction Desc],CHARINDEX(' (',JR.[Jurisdiction Desc]))
ORDER BY JR.[Jurisdiction Code] + ' ' +LEFT(JR.[Jurisdiction Desc],CHARINDEX(' (',JR.[Jurisdiction Desc]))


SELECT JR.[Jurisdiction Code] + ' ' +  [Jurisdiction Type Desc] + ' ' +LEFT(JR.[Jurisdiction Desc],CHARINDEX(' (',JR.[Jurisdiction Desc])) AS [Jurisdiction]
		,COUNT(DISTINCT AV.dimFolio_SK) AS Occurs


FROM edw.FactAssessedValue AV 
	 INNER JOIN edw.dimPropertyClass AS PC 
	    ON AV.dimPropertyClass_SK = PC.dimPropertyClass_SK 
     INNER JOIN edw.dimAssessmentGeography AS AG 
	    ON AV.dimAssessmentGeography_SK = AG.dimAssessmentGeography_SK
	 INNER JOIN [edw].[dimJurisdiction] AS JR
		ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
	 INNER JOIN [edw].[dimSchoolDistrict] AS SD
		ON SD.[dimJurisdiction_SK] = JR.[dimJurisdiction_SK]
	 INNER JOIN [edw].[dimArea] AS AR
		ON JR.dimArea_SK = AR.dimArea_SK
	 INNER JOIN [edw].[dimFolio] AS FO
		ON FO.dimFolio_SK = AV.dimFolio_SK

WHERE PC.[Property Class Code] = '01'
	  AND SD.[Roll Year] = 2018
      AND SD.[School  District Code] = '05'
	  AND FO.[Folio Status Code] ='01'
	  AND AG.[Roll Category Code] = '1'
	  AND JR.[Jurisdiction Code] = '205'
	  
GROUP BY JR.[Jurisdiction Code] + ' ' +  [Jurisdiction Type Desc] + ' ' +LEFT(JR.[Jurisdiction Desc],CHARINDEX(' (',JR.[Jurisdiction Desc]))
ORDER BY JR.[Jurisdiction Code] + ' ' +  [Jurisdiction Type Desc] + ' ' +LEFT(JR.[Jurisdiction Desc],CHARINDEX(' (',JR.[Jurisdiction Desc]))



--SELECT JR.Jurisdiction
--		,PC.[Property Class Code]
--		,PC.[Property Sub Class Code]
--		,COUNT(DISTINCT AV.dimFolio_SK) AS Occurs


--FROM edw.FactAssessedValue AV 
--	 INNER JOIN edw.dimPropertyClass AS PC 
--	    ON AV.dimPropertyClass_SK = PC.dimPropertyClass_SK 
--     INNER JOIN edw.dimAssessmentGeography AS AG 
--	    ON AV.dimAssessmentGeography_SK = AG.dimAssessmentGeography_SK
--	 INNER JOIN [edw].[dimJurisdiction] AS JR
--		ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
--	 INNER JOIN [edw].[dimSchoolDistrict] AS SD
--		ON SD.[dimJurisdiction_SK] = JR.[dimJurisdiction_SK]
--	INNER JOIN [edw].[dimArea] AS AR
--		ON JR.dimArea_SK = AR.dimArea_SK
--	INNER JOIN [edw].[dimFolio] AS FO
--		ON FO.dimFolio_SK = AV.dimFolio_SK

--WHERE PC.[Property Class Code] = '01'
--	  AND SD.[Roll Year] = 2018
--      AND SD.[School  District Code] = '05'
--	  AND FO.[Folio Status Code] ='01'
--	  AND AG.[Roll Category Code] = '1'
--	  AND JR.[Jurisdiction Code] = '205'
	  
--GROUP BY JR.Jurisdiction,PC.[Property Class Code],PC.[Property Sub Class Code]
--ORDER BY JR.Jurisdiction,PC.[Property Class Code],PC.[Property Sub Class Code]