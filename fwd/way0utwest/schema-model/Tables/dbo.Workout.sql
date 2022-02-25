CREATE TABLE [dbo].[Workout]
(
[WorkOutKey] [int] NOT NULL IDENTITY(1, 1),
[WorkDateDate] [date] NULL,
[ActivityGroup] [varchar] (100) NULL,
[WorkoutTitle] [varchar] (100) NULL,
[Calories] [int] NULL,
[Distance] [numeric] (10, 4) NULL,
[WorkoutTime_S] [int] NULL,
[WorkoutTime] [time] NULL,
[AvgPace_Min_Mile] [numeric] (10, 4) NULL,
[Max_Pace] [numeric] (10, 4) NULL,
[AvgSpeed_Mile_Hour] [numeric] (10, 4) NULL,
[Max_Speed] [numeric] (10, 4) NULL,
[Avg_HR] [smallint] NULL,
[Max_HR] [smallint] NULL,
[Steps] [int] NULL,
[Notes] [varchar] (500) NULL,
[DateUpdated] [datetime2] (3) NULL
)
GO
ALTER TABLE [dbo].[Workout] ADD CONSTRAINT [WorkoutPK] PRIMARY KEY CLUSTERED ([WorkOutKey])
GO
