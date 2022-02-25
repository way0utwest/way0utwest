SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
