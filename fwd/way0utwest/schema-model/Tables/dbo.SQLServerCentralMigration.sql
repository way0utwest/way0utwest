CREATE TABLE [dbo].[SQLServerCentralMigration]
(
[ItemKey] [int] NOT NULL IDENTITY(1, 1),
[ProjectName] [varchar] (100) NULL,
[ItemStatus] [varchar] (100) NULL,
[ItemCount] [smallint] NULL,
[StatusDate] [date] NULL
)
GO
ALTER TABLE [dbo].[SQLServerCentralMigration] ADD CONSTRAINT [SSCMigrationPK] PRIMARY KEY CLUSTERED ([ItemKey])
GO
