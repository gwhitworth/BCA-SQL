DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SELECT [AR].[Area Code], 
       [Jurisdiction Code]
FROM edw.dimJurisdiction AS [JR]
     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].dimArea_SK = [AR].dimArea_SK
WHERE([JR].dimRollYear_SK = @p_RY)
     AND [Jurisdiction Code] > '199'
     AND [AR].[Area Code] = @p_AR
ORDER BY [AR].[Area Code], 
         [Jurisdiction Code];