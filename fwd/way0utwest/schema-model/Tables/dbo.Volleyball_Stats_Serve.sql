CREATE TABLE [dbo].[Volleyball_Stats_Serve]
(
[StatKey] [int] NOT NULL IDENTITY(1, 1),
[EventDate] [date] NULL,
[Opponent] [varchar] (80) NULL,
[Player] [varchar] (50) NULL,
[Rating] [numeric] (10, 4) NULL,
[ServiceAttempts] [tinyint] NULL,
[ServiceAces] [tinyint] NULL,
[ServiceErrors] [tinyint] NULL,
[EventName] [varchar] (100) NULL
)
GO
ALTER TABLE [dbo].[Volleyball_Stats_Serve] ADD CONSTRAINT [Volleyball_Stats_ServerPK] PRIMARY KEY CLUSTERED ([StatKey])
GO
