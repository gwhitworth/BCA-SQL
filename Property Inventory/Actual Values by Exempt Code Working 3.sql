DECLARE @p_PropertyKey int
SET @p_PropertyKey = 4637151;
SELECT distinct  [tax].[Exempt Tax], 
       [pc].[Property Class], 
       [Actual Land Value] = SUM([act].[Actual Land Value]), 
       [Actual Building Value] = SUM([act].[Actual Building Value]), 
       [Actual Total Value] = SUM([act].[Actual Total Value])
FROM [EDW].[edw].[factPropertyExemptionByClass] [tec]
     
	 INNER JOIN [edw].[edw].[dimTaxExemption] [tax]
     ON [tax].[dimTaxExemption_SK] = [tec].[dimTaxExemption_SK]
	 
	 INNER JOIN [edw].[edw].[dimPropertyClass] [pc]
     ON [pc].[dimPropertyClass_SK] = [tec].[dimPropertyClass_SK] AND [Property Sub Class Code] IS NULL
     
	 INNER JOIN [edw].[edw].[factValuesByAssessmentCodePropertyClass] [act]
     ON [act].[dimPropertyClass_SK] = [tec].[dimPropertyClass_SK]
        AND [act].[dimProperty_SK] = [tec].[dimProperty_SK]

WHERE [tec].[dimProperty_SK] = @p_PropertyKey
GROUP BY [tax].[Exempt Tax], 
         [pc].[Property Class];



SELECT distinct  [tax].[Exempt Tax], 
[pc].[dimPropertyClass_SK],
       [pc].[Property Class], [act].dimRollYear_SK,[tec].[dimTaxExemption_SK]
       --[Actual Land Value] = SUM([act].[Actual Land Value]), 
       --[Actual Building Value] = SUM([act].[Actual Building Value]), 
       --[Actual Total Value] = SUM([act].[Actual Total Value])
       [Actual Land Value],
       [Actual Building Value],
       [Actual Total Value]


FROM [EDW].[edw].[factPropertyExemptionByClass] [tec]
     
	 INNER JOIN [edw].[edw].[dimTaxExemption] [tax]
     ON [tax].[dimTaxExemption_SK] = [tec].[dimTaxExemption_SK]
	 
	 INNER JOIN [edw].[edw].[dimPropertyClass] [pc]
     ON [pc].[dimPropertyClass_SK] = [tec].[dimPropertyClass_SK]
     
	 INNER JOIN [edw].[edw].[factValuesByAssessmentCodePropertyClass] [act]
     ON [act].[dimPropertyClass_SK] = [tec].[dimPropertyClass_SK]
        AND [act].[dimProperty_SK] = [tec].[dimProperty_SK]

WHERE [tec].[dimProperty_SK] = @p_PropertyKey AND [act].dimRollYear_SK = 2017
--GROUP BY [tax].[Exempt Tax], 
--         [pc].[Property Class];
