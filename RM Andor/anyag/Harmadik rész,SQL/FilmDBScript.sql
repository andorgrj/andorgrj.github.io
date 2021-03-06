USE [master]
GO
/****** Object:  Database [DemoDB]    Script Date: 2022.01.25. 19:09:45 ******/
CREATE DATABASE [DemoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DemoDB', FILENAME = N'C:\Databases\DBs\DemoDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DemoDB_log', FILENAME = N'C:\Databases\Logs\DemoDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DemoDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DemoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DemoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DemoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DemoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DemoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DemoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DemoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DemoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DemoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DemoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DemoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DemoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DemoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DemoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DemoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DemoDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DemoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DemoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DemoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DemoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DemoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DemoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DemoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DemoDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DemoDB] SET  MULTI_USER 
GO
ALTER DATABASE [DemoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DemoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DemoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DemoDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DemoDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DemoDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DemoDB', N'ON'
GO
ALTER DATABASE [DemoDB] SET QUERY_STORE = OFF
GO
USE [DemoDB]
GO
/****** Object:  User [Mancika]    Script Date: 2022.01.25. 19:09:45 ******/
CREATE USER [Mancika] FOR LOGIN [Mancika] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [Szineszkezelo]    Script Date: 2022.01.25. 19:09:45 ******/
CREATE ROLE [Szineszkezelo]
GO
/****** Object:  DatabaseRole [Filmkezelo]    Script Date: 2022.01.25. 19:09:45 ******/
CREATE ROLE [Filmkezelo]
GO
ALTER ROLE [Filmkezelo] ADD MEMBER [Mancika]
GO
ALTER ROLE [Szineszkezelo] ADD MEMBER [Mancika]
GO
/****** Object:  Table [dbo].[Actor]    Script Date: 2022.01.25. 19:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actor](
	[ActorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_ActorID] PRIMARY KEY CLUSTERED 
(
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Film]    Script Date: 2022.01.25. 19:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Film](
	[FilmID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
	[DeletedAt] [datetime] NULL,
 CONSTRAINT [PK_FilmID] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilmActor]    Script Date: 2022.01.25. 19:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmActor](
	[FilmID] [int] NULL,
	[ActorID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilmGenre]    Script Date: 2022.01.25. 19:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmGenre](
	[FilmID] [int] NULL,
	[GenreID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 2022.01.25. 19:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[Genre] [nvarchar](20) NULL,
 CONSTRAINT [PK_GenreID] PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NonNormalMovie]    Script Date: 2022.01.25. 19:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NonNormalMovie](
	[FilmTitle] [nvarchar](50) NULL,
	[Actor] [nvarchar](200) NULL,
	[Genre] [nvarchar](200) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Actor] ON 

INSERT [dbo].[Actor] ([ActorID], [Name]) VALUES (1, N'Tim Robbins')
INSERT [dbo].[Actor] ([ActorID], [Name]) VALUES (2, N'Morgan Freeman')
INSERT [dbo].[Actor] ([ActorID], [Name]) VALUES (3, N'Paul Newman')
INSERT [dbo].[Actor] ([ActorID], [Name]) VALUES (4, N'Robert Redford')
INSERT [dbo].[Actor] ([ActorID], [Name]) VALUES (5, N'Charlton Heston')
INSERT [dbo].[Actor] ([ActorID], [Name]) VALUES (6, N'John Cleese')
SET IDENTITY_INSERT [dbo].[Actor] OFF
GO
SET IDENTITY_INSERT [dbo].[Film] ON 

INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (1, N'Remény rabjai', NULL, NULL, NULL)
INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (2, N'Nagy ugrás', NULL, NULL, NULL)
INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (3, N'A nagy balhé', NULL, NULL, NULL)
INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (4, N'Nem Titanic', NULL, CAST(N'2022-01-24T11:37:02.320' AS DateTime), NULL)
INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (5, N'Csillagok háborúja', NULL, NULL, CAST(N'2022-01-24T11:32:37.110' AS DateTime))
INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (6, N'Ben Hur', NULL, NULL, NULL)
INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (7, N'Gyalog galopp', CAST(N'2022-01-24T11:34:59.317' AS DateTime), NULL, NULL)
INSERT [dbo].[Film] ([FilmID], [Title], [CreatedAt], [ModifiedAt], [DeletedAt]) VALUES (8, N'Nem Hulk', CAST(N'2022-01-25T17:37:51.680' AS DateTime), CAST(N'2022-01-25T17:57:02.213' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Film] OFF
GO
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (1, 1)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (1, 2)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (2, 1)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (2, 3)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (3, 3)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (3, 4)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (6, 5)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (7, 6)
GO
INSERT [dbo].[FilmGenre] ([FilmID], [GenreID]) VALUES (1, 1)
INSERT [dbo].[FilmGenre] ([FilmID], [GenreID]) VALUES (2, 1)
INSERT [dbo].[FilmGenre] ([FilmID], [GenreID]) VALUES (2, 2)
INSERT [dbo].[FilmGenre] ([FilmID], [GenreID]) VALUES (3, 1)
INSERT [dbo].[FilmGenre] ([FilmID], [GenreID]) VALUES (3, 2)
INSERT [dbo].[FilmGenre] ([FilmID], [GenreID]) VALUES (3, 3)
GO
SET IDENTITY_INSERT [dbo].[Genre] ON 

INSERT [dbo].[Genre] ([GenreID], [Genre]) VALUES (1, N'Dráma')
INSERT [dbo].[Genre] ([GenreID], [Genre]) VALUES (2, N'Vígjáték')
INSERT [dbo].[Genre] ([GenreID], [Genre]) VALUES (3, N'Krimi')
SET IDENTITY_INSERT [dbo].[Genre] OFF
GO
INSERT [dbo].[NonNormalMovie] ([FilmTitle], [Actor], [Genre]) VALUES (N'Remény rabjai', N'Tim Robbins, Morgan Freeman', N'Dráma')
INSERT [dbo].[NonNormalMovie] ([FilmTitle], [Actor], [Genre]) VALUES (N'Nagy ugrás', N'Tim Robbins, Paul Newman', N'Dráma, Vigjáték')
INSERT [dbo].[NonNormalMovie] ([FilmTitle], [Actor], [Genre]) VALUES (N'A nagy balhé', N'Paul Newman, Robert Redford', N'Dráma, Vígjáték, Krimi')
GO
ALTER TABLE [dbo].[FilmActor]  WITH CHECK ADD  CONSTRAINT [FK_Actor_FilmActor] FOREIGN KEY([ActorID])
REFERENCES [dbo].[Actor] ([ActorID])
GO
ALTER TABLE [dbo].[FilmActor] CHECK CONSTRAINT [FK_Actor_FilmActor]
GO
ALTER TABLE [dbo].[FilmActor]  WITH CHECK ADD  CONSTRAINT [FK_Film_FilmActor] FOREIGN KEY([FilmID])
REFERENCES [dbo].[Film] ([FilmID])
GO
ALTER TABLE [dbo].[FilmActor] CHECK CONSTRAINT [FK_Film_FilmActor]
GO
ALTER TABLE [dbo].[FilmGenre]  WITH CHECK ADD  CONSTRAINT [FK_Film_FilmGenre] FOREIGN KEY([FilmID])
REFERENCES [dbo].[Film] ([FilmID])
GO
ALTER TABLE [dbo].[FilmGenre] CHECK CONSTRAINT [FK_Film_FilmGenre]
GO
ALTER TABLE [dbo].[FilmGenre]  WITH CHECK ADD  CONSTRAINT [FK_Genre_FilmGenre] FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genre] ([GenreID])
GO
ALTER TABLE [dbo].[FilmGenre] CHECK CONSTRAINT [FK_Genre_FilmGenre]
GO
/****** Object:  StoredProcedure [dbo].[spDeleteFilm]    Script Date: 2022.01.25. 19:09:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteFilm] 
	@id int
AS
BEGIN
	UPDATE Film SET DeletedAT = GETDATE() WHERE FilmID = @id
	-- DELETE FROM FilmActor WHERE FilmID = @id
	-- DELETE FROM FilmGenre WHERE FilmID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[spEditFilm]    Script Date: 2022.01.25. 19:09:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEditFilm] 
	@FilmID int,
	@Filmcim nvarchar(50)
AS
BEGIN
	UPDATE Film	
	SET	Title = @Filmcim ,
		ModifiedAt = GETDATE()
	WHERE FilmID = @FilmID 
END
GO
/****** Object:  StoredProcedure [dbo].[spUjFilm]    Script Date: 2022.01.25. 19:09:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUjFilm] 
-- CREATE PROCEDURE UjFilm 
	@Filmcim nvarchar(50),
	@Szinesz nvarchar(50)
AS
BEGIN
	DECLARE @ujfilmid int
	DECLARE @ujszineszid int
	
	INSERT INTO Film (Title, CreatedAT) VALUES  (@Filmcim,GETDATE())
	SELECT @ujfilmid = @@IDENTITY

	INSERT INTO Actor VALUES (@Szinesz)
	SELECT @ujszineszid = @@IDENTITY

	INSERT INTO FilmActor VALUES (@ujfilmid, @ujszineszid)
END
GO
USE [master]
GO
ALTER DATABASE [DemoDB] SET  READ_WRITE 
GO
