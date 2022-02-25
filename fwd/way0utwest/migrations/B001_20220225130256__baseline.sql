SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating schemas'
GO
PRINT N'Creating sequences'
GO
CREATE SEQUENCE [dbo].[FoldingAtHomePKSequence]
AS int
START WITH 20
INCREMENT BY 1
MINVALUE -2147483648
MAXVALUE 2147483647
NO CYCLE
CACHE 
GO
CREATE SEQUENCE [dbo].[MyKey]
AS int
START WITH 8
INCREMENT BY 1
MINVALUE -2147483648
MAXVALUE 2147483647
NO CYCLE
CACHE 
GO
PRINT N'Creating [dbo].[FoldingAtHome]'
GO
CREATE TABLE [dbo].[FoldingAtHome]
(
[WorkKey] [int] NOT NULL CONSTRAINT [df_FoldingAtHomeSequence] DEFAULT (NEXT VALUE FOR [dbo].[FoldingAtHomePKSequence]),
[WorkDate] [datetime2] (3) NULL,
[credit] [int] NULL,
[workunits] [int] NULL
)
GO
PRINT N'Creating primary key [WorkKeyPK] on [dbo].[FoldingAtHome]'
GO
ALTER TABLE [dbo].[FoldingAtHome] ADD CONSTRAINT [WorkKeyPK] PRIMARY KEY CLUSTERED ([WorkKey])
GO
PRINT N'Creating [dbo].[Volleyball_Stats_Serve_Staging]'
GO
CREATE TABLE [dbo].[Volleyball_Stats_Serve_Staging]
(
[StatKey] [int] NOT NULL IDENTITY(1, 1),
[EventDate] [date] NULL,
[Event] [varchar] (100) NULL,
[Opponent] [varchar] (80) NULL,
[Player] [varchar] (50) NULL,
[Rating] [varchar] (10) NULL,
[Attempts] [tinyint] NULL,
[Aces] [tinyint] NULL,
[Errors] [tinyint] NULL
)
GO
PRINT N'Creating primary key [Volleyball_Stats_Server_StagingPK] on [dbo].[Volleyball_Stats_Serve_Staging]'
GO
ALTER TABLE [dbo].[Volleyball_Stats_Serve_Staging] ADD CONSTRAINT [Volleyball_Stats_Server_StagingPK] PRIMARY KEY CLUSTERED ([StatKey])
GO
PRINT N'Creating [dbo].[Volleyball_Stats_Serve]'
GO
CREATE TABLE [dbo].[Volleyball_Stats_Serve]
(
[StatKey] [int] NOT NULL IDENTITY(1, 1),
[EventDate] [date] NULL,
[Opponent] [varchar] (80) NULL,
[Player] [varchar] (50) NULL,
[Rating] [numeric] (10, 4) NULL,
[ServiceAttempts] [tinyint] NULL,
[ServiceAces] [tinyint] NULL,
[ServiceErrors] [tinyint] NULL,
[EventName] [varchar] (100) NULL
)
GO
PRINT N'Creating primary key [Volleyball_Stats_ServerPK] on [dbo].[Volleyball_Stats_Serve]'
GO
ALTER TABLE [dbo].[Volleyball_Stats_Serve] ADD CONSTRAINT [Volleyball_Stats_ServerPK] PRIMARY KEY CLUSTERED ([StatKey])
GO
PRINT N'Creating [dbo].[Load_ServeStats]'
GO
CREATE PROCEDURE [dbo].[Load_ServeStats]
AS
BEGIN
    MERGE dbo.Volleyball_Stats_Serve
    USING dbo.Volleyball_Stats_Serve_Staging AS vsss
    ON Volleyball_Stats_Serve.EventDate = vsss.EventDate
    AND Volleyball_Stats_Serve.Opponent= vsss.Opponent
    AND Volleyball_Stats_Serve.Player = vsss.Player
    AND EventName = vsss.Event
    WHEN MATCHED THEN UPDATE SET Rating = CAST(REPLACE(vsss.Rating, '%', '') AS NUMERIC)
                               , ServiceAttempts = vsss.Attempts
    						   , ServiceAces = vsss.Aces
    						   , ServiceErrors = vsss.Errors
    WHEN NOT MATCHED THEN INSERT (EventDate, EventName, Opponent, Player, Rating, ServiceAttempts, ServiceAces, ServiceErrors)
     VALUES (vsss.EventDate, vsss.Event, vsss.Opponent, vsss.Player, CAST(REPLACE(vsss.Rating, '%', '') AS NUMERIC), vsss.Attempts, vsss.Aces, vsss.Errors);
    
