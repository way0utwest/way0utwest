CREATE TABLE [dbo].[SolarPowerActual]
(
[TrackingKey] [int] NOT NULL IDENTITY(1, 1),
[trackingyear] [smallint] NULL,
[trackingmonth] [tinyint] NULL,
[trackingday] [tinyint] NULL,
[actual_daily] [numeric] (10, 4) NULL
)
GO
ALTER TABLE [dbo].[SolarPowerActual] ADD CONSTRAINT [SolarPowerActualPK] PRIMARY KEY CLUSTERED ([TrackingKey])
GO
CREATE NONCLUSTERED INDEX [SolarPowerActual_Month] ON [dbo].[SolarPowerActual] ([trackingmonth])
GO
