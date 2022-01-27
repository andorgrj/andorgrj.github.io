USE [DemoDB]
GO

-- Server login

CREATE LOGIN Mancika   
    WITH PASSWORD = '123'; 
GO

CREATE USER Mancika FROM LOGIN Mancika;

-- --------------------------------------
-- DB ROLE 
CREATE ROLE [Szineszkezelo]
GO

-- ROLE Member (Role tagjai)
ALTER ROLE Szineszkezelo
	ADD MEMBER Mancika;  

ALTER ROLE Filmkezelo
	DROP MEMBER Mancika

EXEC sp_addrolemember 'Filmkezelo', 'Mancika';

-- --------------------------------------
-- Jogosultság kiosztás
-- AUTHORIZATION  PERMISSION  ON  SECURABLE::NAME  TO  PRINCIPAL;

GRANT SELECT ON OBJECT::dbo.Actor TO Szineszkezelo; 
GRANT EXEC ON OBJECT::dbo.EditFilm TO Szineszkezelo;

-- --------------------------------------
