CREATE TABLE [dbo].[FlightStaging]
(
[FlightKey] [int] NOT NULL IDENTITY(1, 1),
[FlightDate] [smalldatetime] NULL,
[ActivityType] [varchar] (50) NULL,
[FlightDescription] [varchar] (300) NULL,
[PQM] [smallint] NULL,
[PQS] [numeric] (4, 1) NULL,
[PQD] [smallint] NULL,
[AwardMiles] [int] NULL
)
GO
ALTER TABLE [dbo].[FlightStaging] ADD CONSTRAINT [FlightStagingPK] PRIMARY KEY CLUSTERED ([FlightKey])
GO
