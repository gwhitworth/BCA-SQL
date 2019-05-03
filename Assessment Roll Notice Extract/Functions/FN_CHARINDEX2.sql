SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF OBJECT_ID(N'FN_CHARINDEX2', N'FN') IS NOT NULL
    DROP FUNCTION dbo.FN_CHARINDEX2;
GO
-- =============================================
-- Author:		Gerry Whitworth
-- Create date: May 1, 2019
-- Description: Find the Nth Occurrence of a Character in a String
-- Example:
--          SELECT dbo.CHARINDEX2('a', 'abbabba', 3)
--           returns the location of the third occurrence of 'a'
--           which is 7
-- =============================================
CREATE FUNCTION dbo.FN_CHARINDEX2
(@TargetStr   VARCHAR(MAX), 
 @SearchedStr VARCHAR(MAX), 
 @Occurrence  INT
)
RETURNS INT
AS
     BEGIN
         DECLARE @pos INT, @counter INT, @ret INT;
         SET @pos = CHARINDEX(@TargetStr, @SearchedStr);
         SET @counter = 1;
         IF @Occurrence = 1
             BEGIN
                 SET @ret = @pos;
             END;
             ELSE
             BEGIN
                 WHILE(@counter < @Occurrence)
                     BEGIN
                         SELECT @ret = CHARINDEX(@TargetStr, @SearchedStr, @pos+1);
                         SET @counter = @counter + 1;
                         SET @pos = @ret;
                     END;
             END;
		 --IF @ret < 1
			--SET @ret = LEN(@TargetStr)
         RETURN @ret;
     END;