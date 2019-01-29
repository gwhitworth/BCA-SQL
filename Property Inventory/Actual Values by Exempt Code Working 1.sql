DECLARE @p_PropertyKey INT;
SET @p_PropertyKey = 4637151;

SELECT [Exempt Tax], 
       [pc].[Property Class], 
       [Actual Land Value] = SUM([Actual Land Value]), 
       [Actual Building Value] = SUM([Actual Building Value]), 
       [Actual Total Value] = SUM([Actual Total Value])
FROM
(
    SELECT DISTINCT 
           [tax].[Exempt Tax], 
           [act].[dimPropertyClass_SK], 
           [AT].[Assessment Code], 
           (CASE [Assessment Code]
                WHEN '01'
                THEN [Actual Land Value]
                ELSE 0
            END) AS [Actual Land Value], 
           (CASE [Assessment Code]
                WHEN '02'
                THEN [Actual Building Value]
                ELSE 0
            END) [Actual Building Value], 
           [Actual Total Value]
    FROM [EDW].[edw].[factPropertyExemptionByClass] [tec]
         INNER JOIN [edw].[edw].[dimTaxExemption] [tax]
         ON [tax].[dimTaxExemption_SK] = [tec].[dimTaxExemption_SK]
         INNER JOIN [edw].[edw].[factValuesByAssessmentCodePropertyClass] [act]
         ON [act].[dimPropertyClass_SK] = [tec].[dimPropertyClass_SK]
            AND [act].[dimProperty_SK] = [tec].[dimProperty_SK]
         INNER JOIN [edw].[dimAssessmentType] AS [AT]
         ON [AT].[dimAssessmentType_SK] = [act].[dimAssessmentType_SK]
    WHERE [tec].[dimProperty_SK] = @p_PropertyKey 
	AND (([AT].[Assessment Code] = '01' AND [tax].[Exempt Tax] like '%LAND%') 
	OR ([AT].[Assessment Code] = '02' AND [tax].[Exempt Tax] like '%PROPERTY%'))
) AS [DTL]
INNER JOIN [edw].[edw].[dimPropertyClass] [pc]
ON [pc].[dimPropertyClass_SK] = [DTL].[dimPropertyClass_SK]
GROUP BY [Exempt Tax], 
         [pc].[Property Class];