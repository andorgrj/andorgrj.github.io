SELECT * FROM Actor 
INSERT INTO Actor (Name) VALUES ('Jennifer Aniston') -- AUTOCOMMIT

BEGIN TRAN
-- INSERT INTO Actor (Name) VALUES ('Jennifer Lawrence')
-- INSERT INTO Actor (Name) VALUES ('Lisa Minelli')
INSERT INTO Actor (Name) VALUES ('Kate Winslet')

INSERT INTO FilmActor (FilmID, ActorID) VALUES (12,8)
@@error

SELECT XACT_STATE() -- megmutatja, hogy van e tranzakció folyamatban / 0, 1, -1


--COMMIT TRAN
--ROLLBACK TRAN