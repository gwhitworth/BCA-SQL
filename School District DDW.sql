
DECLARE @RptType char(2)
SET @RptType = 'SD'


IF @RptType = 'SD'
BEGIN
	SELECT  DISTINCT [School  District Code], [School District],[RowSortOrder]
		FROM  [edw].[dimSchoolDistrict]
		WHERE [School  District Code] NOT IN ('NA', 'NS', 'UNK')
	ORDER BY [RowSortOrder]
END
ELSE
BEGIN
SELECT '-99' AS [School  District Code]
	    ,'N/A' AS [School District]
END

--SELECT DISTINCT NULL AS [School  District Code], 'Select All' AS [School District]
--UNION ALL
--SELECT DISTINCT [School  District Code], [School District]
--FROM            edw.dimSchoolDistrict
--WHERE        ([School  District Code] NOT IN ('NA', 'NS', 'UNK'))
--ORDER BY [School District]