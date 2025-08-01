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
	[FoodName] [nvarchar](50) NULL,
	[Discount] [float] NULL,
	[UnitPrice] [float] NULL,
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
INSERT [dbo].[ActivityLogs] ([Id], [Username], [Action], [Details], [Timestamp]) VALUES (2, N'b', N'Đăng nhập', N'Đăng nhập vào hệ thống', CAST(N'2025-07-04T11:23:45.217' AS DateTime))
SET IDENTITY_INSERT [dbo].[ActivityLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[BilliardTable] ON 

INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (1, N'Bàn 1', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (2, N'Bàn 2', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (3, N'Bàn 3', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (4, N'Bàn 4', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (5, N'Bàn 5', N'Hư nhẹ')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (6, N'Bàn 6', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (7, N'Bàn 7', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (8, N'Bàn 8', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (9, N'Bàn 9', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (10, N'Bàn 10', N'Hư')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (11, N'Bàn 11', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (12, N'Bàn 12', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (13, N'Bàn 13', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (14, N'Bàn 14', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (15, N'Bàn 15', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (16, N'Bàn 16', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (17, N'Bàn 17', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (18, N'Bàn 18', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (19, N'Bàn 19', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (20, N'Bàn 20', N'Tốt')
INSERT [dbo].[BilliardTable] ([id], [name], [status]) VALUES (21, N'Bàn 21', N'Tốt')
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
    [FoodName] [nvarchar](50) NULL,
    [Discount] [float] NULL,
    [UnitPrice] [float] NULL,
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
    INSERT INTO BillInfoDeleted (Id, IdBill, IdFood, Count, FoodName, Discount, UnitPrice)
    SELECT bi.Id, bi.IdBill, bi.IdFood, bi.Count, bi.FoodName, bi.Discount, bi.UnitPrice
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

