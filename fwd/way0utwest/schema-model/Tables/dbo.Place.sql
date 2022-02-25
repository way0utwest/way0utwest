CREATE TABLE [dbo].[Place]
(
[PlaceKey] [int] NOT NULL IDENTITY(1, 1),
[PlaceName] [varchar] (400) NULL,
[CountryCode] [varchar] (4) NULL,
[DateVisited] [date] NULL,
[StatusKey] [int] NULL
)
GO
ALTER TABLE [dbo].[Place] ADD CONSTRAINT [PlacePK] PRIMARY KEY CLUSTERED ([PlaceKey])
GO
