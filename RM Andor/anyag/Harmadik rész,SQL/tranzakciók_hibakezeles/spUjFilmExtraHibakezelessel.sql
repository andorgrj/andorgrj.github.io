CREATE PROCEDURE spUjFilmExtraHibakezeles
-- CREATE PROCEDURE UjFilm 
    @Filmcim nvarchar(50),
    @Szinesz nvarchar(50)
AS
BEGIN
	BEGIN TRY
		DECLARE @ujfilmid int
		DECLARE @ujszineszid int
    
		INSERT INTO Film (Title, CreatedAt) VALUES (@Filmcim, GETDATE())
    
		SELECT @ujfilmid = @@IDENTITY
		SELECT @ujszineszid = ActorID FROM Actor WHERE Name = @Szinesz

		INSERT INTO FilmActor VALUES (@ujfilmid, @ujszineszid)

	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_SEVERITY(), ERROR_STATE()
	END CATCH
END -- SPvége

SELECT * FROM Film
SELECT * FROM Actor
SELECT * FROM FilmActor

Delete from FilmActor where ActorID is null

EXEC spUjFilmExtraHibakezeles 'Rambo', 'Sylvester Stallone'

EXEC spUjFilmExtra 'Indiana Jones 1', 'Tim Robbins'
EXEC spUjFilmExtra 'Indiana Jones 2', 'Harrison Ford'
EXEC spUjFilmExtra2 'Indiana Jones 3', 'Sean Connery'

ALTER TABLE FilmActor
	alter column ActorID int Not null