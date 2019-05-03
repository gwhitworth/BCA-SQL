IF EXISTS(SELECT 1
FROM [sys].[objects]
WHERE [Name] = 'FN_GetAllAddressLines'
AND [Type] IN(N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[FN_GetAllAddressLines];
GO
-- =============================================
-- Author:		Gerry Whitworth
-- Create date: May 2, 2019
-- Description: Return all address lines in a single string
--              by calling [FNC_FORMAT_ADDRESS] a set number of times
-- =============================================
CREATE FUNCTION [dbo].[FN_GetAllAddressLines]
(@p_City              VARCHAR(50), 
 @p_Country           VARCHAR(50), 
 @p_Freeform_Address  VARCHAR(500), 
 @p_Directional       VARCHAR(50)  = '', 
 @p_Postal_zip        VARCHAR(10), 
 @p_Province_State    VARCHAR(50), 
 @p_Street_Name       VARCHAR(50)  = '', 
 @p_Street_Number     VARCHAR(50)  = '', 
 @p_Street_Type       VARCHAR(50)  = '', 
 @p_Unit_Number       VARCHAR(50), 
 @p_Address_Floor     VARCHAR(50), 
 @p_Address_CO        VARCHAR(50), 
 @p_Address_Attention VARCHAR(50), 
 @p_Address_Site      VARCHAR(50), 
 @p_Address_Comp      VARCHAR(50), 
 @p_Address_Mod       VARCHAR(50), 
 @p_Address_Mod_Value VARCHAR(50), 
 @p_Address_Dim       VARCHAR(50), 
 @p_Address_Dim_Value VARCHAR(50)
)
RETURNS VARCHAR(MAX)
AS
     BEGIN
         DECLARE @ResultVar VARCHAR(MAX)= '';
         DECLARE @AddrLine VARCHAR(MAX)= '';
         DECLARE @Cnt [SMALLINT]= 1;
         WHILE @Cnt < 6
             BEGIN
                 SET @AddrLine = [dbo].[FNC_FORMAT_ADDRESS](@p_City, @p_Country, @p_Freeform_Address, @p_Directional, @p_Postal_zip, @p_Province_State, @p_Street_Name, @p_Street_Number, @p_Street_Type, @p_Unit_Number, @p_Address_Floor, @p_Address_CO, @p_Address_Attention, @p_Address_Site, @p_Address_Comp, @p_Address_Mod, @p_Address_Mod_Value, @p_Address_Dim, @p_Address_Dim_Value, 50, @Cnt);
                 SET @ResultVar+=ISNULL(@AddrLine, '')+SPACE(47-LEN(ISNULL(@AddrLine, '')));
                 SET @Cnt+=1;
             END;
         RETURN  @ResultVar;
     END;
GO