END
RETURN 0
GO
PRINT N'Creating [dbo].[__MigrationLog]'
GO
CREATE TABLE [dbo].[__MigrationLog]
(
[migration_id] [uniqueidentifier] NOT NULL,
[script_checksum] [nvarchar] (64) NOT NULL,
[script_filename] [nvarchar] (255) NOT NULL,
[complete_dt] [datetime2] NOT NULL,
[applied_by] [nvarchar] (100) NOT NULL,
[deployed] [tinyint] NOT NULL CONSTRAINT [DF___MigrationLog_deployed] DEFAULT ((1)),
[version] [varchar] (255) NULL,
[package_version] [varchar] (255) NULL,
[release_version] [varchar] (255) NULL,
[sequence_no] [int] NOT NULL IDENTITY(1, 1)
)
GO
PRINT N'Creating primary key [PK___MigrationLog] on [dbo].[__MigrationLog]'
GO
ALTER TABLE [dbo].[__MigrationLog] ADD CONSTRAINT [PK___MigrationLog] PRIMARY KEY CLUSTERED ([migration_id], [complete_dt], [script_checksum])
GO
PRINT N'Creating index [IX___MigrationLog_CompleteDt] on [dbo].[__MigrationLog]'
GO
CREATE NONCLUSTERED INDEX [IX___MigrationLog_CompleteDt] ON [dbo].[__MigrationLog] ([complete_dt])
GO
PRINT N'Creating index [UX___MigrationLog_SequenceNo] on [dbo].[__MigrationLog]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX___MigrationLog_SequenceNo] ON [dbo].[__MigrationLog] ([sequence_no])
GO
PRINT N'Creating index [IX___MigrationLog_Version] on [dbo].[__MigrationLog]'
GO
CREATE NONCLUSTERED INDEX [IX___MigrationLog_Version] ON [dbo].[__MigrationLog] ([version])
GO
PRINT N'Creating [dbo].[__MigrationLogCurrent]'
GO

	CREATE VIEW [dbo].[__MigrationLogCurrent]
			AS
			WITH currentMigration AS
			(
			  SELECT
				 migration_id, script_checksum, script_filename, complete_dt, applied_by, deployed, ROW_NUMBER() OVER(PARTITION BY migration_id ORDER BY sequence_no DESC) AS RowNumber
			  FROM [dbo].[__MigrationLog]
			)
			SELECT  migration_id, script_checksum, script_filename, complete_dt, applied_by, deployed
			FROM currentMigration
			WHERE RowNumber = 1
	
