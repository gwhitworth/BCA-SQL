
SELECT AG.[Jurisdiction Code]
	   ,SUM(CASE WHEN PC.[Property Class Code] = '01' AND AV.[Assessment Code] = '01' THEN AV.[Net School Value] END) AS [Res Net Land]
	   ,SUM(CASE WHEN PC.[Property Class Code] = '01'AND AV.[Assessment Code] <> '01' THEN AV.[Net School Value] END) AS [Res Net Impr]
	   ,SUM(CASE WHEN PC.[Property Class Code] <> '01' AND AV.[Assessment Code] = '01' THEN AV.[Net School Value] END) AS [Non Res Net Land]
	   ,SUM(CASE WHEN PC.[Property Class Code] <> '01' AND AV.[Assessment Code] <> '01' THEN AV.[Net School Value] END) AS [Non Res Net Impr]
	FROM edw.FactAssessedValue AS AV 
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
	WHERE 
			SD.[Roll Year] = 2018
			AND SD.[School  District Code] = '05'
			AND FO.[Folio Status Code] ='01'
			AND AG.[Roll Category Code] = '1'
	GROUP BY AG.[Jurisdiction Code]
	ORDER BY AG.[Jurisdiction Code]
	
