CREATE TABLE [dbo].[SpeakingEvent]
(
[SpeakingEventKey] [int] NOT NULL IDENTITY(1, 1),
[SpeakingEventDate] [datetime] NULL,
[SpeakingEventName] [varchar] (200) NULL,
[SpeakingEventCity] [varchar] (200) NULL,
[SpeakingEventState] [varchar] (2) NULL,
[SpeakingEventCountry] [varchar] (3) NULL
)
GO
