/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [dimFolio_SK], 
       [Property Class Code], 
       [Gross General Value],
	   [Gross Other Value],
	   [Gross School Value]
FROM [EDW].[edw].[FactAssessedValue]
WHERE [dimFolio_SK] = 4166936
      AND [Cycle Number] = -1
	  AND [Assessment Code] = '01'
ORDER BY [Property Class Code];

;WITH CTE_Rank AS
    (
    SELECT [dimFolio_SK],[Property Class Code]
        , [Gross General Value],
	   [Gross Other Value],
	   [Gross School Value] 
        --, sCode = 'sCode' + CAST(DENSE_RANK() OVER (PARTITION BY [dimFolio_SK] ORDER BY [Property Class Code]) AS VARCHAR(100))
		, sCodeGG = 'sCode' + [Property Class Code] + 'GG'
		, sCodeGO = 'sCode' + [Property Class Code] + 'GO'
		, sCodeGS = 'sCode' + [Property Class Code] + 'GOS'

    FROM [EDW].[edw].[FactAssessedValue]
	WHERE [dimFolio_SK] = 4166936
      AND [Cycle Number] = -1
	  AND [Assessment Code] = '01'
    )
SELECT [dimFolio_SK] 
	, sCodeGG01 = MAX(sCode01GG)
	, sCodeGG02 = MAX(sCode02GG)
	, sCodeGG03 = MAX(sCode03GG)
    , sCodeGG04 = MAX(sCode04GG)
	, sCodeGG05 = MAX(sCode05GG)
	, sCodeGG07 = MAX(sCode06GG)
	, sCodeGG06 = MAX(sCode07GG)
	, sCodeGG08 = MAX(sCode08GG)

	, sCodeGO01 = MAX(sCode01GO)
	, sCodeGO02 = MAX(sCode02GO)
	, sCodeGO03 = MAX(sCode03GO)
    , sCodeGO04 = MAX(sCode04GO)
	, sCodeGO05 = MAX(sCode05GO)
	, sCodeGO07 = MAX(sCode06GO)
	, sCodeGO06 = MAX(sCode07GO)
	, sCodeGO08 = MAX(sCode08GO)

	, sCodeGS01 = MAX(sCode01GS)
	, sCodeGS02 = MAX(sCode02GS)
	, sCodeGS03 = MAX(sCode03GS)
    , sCodeGS04 = MAX(sCode04GS)
	, sCodeGS05 = MAX(sCode05GS)
	, sCodeGS07 = MAX(sCode06GS)
	, sCodeGS06 = MAX(sCode07GS)
	, sCodeGS08 = MAX(sCode08GS)
FROM CTE_Rank AS R
    PIVOT(MAX([Gross General Value]) FOR sCodeGG IN ([sCode01GG], [sCode02GG], [sCode03GG], [sCode04GG], [sCode05GG],[sCode06GG], [sCode07GG], [sCode08GG])) AS GenTotals
	PIVOT(MAX([Gross Other Value]) FOR sCodeGO IN ([sCode01GO], [sCode02GO], [sCode03GO], [sCode04GO], [sCode05GO],[sCode06GO], [sCode07GO], [sCode08GO])) AS OthTotals
	PIVOT(MAX([Gross School Value]) FOR sCodeGS IN ([sCode01GS], [sCode02GS], [sCode03GS], [sCode04GS], [sCode05GS],[sCode06GS], [sCode07GS], [sCode08GS])) AS OthTotals
GROUP BY [dimFolio_SK]