  -- Drop the function if it already exists
  IF OBJECT_ID('INSTR', 'FN') IS NOT NULL
	DROP FUNCTION dbo.INSTR
  GO
/*********************************************************************************************************************
Function: INSTR

Purpose: User-defined function to implement Oracle INSTR in SQL Server

Parameter: @str VARCHAR(8000), @substr VARCHAR(255), @start INT, @occurrence INT

Return/result: Pos of Nth occurrence of string

Assumption: None

Modified History:
Version         Date		Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0				Nov 2018	original build		Gerry Whitworth
*********************************************************************************************************************/ 
CREATE FUNCTION dbo.INSTR (@str VARCHAR(8000), @substr VARCHAR(255), @start INT, @occurrence INT)
RETURNS INT
AS
BEGIN
DECLARE @found INT = @occurrence,
		@pos INT = @start;
 
WHILE 1=1 
BEGIN
	-- Find the next occurrence
	SET @pos = CHARINDEX(@substr, @str, @pos);
 
	-- Nothing found
	IF @pos IS NULL OR @pos = 0
		RETURN @pos;
 
	-- The required occurrence found
	IF @found = 1
		BREAK;
 
	-- Prepare to find another one occurrence
	SET @found = @found - 1;
	SET @pos = @pos + 1;
END
 
RETURN @pos;
END

