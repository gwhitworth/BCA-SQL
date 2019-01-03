SELECT RC.[Roll Year], RC.[Cycle Number], AC.[Regional District],
	   tc.[Minor Tax Category Code],
	   TC.[Minor Tax Category],
       AC.[Minor Tax Code],
       AC.[Minor Tax],
      sum([Actual Building Value]) AS [Total Building Value], 
      sum([Actual Land Value]) AS [Total Land Value], 
      sum( [Actual Land Value] + [Actual Building Value]) AS [Total Actual Value]
FROM [edw].[FactActualAmounts] AS AA
	 JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [AA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimRollCycle] AS RC ON AA.dimRollCycle_SK = RC.dimRollCycle_SK
	 inner join edw.dimFolio as FO ON AA.dimFolio_SK = FO.dimFolio_SK  and FO.dimRollYear_SK = AA.dimRollYear_SK 
	 inner join [EDW].bridgeFolioMinorTax AS FM ON FO.dimFolio_SK = FM.dimFolio_SK
	 AND [AG].[dimJurisdiction_SK] = [FM].[dimJurisdiction_SK]
	 inner join [edw].[dimMinorTaxCategory] as TC ON FM.dimMinorTaxCategory_SK = tc.dimMinorTaxCategory_SK
	 INNER JOIN [edw].[dimMinorTaxCode] AS AC ON FM.dimMinorTaxCode_SK = ac.dimMinorTaxCode_SK
WHERE (RC.[Roll Year] = 2017)
	 and (RC.[Cycle Number] = -1)
	 and TC.[Minor Tax Category Code] = 'DE' AND ac.[Regional District Code] = '02'
	 --and AG.[Neighbourhood Code] = '302022'
	 --AND AA.[Current Cycle Flag] = 'Yes'	
group by RC.[Roll Year], RC.[Cycle Number], AC.[Regional District],
	   tc.[Minor Tax Category Code],
	   TC.[Minor Tax Category],
       AC.[Minor Tax Code],
       AC.[Minor Tax]
order by  RC.[Roll Year], RC.[Cycle Number], AC.[Regional District],
	   tc.[Minor Tax Category Code],
	   TC.[Minor Tax Category],
       AC.[Minor Tax Code],
       AC.[Minor Tax]
