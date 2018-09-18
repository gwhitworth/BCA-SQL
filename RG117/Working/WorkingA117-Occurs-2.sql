SELECT  [Jurisdiction Code]
		,CASE WHEN CHARINDEX('Rural',[JurisdictionRural]) > 0
            THEN [JurisdictionRural]
        ELSE
            [Jurisdiction]
		END AS [Jurisdiction]
	   ,[Res Occur]
	   ,[Non Res Occur]

FROM
	(SELECT [Jurisdiction Code]
			,[Jurisdiction]
			,[JurisdictionRural]
			,SUM([Res Occur]) AS [Res Occur]
			,SUM([Non Res Occur]) AS [Non Res Occur]
		FROM (SELECT AG.[Jurisdiction Code]
					,AG.[Jurisdiction Code] + ' ' +  AG.[Jurisdiction Type Desc] + ' of ' + AG.[Jurisdiction Desc] AS [Jurisdiction]
					,AG.[Jurisdiction Code] + ' ' + AG.[Jurisdiction Desc] AS [JurisdictionRural]
					,PC.[Property Class Code]
					,PC.[Property Sub Class Code]
					,COUNT(DISTINCT CASE WHEN PC.[Property Class Code] = '01'AND AV.[Assessment Code] <> '01' THEN  AV.dimFolio_SK END) AS [Res Occur]
					,COUNT(DISTINCT CASE WHEN PC.[Property Class Code] <> '01' AND AV.[Assessment Code] = '01' THEN AV.dimFolio_SK END) AS [Non Res Occur]
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
				WHERE SD.[Roll Year] = 2018
					  AND SD.[School  District Code] = '05'
					  AND FO.[Folio Status Code] ='01'
					  AND AG.[Roll Category Code] = '1'
				GROUP BY AG.[Jurisdiction Code]
						,AG.[Jurisdiction Code] + ' ' +  AG.[Jurisdiction Type Desc] + ' of ' + AG.[Jurisdiction Desc]
						,AG.[Jurisdiction Code] + ' ' + AG.[Jurisdiction Desc]
						,PC.[Property Class Code]
						,PC.[Property Sub Class Code]
			) AS [Occurances]
	GROUP BY [Jurisdiction Code], [Jurisdiction],[JurisdictionRural]

	) AS [JO]
ORDER BY [Jurisdiction Code]