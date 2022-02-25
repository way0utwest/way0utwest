CREATE TABLE [dbo].[USStatesVisited]
(
[USStateCode] [varchar] (2) NOT NULL,
[USStateName] [varchar] (100) NOT NULL,
[DateVisited] [date] NULL
)
GO
ALTER TABLE [dbo].[USStatesVisited] ADD CONSTRAINT [USStatesVisitedPK] PRIMARY KEY CLUSTERED ([USStateCode])
GO
