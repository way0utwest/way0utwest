CREATE TABLE [dbo].[TripStatus]
(
[TripStatusKey] [int] NOT NULL IDENTITY(1, 1),
[StatusValue] [varchar] (40) NULL
)
GO
ALTER TABLE [dbo].[TripStatus] ADD CONSTRAINT [TripStatusPK] PRIMARY KEY CLUSTERED ([TripStatusKey])
GO
