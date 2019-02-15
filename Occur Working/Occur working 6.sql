    DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
--DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
--SET @p_JR = '213';
	SELECT DISTINCT top 1000
           [FA].[dimFolio_SK], 
           [PC].[Property Class Code]
		   --, 
     --      (SELECT [Property Class Occurrence] FROM )  AS [Occurrence]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
		 INNER JOIN [edw].[dimRollCycle] AS [RC] ON [RC].dimRollCycle_SK = [FA].dimRollCycle_SK
    WHERE [fa].[dimRollYear_SK] = @p_RY
          AND [Cycle Number] = @p_CN
          AND [FA].[dimRollType_SK] = 11
          --AND ([Net Other Total Value] > 0)
          --AND [Net General Total Value] > 0
		  --AND ([Net Other Total Value] > 0
    --           OR [Net General Total Value] > 0)
    --      AND [RD].[Regional District Code] = @p_RD
    --      AND [MT].[Minor Tax Category Code] = 'SM'
    --      AND [MT].[Minor Tax Code] IN('01-36103B', '01-36203B', '01-40103A')
		  --AND [FA].[Current Cycle Flag] = 'Yes'
		  ORDER By  [FA].[dimFolio_SK], 
           [PC].[Property Class Code]