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
	[TableName] [nvarchar](50) NULL,
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
	[Price] [float] NOT NULL DEFAULT 0,
	[TableTypeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableType]    Script Date: 7/18/2025 9:20:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
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
	[HourlyRate] [float] NULL,
	[DiscountAmount] [float] NULL,
	[ServiceFee] [float] NULL,
	[OtherFee] [float] NULL,
	[Notes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
SET IDENTITY_INSERT [dbo].[TableType] ON

INSERT [dbo].[TableType] ([Id], [Name]) VALUES (1, N'Liber')
INSERT [dbo].[TableType] ([Id], [Name]) VALUES (2, N'VIP')
INSERT [dbo].[TableType] ([Id], [Name]) VALUES (3, N'Lỗ')
SET IDENTITY_INSERT [dbo].[TableType] OFF
GO
SET IDENTITY_INSERT [dbo].[BilliardTable] ON 

-- Bàn liber 1-12
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (1, N'Bàn liber 1', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (2, N'Bàn liber 2', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (3, N'Bàn liber 3', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (4, N'Bàn liber 4', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (5, N'Bàn liber 5', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (6, N'Bàn liber 6', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (7, N'Bàn liber 7', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (8, N'Bàn liber 8', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (9, N'Bàn liber 9', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (10, N'Bàn liber 10', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (11, N'Bàn liber 11', N'Chơi được', 60000, 1)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (12, N'Bàn liber 12', N'Chơi được', 60000, 1)

-- Bàn VIP 1-3
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (13, N'Bàn VIP 1', N'Chơi được', 60000, 2)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (14, N'Bàn VIP 2', N'Chơi được', 60000, 2)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (15, N'Bàn VIP 3', N'Chơi được', 60000, 2)

-- Bàn lỗ 1-5
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (16, N'Bàn lỗ 1', N'Chơi được', 60000, 3)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (17, N'Bàn lỗ 2', N'Chơi được', 60000, 3)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (18, N'Bàn lỗ 3', N'Chơi được', 60000, 3)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (19, N'Bàn lỗ 4', N'Chơi được', 60000, 3)
INSERT [dbo].[BilliardTable] ([Id], [Name], [Status], [Price], [TableTypeId]) VALUES (20, N'Bàn lỗ 5', N'Chơi được', 60000, 3)
SET IDENTITY_INSERT [dbo].[BilliardTable] OFF
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
ALTER TABLE [dbo].[BilliardTable]  WITH CHECK ADD FOREIGN KEY([TableTypeId])
REFERENCES [dbo].[TableType] ([Id])
ON UPDATE CASCADE
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
    [TableName] [nvarchar](50) NULL,
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
    [HourlyRate] [float] NULL,
    [DiscountAmount] [float] NULL,
    [ServiceFee] [float] NULL,
    [OtherFee] [float] NULL,
    [Notes] [nvarchar](max) NULL,
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
    INSERT INTO BillDeleted (Id, DateCheckin, DateCheckout, IdTable, Status, TotalPrice, Username, TableName)
    SELECT Id, DateCheckin, DateCheckout, IdTable, Status, TotalPrice, Username, TableName
    FROM Bill
    WHERE Status = 1; -- Chỉ xóa bill đã thanh toán

    -- Lưu thông tin Billinfo sắp xóa vào BillInfoDeleted
    INSERT INTO BillInfoDeleted (Id, IdBill, IdFood, Count, FoodName, Discount, UnitPrice, HourlyRate, DiscountAmount, ServiceFee, OtherFee, Notes, DeletedAt)
    SELECT bi.Id, bi.IdBill, bi.IdFood, bi.Count, bi.FoodName, bi.Discount, bi.UnitPrice, bi.HourlyRate, bi.DiscountAmount, bi.ServiceFee, bi.OtherFee, bi.Notes, GETDATE()
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