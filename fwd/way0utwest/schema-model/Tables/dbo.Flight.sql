CREATE TABLE [dbo].[Flight]
(
[FlightKey] [int] NOT NULL IDENTITY(1, 1),
[FlightDate] [date] NULL,
[AirlineKey] [varchar] (50) NULL,
[FlightNumber] [varchar] (30) NULL,
[DepartureAirport] [varchar] (5) NULL,
[DestinationAirport] [varchar] (5) NULL,
[PQM] [int] NULL,
[PQS] [numeric] (4, 1) NULL,
[PQD] [int] NULL,
[AwardMiles] [int] NULL
)
GO
ALTER TABLE [dbo].[Flight] ADD CONSTRAINT [FlightPK] PRIMARY KEY CLUSTERED ([FlightKey])
GO
