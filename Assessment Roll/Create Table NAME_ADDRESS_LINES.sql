
/****** Object:  Table [dbo].[NAME_ADDRESS_LINES]    Script Date: 21-Jan-19 10:00:28 AM ******/
DROP TABLE [Reporting].[NAME_ADDRESS_LINES]
GO

/****** Object:  Table [dbo].[NAME_ADDRESS_LINES]    Script Date: 21-Jan-19 10:00:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Reporting].[NAME_ADDRESS_LINES](
	[PK] [int] IDENTITY(1,1) NOT NULL,
	[dimFolio_SK] [int] NOT NULL,
	[dimRollYear] [int] NOT NULL,
	[dimAddress_SK] [int] NOT NULL,
	[dimFolio_BK] [varchar](255) NULL,
	[dimAddress_BK] [binary](20) NULL,
	[NAME_LINE1] [varchar](500) NULL,
	[NAME_LINE2] [varchar](500) NULL,
	[ADRS_LINE1] [varchar](500) NULL,
	[ADRS_LINE2] [varchar](500) NULL,
	[ADRS_LINE3] [varchar](500) NULL,
	[ADRS_LINE4] [varchar](500) NULL,
	[ADRS_LINE5] [varchar](500) NULL,
	[DateTimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_NAME_ADDRESS_LINES2] PRIMARY KEY CLUSTERED 
(
	[PK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Reporting].[NAME_ADDRESS_LINES] ADD  CONSTRAINT [DF_NAME_ADDRESS_LINES_DateTimeStamp2]  DEFAULT (getdate()) FOR [DateTimeStamp]
GO


