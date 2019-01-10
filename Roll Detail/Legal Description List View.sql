
IF EXISTS(SELECT 1
FROM [sys].[views]
WHERE [name] = 'dimLegalDescrList'
AND [type] = 'v')
DROP VIEW [edw].[dimLegalDescrList];
GO
CREATE VIEW [edw].[dimLegalDescrList]
AS
     SELECT [FO].[dimFolio_SK], 
            [FO].[dimRollYear_SK], 
     (
         SELECT [dbo].[FNC_FORMAT_LEGAL]([FO].[Jurisdiction Code], [PA].[Parcel], LEN([PA].[Parcel]), [PA].[Lot], LEN([PA].[Lot]), [PA].[Strata Lot Number], LEN([PA].[Strata Lot Number]), [PA].[Block Number], LEN([PA].[Block Number]), [PA].[Sub Block], LEN([PA].[Sub Block]), [PA].[Plan Number], LEN([PA].[Plan Number]), [PA].[Suburban Lot Number], LEN([PA].[Suburban Lot Number]), '??part 1 NOT FOUND??', '??part 2 NOT FOUND??', '??part 2 NOT FOUND??', '??part 4 NOT FOUND??', LEN('??part 1 NOT FOUND??'+'??part 2 NOT FOUND??'+'??part 3 NOT FOUND??'+'??part 4 NOT FOUND??'), [PA].[District Lot], LEN([PA].[District Lot]), '??legal subdivision NOT FOUND??', LEN('??legal subdivision NOT FOUND??'), [PA].[Section], LEN([PA].[Section]), [PA].[Township Code], LEN([PA].[Township Code]), [PA].[Range], LEN([PA].[Range]), [PA].[Meridian], LEN([PA].[Meridian]), [PA].[BCA AO Group], LEN([PA].[BCA AO Group]), [PA].[Land District Code], LEN([PA].[Land District Code]), [PA].[Portion], LEN([PA].[Portion]), [PA].[Exception Plan], LEN([PA].[Exception Plan]), [PA].[Legal Text], LEN([PA].[Legal Text]), [PA].[Air Space Parcel], LEN([PA].[Air Space Parcel]), [PA].[Lease Licence Number], LEN([PA].[Lease Licence Number]), '??mf num NOT FOUND??', LEN('??mf num NOT FOUND??'), '??mhr num NOT FOUND??', LEN('??mhr num NOT FOUND??'), '??bay no NOT FOUND??', LEN('??bay no NOT FOUND??'), '??mobile park name NOT FOUND??', LEN('??mobile park name NOT FOUND??'), '??park folio id NOT FOUND??', LEN('??park folio id NOT FOUND??'), [PA].[Pid], 'PID List N/A', LEN([PA].[Pid]), '??nts block num NOT FOUND??', LEN('??nts block num NOT FOUND??'), '??nts exception NOT FOUND??', LEN('??nts exception NOT FOUND??'), '??nts map num NOT FOUND??', LEN('??nts map num NOT FOUND??'), [PA].[NTS Quarter], LEN([PA].[NTS Quarter]), [PA].[NTS Unit], LEN([PA].[NTS Unit]), [PA].[OGC Project Number], LEN([PA].[OGC Project Number]))
     ) AS [LST]
     FROM [edw].[dimParcel] AS [PA]
          INNER JOIN [edw].[bridgeParcelFolio] AS [PF]
          ON [PA].[dimParcel_SK] = [PF].[dimParcel_SK]
          INNER JOIN [edw].[dimFolio] AS [FO]
          ON [PF].[dimFolio_SK] = [FO].[dimFolio_SK];