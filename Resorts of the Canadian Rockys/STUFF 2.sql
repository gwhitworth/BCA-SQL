DECLARE @listStr VARCHAR(MAX)= '';
WITH T
     AS (SELECT DISTINCT 
                [A].[dimProperty_SK], 
                [A].[Property Class Code]
         FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] [A]
              INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                                   AND [AG].[Area Code] = '22'
                                                                   AND ([AG].[Neighbourhood Code] IN('701041', '718505'))
              INNER JOIN [edw].[dimManualClass] AS [MC] ON [A].[dimManualClass_SK] = [MC].[dimManualClass_SK]
                                                           AND (NOT([MC].[Manual Class Code] IN('C424', 'D424')))
              INNER JOIN [edw].[dimActualUse] AS [AU] ON [A].[dimActualUse_SK] = [AU].[dimActualUse_SK]
                                                         AND (NOT([AU].[Actual Use Code] IN('287', '040')))
         WHERE [A].[dimRollYear_SK] = 2018
         GROUP BY [A].[dimProperty_SK], 
                  [A].[Property Class Code])

     --Select @listStr = @listStr + Coalesce([Property Class Code]+ ', ','') from T
     --SELECT @listStr

     --SELECT [A].[dimProperty_SK], 
     --       STUFF(
     --(
     --    SELECT [Property Class Code]+' | '
     --    FROM [T] AS [B]
     --    WHERE [B].[dimProperty_SK] = [A].[dimProperty_SK] FOR XML PATH('')
     --), 1, 1, '') AS [listStr]
     --FROM [T] AS [A]
     --GROUP BY [A].[dimProperty_SK]
     --ORDER BY [A].[dimProperty_SK]


--SELECT [dimProperty_SK] FROM T

SELECT [dimProperty_SK],RIGHT([Property Class Code],LEN([Property Class Code])-1) AS [VALUE] FROM (
	SELECT [dimProperty_SK],(SELECT ',' + [Property Class Code] FROM T 
				  WHERE  [dimProperty_SK] = a.[dimProperty_SK] FOR xml path('')
				 ) [Property Class Code]
	FROM T a 
	GROUP  BY  [dimProperty_SK])X

--[dimProperty_SK]