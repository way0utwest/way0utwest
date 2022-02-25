CREATE TABLE [dbo].[RMRNationals]
(
[RMRKey] [int] NOT NULL IDENTITY(1, 1),
[SeasonYear] [int] NULL,
[TeamName] [varchar] (100) NULL,
[FinishPlace] [smallint] NULL,
[Division] [varchar] (100) NULL,
[ClubName] [varchar] (100) NULL
)
GO
ALTER TABLE [dbo].[RMRNationals] ADD CONSTRAINT [RMRNationalsPK] PRIMARY KEY CLUSTERED ([RMRKey])
GO
