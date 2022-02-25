CREATE TABLE [dbo].[staging_workout_history]
(
[Date_Submitted] [nvarchar] (50) NOT NULL,
[Workout_Date] [nvarchar] (50) NOT NULL,
[Activity_Type] [nvarchar] (50) NOT NULL,
[Calories_Burned_kCal] [nvarchar] (50) NOT NULL,
[Distance_mi] [nvarchar] (50) NOT NULL,
[Workout_Time_seconds] [nvarchar] (50) NOT NULL,
[Avg_Pace_min_mi] [nvarchar] (50) NOT NULL,
[Max_Pace] [nvarchar] (50) NOT NULL,
[Avg_Speed_mi_h] [nvarchar] (50) NOT NULL,
[Max_Speed] [nvarchar] (50) NOT NULL,
[Avg_Heart_Rate] [nvarchar] (50) NULL,
[Steps] [nvarchar] (50) NULL,
[Notes] [nvarchar] (250) NOT NULL,
[Source] [nvarchar] (250) NULL,
[Link] [nvarchar] (250) NOT NULL
)
GO
