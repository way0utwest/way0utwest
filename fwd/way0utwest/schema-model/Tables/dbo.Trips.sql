CREATE TABLE [dbo].[Trips]
(
[TripKey] [int] NOT NULL IDENTITY(1, 1),
[TripDate] [date] NULL,
[PlaceKey] [int] NULL,
[AirportCode] [char] (3) NULL
)
GO
ALTER TABLE [dbo].[Trips] ADD CONSTRAINT [TripsPK] PRIMARY KEY CLUSTERED ([TripKey])
GO
