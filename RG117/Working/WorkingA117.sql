SELECT  SD1.[School District]
	  , COUNT(ResNetLand.[Folio Number]) AS [Occurs]
	  , SUM(ResNetLand.[Net School Value]) AS [Net Land]


	  --, SUM(TBL2.[Assessed Value]) AS [Net Improvement]
	  
FROM [edw].[dimSchoolDistrict] AS SD1
INNER JOIN 
(SELECT SD.dimSchoolDistrict_SK
		,AV.[Folio Number]
		,AV.[Net School Value]
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

WHERE AV.[Assessment Code] = '01'
	  AND PC.[Property Class Code] = '01'
) AS ResNetLand
ON SD1.dimSchoolDistrict_SK = ResNetLand.dimSchoolDistrict_SK

WHERE SD1.[Roll Year] = 2018
      AND SD1.[School  District Code] = '05'

GROUP BY SD1.[School District]
ORDER BY SD1.[School District]

--SELECT  SD1.[School District]
--	  , COUNT(RegNetLand.[Net School Value]) AS [Occurs]
--	  , SUM(RegNetLand.[Net School Value]) AS [Net Land]
--	  --, SUM(TBL2.[Assessed Value]) AS [Net Improvement]
	  
--FROM [edw].[dimSchoolDistrict] AS SD1
--INNER JOIN 
--(SELECT SD.dimSchoolDistrict_SK
--		,AV.[Net School Value]
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

--WHERE AV.[Assessment Code] = '02'
--	  AND PC.[Property Class Code] = '01'
--) AS RegNetLand
--ON SD1.dimSchoolDistrict_SK = RegNetLand.dimSchoolDistrict_SK

--WHERE SD1.[Roll Year] = 2018
--      AND SD1.[School  District Code] = '05'

--GROUP BY SD1.[School District]
--ORDER BY SD1.[School District]

