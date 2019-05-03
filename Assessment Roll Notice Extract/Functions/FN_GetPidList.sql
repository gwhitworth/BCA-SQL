SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF EXISTS(SELECT 1
FROM [sys].[objects]
WHERE [Name] = 'FN_GetPidList'
AND [Type] IN(N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[FN_GetPidList];
GO
-- =============================================
-- Author:		Gerry Whitworth
-- Create date: May 1, 2019
-- Description: Return number of Pids
-- =============================================
CREATE FUNCTION dbo.FN_GetPidList
(@List      VARCHAR(MAX), 
 @Delimiter VARCHAR(10), 
 @NumOfPids SMALLINT
)
RETURNS VARCHAR(MAX)
AS
     BEGIN
         -- Declare the return variable here
         DECLARE @ResultVar VARCHAR(MAX)= '';
         DECLARE @CNT SMALLINT= 1;
         DECLARE @PID VARCHAR(MAX);
         DECLARE MY_CURSOR CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY
         FOR SELECT Item
             FROM dbo.FT_SplitStrings_CTE(@List, @Delimiter);
         OPEN MY_CURSOR;
         FETCH NEXT FROM MY_CURSOR INTO @PID;
         WHILE @@FETCH_STATUS = 0
             BEGIN
                 IF @ResultVar = ''
                   SET @ResultVar = @PID;
                 ELSE
					SET @ResultVar+=' '+@PID;

                 SET @CNT+=1;
                 IF @CNT > @NumOfPids
					BREAK;

                 FETCH NEXT FROM MY_CURSOR INTO @PID;
             END;
         CLOSE MY_CURSOR;
         DEALLOCATE MY_CURSOR;
         RETURN  @ResultVar;
     END;
GO