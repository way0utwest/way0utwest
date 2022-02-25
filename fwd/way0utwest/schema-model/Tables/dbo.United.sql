CREATE TABLE [dbo].[United]
(
[Transaction_Date] [date] NOT NULL,
[Activity_Type] [nvarchar] (50) NOT NULL,
[Description] [nvarchar] (50) NOT NULL,
[PQM] [smallint] NOT NULL,
[PQS] [float] NOT NULL,
[PQD] [float] NULL,
[Award_Miles] [int] NOT NULL
)
GO
