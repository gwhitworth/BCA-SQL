DECLARE @p_PropertyKey INT
SET @p_PropertyKey = 4637151;
SELECT [Exempt Tax], 
       [pc].[Property Class], 
       [Actual Land Value] = SUM([Actual Land Value]), 
       [Actual Building Value] = SUM([Actual Building Value]), 
       [Actual Total Value] = SUM([Actual Total Value])
FROM
(
    SELECT [tec].[Exempt Tax], 
           [act].[dimPropertyClass_SK], 
           [AT].[Assessment Code], 
           [Actual Land Value], 
           [Actual Building Value], 
           [Actual Total Value]
    FROM
    (
        SELECT DISTINCT 
               [tec].[dimProperty_SK], 
               [tax].[Exempt Tax], 
               [tec].[dimPropertyClass_SK], 
               [dimAssessmentType_SK]
        FROM [EDW].[edw].[factPropertyExemptionByClass] [tec]
             INNER JOIN [edw].[edw].[dimTaxExemption] [tax]
             ON [tax].[dimTaxExemption_SK] = [tec].[dimTaxExemption_SK]
    ) [tec]
    INNER JOIN [edw].[edw].[factValuesByAssessmentCodePropertyClass] [act]
    ON [act].[dimPropertyClass_SK] = [tec].[dimPropertyClass_SK]
       AND [act].[dimProperty_SK] = [tec].[dimProperty_SK]
    INNER JOIN [edw].[dimAssessmentType] AS [AT]
    ON [AT].[dimAssessmentType_SK] = [act].[dimAssessmentType_SK]
    WHERE [tec].[dimProperty_SK] = @p_PropertyKey
          AND [act].[dimAssessmentType_SK] = [tec].[dimAssessmentType_SK]
) AS [DTL]
INNER JOIN [edw].[edw].[dimPropertyClass] [pc]
ON [pc].[dimPropertyClass_SK] = [DTL].[dimPropertyClass_SK]
GROUP BY [Exempt Tax], 
         [pc].[Property Class];