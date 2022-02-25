CREATE TABLE [dbo].[GoogleTimeline]
(
[TimelineID] [int] NOT NULL IDENTITY(1, 1),
[TimelineYear] [smallint] NULL,
[TimelineMonth] [tinyint] NULL,
[CityCount] [smallint] NULL,
[CityCountNew] [smallint] NULL,
[PlaceCount] [smallint] NULL,
[PlaceCountNew] [smallint] NULL,
[WalkMileage] [smallint] NULL,
[CarMileage] [smallint] NULL,
[BikeMileage] [smallint] NULL,
[CountryCount] [tinyint] NULL,
[NewCountryCount] [tinyint] NULL
)
GO
ALTER TABLE [dbo].[GoogleTimeline] ADD CONSTRAINT [GoogleTimelinePK] PRIMARY KEY CLUSTERED ([TimelineID])
GO
