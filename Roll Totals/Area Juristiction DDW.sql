DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_JR = '213';
SET @p_JR = NULL;
SELECT [AR].[Area Code], 
       [Jurisdiction Code], 
       [Jurisdiction], 
       [Jurisdiction Desc]
FROM edw.dimJurisdiction AS [JR]
     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].dimArea_SK = [AR].dimArea_SK
WHERE([JR].dimRollYear_SK = @p_RY)
     AND [Jurisdiction Code] > '199'
     AND [AR].[Area Code] = @p_AR
UNION
SELECT @p_AR, 
       '000', 
       'N/A', 
       'N/A'
ORDER BY [AR].[Area Code], 
         [Jurisdiction Code];