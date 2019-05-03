SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--FN = Scalar Function
IF object_id(N'fx_AssessmentRollHeader', N'FN') IS NOT NULL
    DROP FUNCTION dbo.fx_AssessmentRollHeader
GO
-- =============================================
-- Author:		Gerry Whitworth
-- Create date: April 30, 2019
-- Description:	Returns Assessment Roll Header
-- =============================================
CREATE FUNCTION dbo.fx_AssessmentRollHeader(@RptId CHAR(8),@RunName VARCHAR(30), @RunId VARCHAR(30))
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @ResultVar VARCHAR(max) = @RptId;
	DECLARE @SpaceNum SMALLINT = 0;
	DECLARE @RunLogo CHAR(6) = SPACE(6);
	DECLARE @Filler CHAR(6) = SPACE(6);
	DECLARE @Today DATETIME = GETDATE();
	
	SET @ResultVar += LEFT(@RunName + SPACE(30-LEN(@RunName)), 30);
	SET @ResultVar += @RunLogo;
	SET @ResultVar += @Filler; 
	SET @ResultVar += FORMAT(@Today, 'yyyyMMddhhmmss');
	SET @ResultVar += LEFT(@RunId + SPACE(30-LEN(@RunId)), 30);
	SET @ResultVar += '00010002000300040005000600070008000900100011001200130014001500160017001800190020002100220023002400250026002700280029003000310032003300340035003600370038003900400041004200430044004500460047004800490050005100520053005400550056005700580059006000610062006300640065006600670068006900700071007200730074007500760077007800790080008100820083008400850086008700880089009000910092009300940095009600970098009901000101010201030104010501060107010801090110011101120113011401150116011701180119012001210122012301240125012601270128012901300131013201330134013501360137013801390140014101420143014401450146014701480149015001510152015301540155015601570158015901600161016201630164016501660167016801690170017101720173017401750176017701780179018001810182018301840185018601870188018901900191019201930194019501960197019801990200020102020203020402050206020702080209021002110212021302140215021602170218021902200221022202230224022502260227022802290230023102320233023402350236023702380239024002410242024302440245024602470248024902500251025202530254025502560257025802590260026102620263026402650266026702680269027002710272027302740275027602770278027902800281028202830284028502860287028802890290029102920293029402950296029702980299030003010302030303040305030603070308030903100311031203130314031503160317031803190320032103220323032403250326032703280329033003310332033303340335033603370338033903400341034203430344034503460347034803490350035103520353035403550356035703580359036003610362036303640365036603670368036903700371037203730374037503760377037803790380038103820383038403850386038703880389039003910392039303940395039603970398039904000401040204030404040504060407040804090410041104120413041404150416041704180419042004210422042304240425042604270428042904300431043204330434043504360437043804390440044104420443044404450446044704480449045004510452045304540455045604570458045904600461046204630464046504660467046804690470047104720473047404750476047704780479048004810482048304840485048604870488048904900491049204930494049504960497049804990500';
	SET @ResultVar += CHAR(13)+CHAR(10);
	RETURN @ResultVar;
END
GO

