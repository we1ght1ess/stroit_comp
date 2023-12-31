USE [master]
GO
/****** Object:  Database [stroit_comp]    Script Date: 01.10.2023 21:01:34 ******/
CREATE DATABASE [stroit_comp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'stroit_mеtrо', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\stroit_mеtrо.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'stroit_mеtrо_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\stroit_mеtrо_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [stroit_comp] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [stroit_comp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [stroit_comp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [stroit_comp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [stroit_comp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [stroit_comp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [stroit_comp] SET ARITHABORT OFF 
GO
ALTER DATABASE [stroit_comp] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [stroit_comp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [stroit_comp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [stroit_comp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [stroit_comp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [stroit_comp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [stroit_comp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [stroit_comp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [stroit_comp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [stroit_comp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [stroit_comp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [stroit_comp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [stroit_comp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [stroit_comp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [stroit_comp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [stroit_comp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [stroit_comp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [stroit_comp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [stroit_comp] SET  MULTI_USER 
GO
ALTER DATABASE [stroit_comp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [stroit_comp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [stroit_comp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [stroit_comp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [stroit_comp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [stroit_comp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [stroit_comp] SET QUERY_STORE = ON
GO
ALTER DATABASE [stroit_comp] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [stroit_comp]
GO
/****** Object:  Table [dbo].[Склады]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Склады](
	[Код_склада] [int] NOT NULL,
	[Адрес] [varchar](50) NOT NULL,
 CONSTRAINT [pk_sklad] PRIMARY KEY CLUSTERED 
(
	[Код_склада] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Материалы]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Материалы](
	[Код_материала] [int] NOT NULL,
	[Наименование_материала] [varchar](80) NOT NULL,
	[Ед_изм] [varchar](10) NOT NULL,
	[Количество] [int] NOT NULL,
	[Склад] [int] NULL,
 CONSTRAINT [pk_mater] PRIMARY KEY CLUSTERED 
(
	[Код_материала] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Materials]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Materials] AS SELECT Материалы.Код_материала, Материалы.Наименование_материала, Материалы.Ед_изм, Материалы.Количество, Склады.Адрес 
FROM Материалы JOIN Склады ON Материалы.Склад = Склады.Код_склада
GO
/****** Object:  Table [dbo].[Бригады]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Бригады](
	[Код_бригады] [int] NOT NULL,
	[Код_бригадира] [int] NULL,
	[Бригадир] [varchar](20) NOT NULL,
	[Название_бригады] [varchar](20) NOT NULL,
	[Количество_рабочих] [int] NOT NULL,
 CONSTRAINT [pk_brigada] PRIMARY KEY CLUSTERED 
(
	[Код_бригады] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[График_работ]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[График_работ](
	[Код_работы] [int] NOT NULL,
	[Код_бригады] [int] NULL,
	[Описание_работ] [varchar](50) NOT NULL,
	[Дата_начала_работ] [date] NOT NULL,
	[Дата_окончания_работ] [date] NOT NULL,
	[Код_использованного_материала] [int] NULL,
 CONSTRAINT [pk_raboti] PRIMARY KEY CLUSTERED 
(
	[Код_работы] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_WorkSchedule]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_WorkSchedule] AS SELECT b.Код_бригады, b.Бригадир, b.Название_бригады, b.Количество_рабочих, r.Описание_работ, r.Дата_начала_работ, r.Дата_окончания_работ, m.Наименование_материала, m.Ед_изм, m.Количество as Использованное_количество 
FROM Бригады b JOIN График_работ r ON b.Код_бригады = r.Код_бригады LEFT JOIN Материалы m ON r.Код_использованного_материала = m.Код_материала
GO
/****** Object:  Table [dbo].[Специальности]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Специальности](
	[Код_специальности] [int] NOT NULL,
	[Специальность] [varchar](50) NOT NULL,
 CONSTRAINT [pk_spec] PRIMARY KEY CLUSTERED 
(
	[Код_специальности] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Список_рабочих]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Список_рабочих](
	[Код_рабочего] [int] NOT NULL,
	[ФИО] [varchar](50) NOT NULL,
	[Номер_телефона] [varchar](15) NOT NULL,
	[Код_специальности] [int] NULL,
	[Дата_рождения] [date] NULL,
 CONSTRAINT [pk_rabot] PRIMARY KEY CLUSTERED 
(
	[Код_рабочего] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_WorkersList]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_WorkersList] AS SELECT Код_рабочего, ФИО, Номер_телефона, Специальности.Специальность, Дата_рождения 
FROM Список_рабочих JOIN Специальности ON Список_рабочих.Код_специальности = Специальности.Код_специальности
GO
ALTER TABLE [dbo].[Бригады]  WITH CHECK ADD FOREIGN KEY([Код_бригадира])
REFERENCES [dbo].[Список_рабочих] ([Код_рабочего])
GO
ALTER TABLE [dbo].[График_работ]  WITH CHECK ADD FOREIGN KEY([Код_бригады])
REFERENCES [dbo].[Бригады] ([Код_бригады])
GO
ALTER TABLE [dbo].[График_работ]  WITH CHECK ADD FOREIGN KEY([Код_использованного_материала])
REFERENCES [dbo].[Материалы] ([Код_материала])
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD FOREIGN KEY([Склад])
REFERENCES [dbo].[Склады] ([Код_склада])
GO
ALTER TABLE [dbo].[Список_рабочих]  WITH CHECK ADD FOREIGN KEY([Код_специальности])
REFERENCES [dbo].[Специальности] ([Код_специальности])
GO
/****** Object:  StoredProcedure [dbo].[kolvomat]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[kolvomat]
as
begin
select * from Материалы where Количество >= 50
end
GO
/****** Object:  StoredProcedure [dbo].[kspec]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[kspec]
@a int
as
select * from Список_рабочих where Код_специальности = @a
GO
/****** Object:  StoredProcedure [dbo].[kspec2]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[kspec2]
@a int = "5"
as
select * from Список_рабочих where Код_специальности = @a
GO
/****** Object:  StoredProcedure [dbo].[name_emp]    Script Date: 01.10.2023 21:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[name_emp]
@id int,
@emp varchar(50) output
as select @emp = ФИО from Список_рабочих Where Код_рабочего = @id
GO
USE [master]
GO
ALTER DATABASE [stroit_comp] SET  READ_WRITE 
GO
