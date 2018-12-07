--SELECT TOP 1000 [dimFolio_SK], 
--                COUNT(*) AS [CNT]
--FROM [EDW].[edw].[FactActualValue]
--WHERE [Roll Year] = 2017 AND [dimFolio_SK] > 0
--GROUP BY [dimFolio_SK]
--HAVING COUNT(*) > 2
--ORDER BY [CNT] DESC
--SELECT *
--  FROM [EDW].[edw].[FactActualValue]
--  where [dimFolio_SK] = 4166936 and [Cycle Number] = -1
--  order by [Assessment Code], [Property Class Code]
--SELECT *
--FROM [EDW].[edw].[FactAssessedValue]
--where [dimFolio_SK] = 4166936 and [Cycle Number] = -1
--order by [Assessment Code], [Property Class Code], [Property Sub Class Code]

WITH FMT([dimFolio_SK], 
         [CAT], 
         [CODE],
		 [Gross Gen Val])
     AS (SELECT [dimFolio_SK], 
                [Property Class Code] AS [CAT], 
                [Property Sub Class Code] AS [CODE],
				[Gross General Value] AS [Gross Gen Val]
         FROM [edw].[FactAssessedValue]
         WHERE [dimFolio_SK] = 4166936 and [Cycle Number] = -1)
     SELECT [dimFolio_SK], 
            [04], 
            --[06], 
            --[08], 
            --[02],
			[Val]
     FROM
     (
         SELECT [dimFolio_SK], 
                [CAT], 
                [CODE],
				[Gross Gen Val]
         FROM [FMT]
     ) [C] PIVOT(MAX([CAT]) FOR [CAT] IN([04], 
                                          --[06], 
                                          --[08], 
                                          --[02],
										  [Val])) AS [PivotTable];



--select ratio = col,
--  [current ratio], [gearing ratio], [performance ratio], total
--from
--(
--  select ratio, col, value
--  from GRAND_TOTALS
--  cross apply
--  (
--    select 'result', cast(result as varchar(10)) union all
--    select 'score', cast(score as varchar(10)) union all
--    select 'grade', grade
--  ) c(col, value)
--) d
--pivot
--(
--  max(value)
--  for ratio in ([current ratio], [gearing ratio], [performance ratio], total)
--) piv;

--SELECT [dimFolio_SK], 
--       [Roll Year], 
--       [Cycle Number], 
--       [Roll Type], 
--       [Folio Number], 
--       [Folio Number Display], 
--       [Assessment Code], 
--       [Property Class Code], 
--       [Property Sub Class Code], 
--       [Gross General Value], 
--       [Gross Other Value], 
--       [Gross School Value], 
--       [Net General Value], 
--       [Net Other Value], 
--       [Net School Value], 
--       [General Exemptions Value], 
--       [Other Exemptions Value], 
--       [School Exemptions Value], 
--       [Assessed Value]
--FROM [EDW].[edw].[FactAssessedValue]
--WHERE [dimFolio_SK] = 4166936
--      AND [Cycle Number] = -1;