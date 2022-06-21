CREATE TABLE [dbo].[SolarPowerEstimate]
(
[TrackingKey] [int] NOT NULL IDENTITY(1, 1),
[trackingmonth] [tinyint] NULL,
[estimate_month] [numeric] (6, 2) NULL,
[estimate_daily] [numeric] (4, 2) NULL
)
GO
ALTER TABLE [dbo].[SolarPowerEstimate] ADD CONSTRAINT [SolarPowerPK] PRIMARY KEY CLUSTERED ([TrackingKey])
GO
CREATE NONCLUSTERED INDEX [SolarPowerEstimate_Month] ON [dbo].[SolarPowerEstimate] ([estimate_month])
GO