GO
PRINT N'Creating [dbo].[CV]'
GO
CREATE TABLE [dbo].[CV]
(
[4/28/2017] [datetime] NULL,
[GroupBy Online Conference] [nvarchar] (255) NULL,
[Denver] [nvarchar] (255) NULL,
[USA] [nvarchar] (255) NULL,
[Bringing DevOps to the Database] [nvarchar] (255) NULL,
[F6] [nvarchar] (255) NULL
)
GO
PRINT N'Creating [dbo].[CountryCodes]'
GO
CREATE TABLE [dbo].[CountryCodes]
(
[CountryName] [nvarchar] (255) NULL,
[CountryCode] [nvarchar] (4) NOT NULL,
[ModifiedDate] [datetime2] (3) NULL CONSTRAINT [DF__CountryCo__Modif__5BE2A6F2] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_Countries] on [dbo].[CountryCodes]'
GO
ALTER TABLE [dbo].[CountryCodes] ADD CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED ([CountryCode])
GO
PRINT N'Creating [dbo].[Earnings]'
GO
CREATE TABLE [dbo].[Earnings]
(
[workyear] [int] NULL,
[sscearnings] [numeric] (10, 2) NULL,
[medicareearnings] [numeric] (10, 2) NULL
)
GO
PRINT N'Creating [dbo].[FlightStaging]'
GO
CREATE TABLE [dbo].[FlightStaging]
(
[FlightKey] [int] NOT NULL IDENTITY(1, 1),
[FlightDate] [smalldatetime] NULL,
[ActivityType] [varchar] (50) NULL,
[FlightDescription] [varchar] (300) NULL,
[PQM] [smallint] NULL,
[PQS] [numeric] (4, 1) NULL,
[PQD] [smallint] NULL,
[AwardMiles] [int] NULL
)
GO
PRINT N'Creating primary key [FlightStagingPK] on [dbo].[FlightStaging]'
GO
ALTER TABLE [dbo].[FlightStaging] ADD CONSTRAINT [FlightStagingPK] PRIMARY KEY CLUSTERED ([FlightKey])
GO
PRINT N'Creating [dbo].[Flight]'
GO
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
PRINT N'Creating primary key [FlightPK] on [dbo].[Flight]'
GO
ALTER TABLE [dbo].[Flight] ADD CONSTRAINT [FlightPK] PRIMARY KEY CLUSTERED ([FlightKey])
GO
PRINT N'Creating [dbo].[GoogleTimeline]'
GO
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
PRINT N'Creating primary key [GoogleTimelinePK] on [dbo].[GoogleTimeline]'
GO
ALTER TABLE [dbo].[GoogleTimeline] ADD CONSTRAINT [GoogleTimelinePK] PRIMARY KEY CLUSTERED ([TimelineID])
GO
PRINT N'Creating [dbo].[MentalChecklist]'
GO
CREATE TABLE [dbo].[MentalChecklist]
(
[MentalChecklistKey] [int] NOT NULL,
[QuestionText] [varchar] (200) NULL,
[QuestionOrder] [tinyint] NULL,
[CategoryName] [varchar] (50) NULL
)
GO
PRINT N'Creating [dbo].[MentalHealthCheckResult]'
GO
CREATE TABLE [dbo].[MentalHealthCheckResult]
(
[MentalHealthCheckResultKey] [int] NOT NULL,
[CheckDate] [datetimeoffset] NULL,
[Question] [tinyint] NULL,
[Result] [tinyint] NULL
)
GO
PRINT N'Creating [dbo].[MyTable]'
GO
CREATE TABLE [dbo].[MyTable]
(
[founder] [varchar] (50) NULL
)
GO
PRINT N'Creating [dbo].[Place]'
GO
CREATE TABLE [dbo].[Place]
(
[PlaceKey] [int] NOT NULL IDENTITY(1, 1),
[PlaceName] [varchar] (400) NULL,
[CountryCode] [varchar] (4) NULL,
[DateVisited] [date] NULL,
[StatusKey] [int] NULL
)
GO
PRINT N'Creating primary key [PlacePK] on [dbo].[Place]'
GO
ALTER TABLE [dbo].[Place] ADD CONSTRAINT [PlacePK] PRIMARY KEY CLUSTERED ([PlaceKey])
GO
PRINT N'Creating [dbo].[RMRNationals]'
GO
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
PRINT N'Creating primary key [RMRNationalsPK] on [dbo].[RMRNationals]'
GO
ALTER TABLE [dbo].[RMRNationals] ADD CONSTRAINT [RMRNationalsPK] PRIMARY KEY CLUSTERED ([RMRKey])
GO
PRINT N'Creating [dbo].[SQLServerCentralMigration]'
GO
CREATE TABLE [dbo].[SQLServerCentralMigration]
(
[ItemKey] [int] NOT NULL IDENTITY(1, 1),
[ProjectName] [varchar] (100) NULL,
[ItemStatus] [varchar] (100) NULL,
[ItemCount] [smallint] NULL,
[StatusDate] [date] NULL
)
GO
PRINT N'Creating primary key [SSCMigrationPK] on [dbo].[SQLServerCentralMigration]'
GO
ALTER TABLE [dbo].[SQLServerCentralMigration] ADD CONSTRAINT [SSCMigrationPK] PRIMARY KEY CLUSTERED ([ItemKey])
GO
PRINT N'Creating [dbo].[SpeakingEvent]'
GO
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
PRINT N'Creating [dbo].[TripStatus]'
GO
CREATE TABLE [dbo].[TripStatus]
(
[TripStatusKey] [int] NOT NULL IDENTITY(1, 1),
[StatusValue] [varchar] (40) NULL
)
GO
PRINT N'Creating primary key [TripStatusPK] on [dbo].[TripStatus]'
GO
ALTER TABLE [dbo].[TripStatus] ADD CONSTRAINT [TripStatusPK] PRIMARY KEY CLUSTERED ([TripStatusKey])
GO
PRINT N'Creating [dbo].[Trips]'
GO
CREATE TABLE [dbo].[Trips]
(
[TripKey] [int] NOT NULL IDENTITY(1, 1),
[TripDate] [date] NULL,
[PlaceKey] [int] NULL,
[AirportCode] [char] (3) NULL
)
GO
PRINT N'Creating primary key [TripsPK] on [dbo].[Trips]'
GO
ALTER TABLE [dbo].[Trips] ADD CONSTRAINT [TripsPK] PRIMARY KEY CLUSTERED ([TripKey])
GO
PRINT N'Creating [dbo].[USStatesVisited]'
GO
CREATE TABLE [dbo].[USStatesVisited]
(
[USStateCode] [varchar] (2) NOT NULL,
[USStateName] [varchar] (100) NOT NULL,
[DateVisited] [date] NULL
)
GO
PRINT N'Creating primary key [USStatesVisitedPK] on [dbo].[USStatesVisited]'
GO
ALTER TABLE [dbo].[USStatesVisited] ADD CONSTRAINT [USStatesVisitedPK] PRIMARY KEY CLUSTERED ([USStateCode])
GO
PRINT N'Creating [dbo].[United]'
GO
CREATE TABLE [dbo].[United]
(
[Transaction_Date] [date] NOT NULL,
[Activity_Type] [nvarchar] (50) NOT NULL,
[Description] [nvarchar] (50) NOT NULL,
[PQM] [smallint] NOT NULL,
[PQS] [float] NOT NULL,
[PQD] [float] NULL,
[Award_Miles] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[Workout]'
GO
CREATE TABLE [dbo].[Workout]
(
[WorkOutKey] [int] NOT NULL IDENTITY(1, 1),
[WorkDateDate] [date] NULL,
[ActivityGroup] [varchar] (100) NULL,
[WorkoutTitle] [varchar] (100) NULL,
[Calories] [int] NULL,
[Distance] [numeric] (10, 4) NULL,
[WorkoutTime_S] [int] NULL,
[WorkoutTime] [time] NULL,
[AvgPace_Min_Mile] [numeric] (10, 4) NULL,
[Max_Pace] [numeric] (10, 4) NULL,
[AvgSpeed_Mile_Hour] [numeric] (10, 4) NULL,
[Max_Speed] [numeric] (10, 4) NULL,
[Avg_HR] [smallint] NULL,
[Max_HR] [smallint] NULL,
[Steps] [int] NULL,
[Notes] [varchar] (500) NULL,
[DateUpdated] [datetime2] (3) NULL
)
GO
PRINT N'Creating primary key [WorkoutPK] on [dbo].[Workout]'
GO
ALTER TABLE [dbo].[Workout] ADD CONSTRAINT [WorkoutPK] PRIMARY KEY CLUSTERED ([WorkOutKey])
GO
PRINT N'Creating [dbo].[__SchemaSnapshot]'
GO
CREATE TABLE [dbo].[__SchemaSnapshot]
(
[Snapshot] [varbinary] (max) NULL,
[LastUpdateDate] [datetime2] NULL CONSTRAINT [__SchemaSnapshotDateDefault] DEFAULT (sysdatetime())
)
GO
PRINT N'Creating [dbo].[kids]'
GO
CREATE TABLE [dbo].[kids]
(
[kidname] [varchar] (100) NULL,
[kiddob] [datetimeoffset] NULL
)
GO
PRINT N'Creating [dbo].[staging_workout_history]'
GO
CREATE TABLE [dbo].[staging_workout_history]
(
[Date_Submitted] [nvarchar] (50) NOT NULL,
[Workout_Date] [nvarchar] (50) NOT NULL,
[Activity_Type] [nvarchar] (50) NOT NULL,
[Calories_Burned_kCal] [nvarchar] (50) NOT NULL,
[Distance_mi] [nvarchar] (50) NOT NULL,
[Workout_Time_seconds] [nvarchar] (50) NOT NULL,
[Avg_Pace_min_mi] [nvarchar] (50) NOT NULL,
[Max_Pace] [nvarchar] (50) NOT NULL,
[Avg_Speed_mi_h] [nvarchar] (50) NOT NULL,
[Max_Speed] [nvarchar] (50) NOT NULL,
[Avg_Heart_Rate] [nvarchar] (50) NULL,
[Steps] [nvarchar] (50) NULL,
[Notes] [nvarchar] (250) NOT NULL,
[Source] [nvarchar] (250) NULL,
[Link] [nvarchar] (250) NOT NULL
)
GO
PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is required by SQL Change Automation projects to keep track of which migrations have been executed during deployment. Please do not alter or remove this table from the database.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The executing user at the time of deployment (populated using the SYSTEM_USER function).', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'applied_by'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date/time that the migration finished executing. This value is populated using the SYSDATETIME function.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'complete_dt'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column contains a number of potential states:

0 - Marked As Deployed: The migration was not executed.
1- Deployed: The migration was executed successfully.
2- Imported: The migration was generated by importing from this DB.

"Marked As Deployed" and "Imported" are similar in that the migration was not executed on this database; it was was only marked as such to prevent it from executing during subsequent deployments.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'deployed'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique identifier of a migration script file. This value is stored within the <Migration /> Xml fragment within the header of the file itself.

Note that it is possible for this value to repeat in the [__MigrationLog] table. In the case of programmable object scripts, a record will be inserted with a particular ID each time a change is made to the source file and subsequently deployed.

In the case of a migration, you may see the same [migration_id] repeated, but only in the scenario where the "Mark As Deployed" button/command has been run.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'migration_id'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If you have enabled SQLCMD Packaging in your SQL Change Automation project, or if you are using Octopus Deploy, this will be the version number that your database package was stamped with at build-time.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'package_version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If you are using Octopus Deploy, you can use the value in this column to look-up which release was responsible for deploying this migration.
If deploying via PowerShell, set the $ReleaseVersion variable to populate this column.
If deploying via Visual Studio, this column will always be NULL.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'release_version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A SHA256 representation of the migration script file at the time of build.  This value is used to determine whether a migration has been changed since it was deployed. In the case of a programmable object script, a different checksum will cause the migration to be redeployed.
Note: if any variables have been specified as part of a deployment, this will not affect the checksum value.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'script_checksum'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the migration script file on disk, at the time of build.
If Semantic Versioning has been enabled, then this value will contain the full relative path from the root of the project folder. If it is not enabled, then it will simply contain the filename itself.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'script_filename'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An auto-seeded numeric identifier that can be used to determine the order in which migrations were deployed.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'sequence_no'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The semantic version that this migration was created under. In SQL Change Automation projects, a folder can be given a version number, e.g. 1.0.0, and one or more migration scripts can be stored within that folder to provide logical grouping of related database changes.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used by SQL Change Automation projects to store a snapshot of the schema at the time of the last deployment. Please do not alter or remove this table from the database.', 'SCHEMA', N'dbo', 'TABLE', N'__SchemaSnapshot', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This view is required by SQL Change Automation projects to determine whether a migration should be executed during a deployment. The view lists the most recent [__MigrationLog] entry for a given [migration_id], which is needed to determine whether a particular programmable object script needs to be (re)executed: a non-matching checksum on the current [__MigrationLog] entry will trigger the execution of a programmable object script. Please do not alter or remove this table from the database.', 'SCHEMA', N'dbo', 'VIEW', N'__MigrationLogCurrent', NULL, NULL
GO
