SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
  CREATE VIEW [dbo].[SolarPowerTracker]
  AS
SELECT DATEFROMPARTS(spa.trackingyear, spa.trackingmonth, spa.trackingday) AS ProductionDate
     , spa.actual_daily AS Actual, spe.estimate_daily AS Estimate
 FROM dbo.SolarPowerActual AS spa
  INNER JOIN dbo.SolarPowerEstimate AS spe
  ON spe.trackingmonth = spa.trackingmonth
GO
