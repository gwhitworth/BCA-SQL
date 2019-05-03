SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF EXISTS (SELECT 1 FROM sys.objects 
           WHERE Name = 'FT_SplitStrings_CTE'
             AND Type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))

    DROP FUNCTION dbo.FT_SplitStrings_CTE;
GO
-- =============================================
-- Author:		Gerry Whitworth
-- Create date: May 1, 2019
-- Description: Split by delimiter and return table of values
-- =============================================
CREATE FUNCTION dbo.FT_SplitStrings_CTE
(
   @List       VARCHAR(MAX),
   @Delimiter  VARCHAR(10)
)
RETURNS @Items TABLE (Item NVARCHAR(20))
WITH SCHEMABINDING
AS
BEGIN
   DECLARE @ll INT = LEN(@List) + 1, @ld INT = LEN(@Delimiter);
 
   WITH a AS
   (
       SELECT
           [start] = 1,
           [end]   = COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, 1), 0), @ll),
           [value] = SUBSTRING(@List, 1, 
                     COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, 1), 0), @ll) - 1)
       UNION ALL
       SELECT
           [start] = CONVERT(INT, [end]) + @ld,
           [end]   = COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, [end] + @ld), 0), @ll),
           [value] = SUBSTRING(@List, [end] + @ld, 
                     COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, [end] + @ld), 0), @ll)-[end]-@ld)
       FROM a
       WHERE [end] < @ll
   )
   INSERT @Items SELECT [value]
   FROM a
   WHERE LEN([value]) > 0
   OPTION (MAXRECURSION 0);
 
   RETURN;
END
GO