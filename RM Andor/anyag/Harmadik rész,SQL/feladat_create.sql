1. Vegyél fel egy új főkategóriát (ProductCategory), aminek a neve legyen 'Komputers', az utolsó módosítás ideje pedig 2011 január 1, 0 óra 0 perc 0 másodperc. A dátum-idő megadásánál használd az ISO formátumot!

INSERT INTO Production.ProductCategory(Name, rowguid, ModifiedDate)
	VALUES ('Komputers', NEWID(), '2011-01-01T00:00:00.000');

2. Vegyél fel még két új főkategóriát egy utasításban, aminek a nevei legyenek 'Games', 'Frogs', az utolsó módosítás ideje pedig 2011 január 1, 0 óra 0 perc 0 másodperc. A dátum-idő megadásánál használd az ISO formátumot! 

INSERT INTO Production.ProductCategory(Name, rowguid, ModifiedDate)
	VALUES ('FROGS', NEWID(), '2011-01-01T00:00:00.000'),
		   ('Games', NEWID(), '2011-01-01T00:00:00.000');

3. Vedd észre, hogy elgépelted a 'Computers' szót, és még mielőtt bárki észrevenné a dolgot, gyorsan javítsd ki a főkategória nevét!

UPDATE Production.ProductCategory
	SET Name = 'Computers'
	WHERE Name = 'Komputers';

4. Vegyél fel két új alkategóriát (ProductSubcategory) egy utasításban, amiknek a nevei legyenek 'Notebooks' és 'Gaming PCs', és tartozzanak a Computers főkategóriához! A módosítás dátuma legyen az aktuális idő!

INSERT INTO Production.ProductSubcategory(ProductCategoryID, Name, rowguid, ModifiedDate)
	VALUES (13, 'Notebooks', NEWID(), GETDATE()),
		   (13, 'Gaming PCs', NEWID(), GETDATE());

SELECT * FROM Production.ProductSubcategory WHERE YEAR(ModifiedDate) = 2022;

5. Vegyél fel egy új alkategóriát, aminek a neve legyen 'Strategy Games', főkategóriának állítsd be a 'Frogs' főkategóriát!

INSERT INTO Production.ProductSubcategory(ProductCategoryID, Name, rowguid, ModifiedDate)
	VALUES (15,'Strategy Games', NEWID(), GETDATE());


6. Vedd észre, hogy a stratégiai játékok nem békák, és javítsd a főkategóriáját a 'Games' azonosítójára!

UPDATE Production.ProductSubcategory
	SET ProductCategoryID = 14
	WHERE Name = 'Strategy Games';


7. Vedd észre, hogy nem is akarsz békákat árulni, és töröld a 'Frogs' főkategóriát!

DELETE FROM Production.ProductCategory
	WHERE Name = 'Frogs';

8. Vedd észre, hogy még a dátumokat is elrontottad, és módosítsd a 'Computers' és a 'Games' főkategóriák dátumát az aktuális időpontra, egy utasításban!

UPDATE Production.ProductCategory
	SET ModifiedDate = GETDATE()
	WHERE NAME IN ('Computers', 'Games')