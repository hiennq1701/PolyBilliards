USE [master]
GO
/****** Object:  Database [PolyBilliards]    Script Date: 7/18/2025 9:20:08 AM ******/
CREATE DATABASE [PolyBilliards]
GO
ALTER DATABASE [PolyBilliards] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PolyBilliards].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PolyBilliards] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PolyBilliards] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PolyBilliards] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PolyBilliards] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PolyBilliards] SET ARITHABORT OFF 
GO
ALTER DATABASE [PolyBilliards] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PolyBilliards] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PolyBilliards] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PolyBilliards] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PolyBilliards] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PolyBilliards] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PolyBilliards] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PolyBilliards] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PolyBilliards] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PolyBilliards] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PolyBilliards] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PolyBilliards] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PolyBilliards] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PolyBilliards] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PolyBilliards] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PolyBilliards] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PolyBilliards] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PolyBilliards] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PolyBilliards] SET  MULTI_USER 
GO
ALTER DATABASE [PolyBilliards] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PolyBilliards] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PolyBilliards] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PolyBilliards] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PolyBilliards] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PolyBilliards] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PolyBilliards] SET QUERY_STORE = ON
GO
ALTER DATABASE [PolyBilliards] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PolyBilliards]
GO
/****** Object:  Table [dbo].[ActivityLogs]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[Action] [nvarchar](100) NOT NULL,
	[Details] [nvarchar](max) NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[Id] [int] IDENTITY(10000,1) NOT NULL,
	[DateCheckin] [datetime] NOT NULL,
	[DateCheckout] [datetime] NULL,
	[IdTable] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[TotalPrice] [float] NOT NULL,
	[Username] [nvarchar](20),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BilliardTable]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BilliardTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Billinfo]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Billinfo](
	[Id] [int] IDENTITY(100000,1) NOT NULL,
	[IdBill] [int] NOT NULL,
	[IdFood] [nvarchar](20) NOT NULL,
	[Count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatMessages]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatMessages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SenderUsername] [nvarchar](20) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Timestamp] [datetime] NULL,
	[IsRead] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[Id] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[Id] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[Discount] [float] NOT NULL,
	[Image] [nvarchar](50) NOT NULL,
	[Available] [bit] NOT NULL,
	[CategoryId] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[Photo] [nvarchar](100) NULL,
	[Manager] [bit] NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ActivityLogs] ON 

INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (1, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-04T10:51:25.877' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (2, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-04T11:23:45.217' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (3, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:29:35.210' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (4, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:38:33.247' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (5, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:40:20.643' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (6, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:43:40.400' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (7, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:45:13.193' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (8, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:48:08.003' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (9, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:54:55.267' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (10, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T22:59:34.097' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (11, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:00:49.747' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (12, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:01:46.260' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (13, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:02:36.070' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (14, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:03:24.493' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (15, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:04:40.887' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (16, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:04:59.567' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (17, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:13:57.310' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (18, N'a', N'Đăng xuất', N'Đăng xuất khỏi hệ thống', CAST(N'2025-07-08T23:15:10.870' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (19, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:15:16.857' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (20, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:15:43.837' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (21, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:17:26.590' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (22, N'a', N'Đăng xuất', N'Đăng xuất khỏi hệ thống', CAST(N'2025-07-08T23:17:31.447' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (23, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-08T23:17:43.250' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (24, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-09T17:00:22.373' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (25, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-09T17:01:47.553' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (26, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-09T17:20:18.427' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (27, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-09T17:24:01.750' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (28, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-09T20:35:07.203' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (29, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T11:29:43.860' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (30, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:07:45.640' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (31, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:16:19.513' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (32, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:19:13.503' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (33, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:24:58.657' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (34, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:29:02.007' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (35, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:29:47.967' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (36, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:43:35.863' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (37, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:46:40.700' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (38, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:47:33.413' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (39, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:49:40.837' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (40, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:54:36.100' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (41, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:55:03.617' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (42, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T12:59:47.510' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (43, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T13:00:49.277' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (44, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T13:02:41.730' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (45, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T13:06:16.587' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (46, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T13:11:46.617' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (47, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-10T20:53:47.607' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (48, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-11T09:23:26.477' AS DateTime))
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (49, N'a', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-11T18:10:33.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[ActivityLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[BilliardTable] ON 

INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (1, N'Bàn 1', N'AVAILABLE')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (2, N'Bàn 2', N'OCCUPIED')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (3, N'Bàn 3', N'AVAILABLE')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (4, N'Bàn 4', N'RESERVED')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (5, N'Bàn 5', N'AVAILABLE')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (6, N'VIP 1', N'AVAILABLE')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (7, N'VIP 2', N'OCCUPIED')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (8, N'PREMIUM 1', N'AVAILABLE')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (9, N'PREMIUM 2', N'MAINTENANCE')
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status]) VALUES (10, N'Bàn 6', N'AVAILABLE')
SET IDENTITY_INSERT [dbo].[BilliardTable] OFF
GO
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT001', N'Drinks')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT002', N'Snacks')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT003', N'Coffee')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT004', N'Beer')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT005', N'Juice')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT006', N'Fast Food')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT007', N'Dessert')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT008', N'Soft Drinks')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT009', N'Cocktail')
INSERT [dbo].[FoodCategory] ([Id], [Name]) VALUES (N'CAT010', N'Specialty')
GO

INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD001', N'Coca Cola', 15000, 0, N'cocacola.png', 1, N'CAT001')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD002', N'Pepsi', 15000, 0, N'pepsi.png', 1, N'CAT001')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD003', N'Banh Mi', 20000, 0, N'banhmi.png', 1, N'CAT002')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD004', N'Cà phê sữa', 25000, 0, N'caphe_sua.png', 1, N'CAT003')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD005', N'Bia Tiger', 25000, 0, N'bia_tiger.png', 1, N'CAT004')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD006', N'Cam vắt', 30000, 0, N'camvat.png', 1, N'CAT005')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD007', N'Hamburger', 35000, 0, N'hamburger.png', 1, N'CAT006')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD008', N'Bánh flan', 18000, 0, N'flan.png', 1, N'CAT007')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD009', N'Sprite', 15000, 0, N'sprite.png', 1, N'CAT008')
INSERT [dbo].[Food] ([Id], [Name], [UnitPrice], [Discount], [Image], [Available], [CategoryId]) VALUES (N'FOOD010', N'Mojito', 40000, 0, N'mojito.png', 1, N'CAT009')
GO
INSERT [dbo].[Users] ([Username], [Password], [Enabled], [Fullname], [Photo], [Manager], [Email]) VALUES (N'a', N'1234$', 1, N'NgoQuangHien', N'53B963D6.jpg', 1, N'quanghien1701@gmail.com')
INSERT [dbo].[Users] ([Username], [Password], [Enabled], [Fullname], [Photo], [Manager], [Email]) VALUES (N'b', N'1234$', 1, N'NgoQuangHien2', N'aaa', 0, N'hiennqth06730@gmail.com')
GO
ALTER TABLE [dbo].[ActivityLogs] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[ChatMessages] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[ChatMessages] ADD  DEFAULT ((0)) FOR [IsRead]
GO

GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('photo.png') FOR [Photo]
GO
ALTER TABLE [dbo].[ActivityLogs]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([Username])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([IdTable])
REFERENCES [dbo].[BilliardTable] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([Username])
GO
ALTER TABLE [dbo].[Billinfo]  WITH CHECK ADD FOREIGN KEY([IdBill])
REFERENCES [dbo].[Bill] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Billinfo]  WITH CHECK ADD FOREIGN KEY([IdFood])
REFERENCES [dbo].[Food] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ChatMessages]  WITH CHECK ADD FOREIGN KEY([SenderUsername])
REFERENCES [dbo].[Users] ([Username])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[FoodCategory] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO



-- =============================
-- Bảng lưu trữ bill và billinfo đã xóa
-- =============================
CREATE TABLE [dbo].[BillDeleted](
    [Id] [int] NOT NULL,
    [DateCheckin] [datetime] NOT NULL,
    [DateCheckout] [datetime] NULL,
    [IdTable] [int] NOT NULL,
    [Status] [int] NOT NULL,
    [TotalPrice] [float] NOT NULL,
    [Username] [nvarchar](20) NULL,
    [DeletedAt] [datetime] NOT NULL DEFAULT (getdate())
);
GO
CREATE TABLE [dbo].[BillInfoDeleted](
    [Id] [int] NOT NULL,
    [IdBill] [int] NOT NULL,
    [IdFood] [nvarchar](20) NOT NULL,
    [Count] [int] NOT NULL,
    [DeletedAt] [datetime] NOT NULL DEFAULT (getdate())
);
GO
-- =============================
-- Procedure: Xóa và lưu trữ bill đã thanh toán
-- =============================
CREATE PROCEDURE dbo.usp_LogAndShowDeletedBills
AS
BEGIN
    SET NOCOUNT ON;
    -- Lưu thông tin Bill sắp xóa vào BillDeleted
    INSERT INTO BillDeleted (Id, DateCheckin, DateCheckout, IdTable, Status, TotalPrice, Username)
    SELECT Id, DateCheckin, DateCheckout, IdTable, Status, TotalPrice, Username
    FROM Bill
    WHERE Status = 1; -- Chỉ xóa bill đã thanh toán

    -- Lưu thông tin Billinfo sắp xóa vào DeletedBillInfo
    INSERT INTO BillInfoDeleted (Id, IdBill, IdFood, Count)
    SELECT bi.Id, bi.IdBill, bi.IdFood, bi.Count
    FROM Billinfo bi
    INNER JOIN Bill b ON bi.IdBill = b.Id
    WHERE b.Status = 1;

    -- Xóa Billinfo liên quan
    DELETE bi
    FROM Billinfo bi
    INNER JOIN Bill b ON bi.IdBill = b.Id
    WHERE b.Status = 1;

    -- Xóa Bill
    DELETE FROM Bill WHERE Status = 1;

    -- Trả về danh sách bill đã xóa trong ngày
    SELECT * FROM BillDeleted WHERE CONVERT(date, DeletedAt) = CONVERT(date, GETDATE());
END
GO

USE [master]
GO
ALTER DATABASE [PolyBilliards] SET  READ_WRITE 
GO

