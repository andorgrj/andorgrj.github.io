CREATE PROCEDURE [dbo].[spUjFilmExtra]
-- CREATE PROCEDURE UjFilm 
    @Filmcim nvarchar(50),
    @Szinesz nvarchar(50)
AS
BEGIN
    IF NOT EXISTS (SELECT Title FROM Film WHERE Title = @Filmcim )
        BEGIN
            DECLARE @ujfilmid int
            DECLARE @ujszineszid int
    
            INSERT INTO Film (Title, CreatedAt) VALUES (@Filmcim, GETDATE())
            SELECT @ujfilmid = @@IDENTITY

            IF NOT EXISTS (SELECT Name FROM Actor WHERE Name = @Szinesz)
                BEGIN
                    INSERT INTO Actor VALUES (@Szinesz)
                    SELECT @ujszineszid = @@IDENTITY
                END
            ELSE 
                BEGIN 
                    SELECT @ujszineszid = ActorID FROM Actor WHERE Name = @Szinesz
					SELECT 'Van ilyen szinesz'
                END

            INSERT INTO FilmActor VALUES (@ujfilmid, @ujszineszid)
        END
    ELSE
        BEGIN
            SELECT 'A filmcím már létezik'
        END    
END