SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[SolarPowerEstimate]'
GO
CREATE TABLE [dbo].[SolarPowerEstimate]
(
[TrackingKey] [int] NOT NULL IDENTITY(1, 1),
[trackingmonth] [tinyint] NULL,
[estimate_month] [numeric] (6, 2) NULL,
[estimate_daily] [numeric] (4, 2) NULL
)
GO
PRINT N'Creating primary key [SolarPowerPK] on [dbo].[SolarPowerEstimate]'
GO
ALTER TABLE [dbo].[SolarPowerEstimate] ADD CONSTRAINT [SolarPowerPK] PRIMARY KEY CLUSTERED ([TrackingKey])
GO
PRINT N'Creating index [SolarPowerEstimate_Month] on [dbo].[SolarPowerEstimate]'
GO
CREATE NONCLUSTERED INDEX [SolarPowerEstimate_Month] ON [dbo].[SolarPowerEstimate] ([estimate_month])
GO
PRINT N'Creating [dbo].[SolarPowerActual]'
GO
CREATE TABLE [dbo].[SolarPowerActual]
(
[TrackingKey] [int] NOT NULL IDENTITY(1, 1),
[trackingyear] [smallint] NULL,
[trackingmonth] [tinyint] NULL,
[trackingday] [tinyint] NULL,
[actual_daily] [numeric] (10, 4) NULL
)
GO
PRINT N'Creating primary key [SolarPowerActualPK] on [dbo].[SolarPowerActual]'
GO
ALTER TABLE [dbo].[SolarPowerActual] ADD CONSTRAINT [SolarPowerActualPK] PRIMARY KEY CLUSTERED ([TrackingKey])
GO
PRINT N'Creating index [SolarPowerActual_Month] on [dbo].[SolarPowerActual]'
GO
CREATE NONCLUSTERED INDEX [SolarPowerActual_Month] ON [dbo].[SolarPowerActual] ([trackingmonth])
GO
PRINT N'Creating [dbo].[SolarPowerTracker]'
GO
  CREATE VIEW [dbo].[SolarPowerTracker]
  AS
SELECT DATEFROMPARTS(spa.trackingyear, spa.trackingmonth, spa.trackingday) AS ProductionDate
     , spa.actual_daily AS Actual, spe.estimate_daily AS Estimate
 FROM dbo.SolarPowerActual AS spa
  INNER JOIN dbo.SolarPowerEstimate AS spe
  ON spe.trackingmonth = spa.trackingmonth
GO
PRINT N'Creating [dbo].[SolarStaging]'
GO
CREATE TABLE [dbo].[SolarStaging]
(
[Time] [date] NOT NULL,
[System_Production_Wh] [varchar] (50) NOT NULL
)
GO
