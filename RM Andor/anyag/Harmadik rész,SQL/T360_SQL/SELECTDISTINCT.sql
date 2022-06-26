-- Der�ts�k ki, milyen sz�nek fordulnak el� a Production.Product t�bla Color oszlop�ban.

SELECT DISTINCT P.Color
FROM Production.Product P;



-- Milyen sz�n �s m�ret vari�ci�k fordulnak el� a Production.Product t�bla Color �s Size oszlopaiban

SELECT DISTINCT P.Color, P.Size
FROM Production.Product P;