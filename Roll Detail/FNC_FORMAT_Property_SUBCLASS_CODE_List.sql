DROP FUNCTION IF EXISTS [dbo].[FNC_FORMAT_Property_SUBCLASS_CODE_List]
GO
/*********************************************************************************************************************
Function: dbo.FNC_FORMAT_Property_SUBCLASS_CODE_List

Purpose: This is a common function to format owner address

Parameter:	@p_PCODE_List

Return/result: Prop Code Lst

Assumption: none

Modified History:
Author.....................Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0........................Jan 2019......original build       Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_FORMAT_Property_SUBCLASS_CODE_List]
(
	@p_PCODE_List varchar(max)
)
RETURNS varchar(max)
AS
BEGIN
	DECLARE @rtnValue	varchar(max) = ''
	DECLARE @list varchar(8000)
	DECLARE @pos INT
	DECLARE @len INT
	DECLARE @value varchar(8000)

	SET @list = @p_PCODE_List

	SET @pos = 0
	SET @len = 0
	IF CHARINDEX(';', @list, @pos+1) > 0
	BEGIN
	WHILE CHARINDEX(';', @list, @pos+1)>0
		BEGIN
			SET @len = CHARINDEX(';', @list, @pos+1) - @pos
			SET @value = SUBSTRING(@list, @pos, @len)
            
			SET @rtnValue = @rtnValue + ' ' + @value
			SET @pos = CHARINDEX(';', @list, @pos+@len) +1
		END
	END
	ELSE
	BEGIN
		IF @list IS NOT NULL AND LEN(@list) > 0 --Only One PCODE for the folio
			SET @rtnValue =  + ' ' + @list
	END
	IF @@ERROR <> 0
	BEGIN
		RETURN NULL
	END

	RETURN @rtnValue
END