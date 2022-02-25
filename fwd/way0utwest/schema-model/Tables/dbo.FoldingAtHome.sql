CREATE TABLE [dbo].[FoldingAtHome]
(
[WorkKey] [int] NOT NULL CONSTRAINT [df_FoldingAtHomeSequence] DEFAULT (NEXT VALUE FOR [dbo].[FoldingAtHomePKSequence]),
[WorkDate] [datetime2] (3) NULL,
[credit] [int] NULL,
[workunits] [int] NULL
)
GO
ALTER TABLE [dbo].[FoldingAtHome] ADD CONSTRAINT [WorkKeyPK] PRIMARY KEY CLUSTERED ([WorkKey])
GO
