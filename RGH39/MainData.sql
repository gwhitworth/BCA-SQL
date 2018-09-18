DECLARE @p_RY INT;
SET @p_RY = 2017;
DECLARE @p_RHD CHAR(2);
SET @p_RHD = '20';

SELECT [Region Hospital District Code]
FROM [EDW].[edw].[dimRegionalHospitalDistrict]
WHERE [Roll Year] = @p_RY
      AND [Region Hospital District Code] IN (@p_RHD)
ORDER BY [Region Hospital District Code];