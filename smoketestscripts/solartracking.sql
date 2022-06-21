-- SELECT spt.ProductionDate, spt.Actual, spt.Estimate FROM dbo.SolarPowerTracker AS spt

/*load

truncate table dbo.SolarStaging

INSERT dbo.SolarPowerActual
  (trackingyear, trackingmonth, trackingday, actual_daily)
SELECT 
YEAR(ss.[Time])
, MONTH(ss.[Time])
, DAY(ss.[Time])
, CAST( ss.System_Production_Wh AS NUMERIC(10,4)) / 1000
FROM dbo.SolarStaging AS ss


select * from solarpowerestimate
SELECT * FROM dbo.SolarStaging AS ss

*/
--DELETE dbo.SolarPowerActual WHERE actual_daily = 0
-- select trackingmonth, estimate_month, estimate_daily from solarpowerestimate
-- current day
-- select top 10 * from solarpoweractual order by trackingyear, trackingmonth desc, trackingday desc
-- UPDATE dbo.SolarPowerActual SET trackingday= 8 WHERE TrackingKey = 1126

/*
INSERT dbo.SolarPowerActual
  (trackingyear, trackingmonth, trackingday, actual_daily)
VALUES
  (2022, 6, 20, 70.08)


*/

-- running total
SELECT
  spt.ProductionDate
, spt.Actual DailyActual_KW
, spt.Estimate DailyEstimate_KW
, SUM (spt.Actual) OVER (PARTITION BY
                           YEAR (spt.ProductionDate)
                         , MONTH (spt.ProductionDate)
                         ORDER BY DAY (spt.ProductionDate)) AS CurrentMonthProduction_KW
, SUM (spt.Estimate) OVER (PARTITION BY
                             YEAR (spt.ProductionDate)
                           , MONTH (spt.ProductionDate)
                           ORDER BY DAY (spt.ProductionDate)) AS CurrentMonthEstimate_KW
, spt.Actual - spt.Estimate AS PowerSurplusDay_KW
, SUM (spt.Actual) OVER (PARTITION BY
                           YEAR (spt.ProductionDate)
                         , MONTH (spt.ProductionDate)
                         ORDER BY DAY (spt.ProductionDate)) - SUM (spt.Estimate) OVER (PARTITION BY
                                                                                         YEAR (spt.ProductionDate)
                                                                                       , MONTH (spt.ProductionDate)
                                                                                       ORDER BY DAY (spt.ProductionDate)) CurrentMonthSurplus_KW
, (SUM (spt.Actual) OVER (PARTITION BY
                           YEAR (spt.ProductionDate)
                         , MONTH (spt.ProductionDate)
                         ORDER BY DAY (spt.ProductionDate)) - SUM (spt.Estimate) OVER (PARTITION BY
                                                                                         YEAR (spt.ProductionDate)
                                                                                       , MONTH (spt.ProductionDate)
                                                                                       ORDER BY DAY (spt.ProductionDate)) 
 ) / (spt.Estimate) DaysOfSurplus
FROM dbo.SolarPowerTracker AS spt
ORDER BY spt.ProductionDate desc;
