DECLARE @p_RY int
DECLARE @p_CN int
SET @p_RY = 2018
SET @p_CN = 12

SELECT DISTINCT SD.[School  District Code]  AS [School District Code]
	   ,SD.[School District Desc] AS [School District]
	   ,'AA' + AR.[Area Code] AS [Area]
	   ,[JurisdictionFormatted]
	   ,[Res Occur]
	   ,[Res Net Land]
	   ,[Res Net Impr]
	   ,[Non Res Occur]
	   ,[Non Res Net Land]
	   ,[Non Res Net Impr]
	   ,[Folios]

FROM
(SELECT  [Jurisdiction Code]
		,CASE WHEN CHARINDEX('Rural',[JurisdictionRural]) > 0
            THEN [JurisdictionRural]
        ELSE
            [Jurisdiction]
		END AS [JurisdictionFormatted]
	   ,[Res Occur]
	   ,[Non Res Occur]
	   ,[Folios]

FROM
	(SELECT [Jurisdiction Code]
			,[Jurisdiction]
			,[JurisdictionRural]
			,SUM([Res Occur]) AS [Res Occur]
			,SUM([Non Res Occur]) AS [Non Res Occur]
			,SUM([Folios]) AS [Folios]
		FROM (SELECT AG.[Jurisdiction Code]
					,AG.[Jurisdiction Code] + ' ' +  AG.[Jurisdiction Type Desc] + ' of ' + AG.[Jurisdiction Desc] AS [Jurisdiction]
					,AG.[Jurisdiction Code] + ' ' + AG.[Jurisdiction Desc] AS [JurisdictionRural]
					,PC.[Property Class Code]
					,PC.[Property Sub Class Code]
					,COUNT(DISTINCT CASE WHEN PC.[Property Class Code] = '01'AND AV.[Assessment Code] <> '01' THEN  AV.dimFolio_SK END) AS [Res Occur]
					,COUNT(DISTINCT CASE WHEN PC.[Property Class Code] <> '01' AND AV.[Assessment Code] = '01' THEN AV.dimFolio_SK END) AS [Non Res Occur]
					,COUNT(DISTINCT CASE WHEN PC.[Property Class Code] = '01' THEN  AV.dimFolio_SK END) AS [Folios]
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
				WHERE SD.[Roll Year] = @p_RY

					  AND FO.[Folio Status Code] ='01'
					  AND AG.[Roll Category Code] = '1'
					  AND [AV].[Cycle Number] <= @p_CN
				GROUP BY AG.[Jurisdiction Code]
						,AG.[Jurisdiction Code] + ' ' +  AG.[Jurisdiction Type Desc] + ' of ' + AG.[Jurisdiction Desc]
						,AG.[Jurisdiction Code] + ' ' + AG.[Jurisdiction Desc]
						,PC.[Property Class Code]
						,PC.[Property Sub Class Code]
			) AS [Occurances]
	GROUP BY [Jurisdiction Code], [Jurisdiction],[JurisdictionRural]

	) AS [OCCURLIST]
) AS [OCCUR]
INNER JOIN
	(SELECT AG.[Jurisdiction Code]
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
				SD.[Roll Year] = @p_RY

				AND FO.[Folio Status Code] ='01'
				AND AG.[Roll Category Code] = '1'
				AND [AV].[Cycle Number] <= @p_CN
		GROUP BY AG.[Jurisdiction Code]
	) AS [NET] 
		ON [OCCUR].[Jurisdiction Code] = [NET].[Jurisdiction Code]
INNER JOIN [edw].[dimJurisdiction] AS JR
	ON [NET].[Jurisdiction Code] = JR.[Jurisdiction Code]
INNER JOIN [edw].[dimSchoolDistrict] AS SD
	ON SD.[dimJurisdiction_SK] = JR.[dimJurisdiction_SK]
INNER JOIN [edw].[dimArea] AS AR
	ON JR.dimArea_SK = AR.dimArea_SK
ORDER BY [School District Code],[School District],[Area],[JurisdictionFormatted]