CREATE TABLE [dbo].[Volleyball_Stats_Serve_Staging]
(
[StatKey] [int] NOT NULL IDENTITY(1, 1),
[EventDate] [date] NULL,
[Event] [varchar] (100) NULL,
[Opponent] [varchar] (80) NULL,
[Player] [varchar] (50) NULL,
[Rating] [varchar] (10) NULL,
[Attempts] [tinyint] NULL,
[Aces] [tinyint] NULL,
[Errors] [tinyint] NULL
)
GO
ALTER TABLE [dbo].[Volleyball_Stats_Serve_Staging] ADD CONSTRAINT [Volleyball_Stats_Server_StagingPK] PRIMARY KEY CLUSTERED ([StatKey])
GO
