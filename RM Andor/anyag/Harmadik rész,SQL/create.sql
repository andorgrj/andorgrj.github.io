
INSERT INTO Production.ProductCategory(Name, rowguid, ModifiedDate)
	VALUES ('Computers', NEWID(), GETDATE());

SELECT * FROM Production.ProductCategory;

INSERT INTO Production.ProductCategory(Name, rowguid, ModifiedDate)
	VALUES ('Tools', NEWID(), GETDATE()),
		   ('Games', NEWID(), GETDATE());

/*Adatok törlése */
DELETE FROM Production.ProductCategory WHERE ProductCategoryID = 7;

/*Adatok törlése - több rekord */
DELETE FROM Production.ProductCategory
	WHERE YEAR(ModifiedDate) = 2022;

/* de nem minden adatot lehet törölni - mert egy másik táblában egy idegen kulcs mutat erre a konkrét rekordra */
DELETE FROM Production.ProductCategory
	WHERE ProductCategoryID = 1;

/* adatok módosítása */
UPDATE Production.ProductCategory
	SET Name = 'Apples'
	WHERE ProductCategoryID = 10

/* több rekordra igaz feltétel módosítása */
UPDATE Production.ProductCategory
	SET ModifiedDate = '2010-10-10T00:00:00.000'
	WHERE ProductCategoryID > 8;

/* több oszlop módosítása egyszerre */
UPDATE Production.ProductCategory
	SET ModifiedDate = '2015-10-10T00:00:00.000', rowguid = NEWID()
	WHERE ProductCategoryID > 8;