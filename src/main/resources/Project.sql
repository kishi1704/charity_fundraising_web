USE [master]
GO
/****** Object:  Database [FundraiserDB]    Script Date: 5/6/2023 3:50:41 PM ******/
CREATE DATABASE [FundraiserDB]
GO
ALTER DATABASE [FundraiserDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FundraiserDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FundraiserDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FundraiserDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FundraiserDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FundraiserDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FundraiserDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FundraiserDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FundraiserDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FundraiserDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FundraiserDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FundraiserDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FundraiserDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FundraiserDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FundraiserDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FundraiserDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FundraiserDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FundraiserDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FundraiserDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FundraiserDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FundraiserDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FundraiserDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FundraiserDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FundraiserDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FundraiserDB] SET RECOVERY FULL 
GO
ALTER DATABASE [FundraiserDB] SET  MULTI_USER 
GO
ALTER DATABASE [FundraiserDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FundraiserDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FundraiserDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FundraiserDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FundraiserDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FundraiserDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FundraiserDB', N'ON'
GO
ALTER DATABASE [FundraiserDB] SET QUERY_STORE = OFF
GO
USE [FundraiserDB]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 5/6/2023 3:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[password] [varchar](64) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[user_email] [varchar](120) NOT NULL,
	[user_role] [int] NOT NULL,
	[user_fullname] [nvarchar](100) NOT NULL,
	[user_address] [nvarchar](255) NULL,
	[user_phone] [varchar](10) NULL,
	[user_status] [varchar](20) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFund]    Script Date: 5/6/2023 3:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFund](
	[fund_id] [int] IDENTITY(1,1) NOT NULL,
	[fund_name] [nvarchar](200) NOT NULL,
	[fund_des] [nvarchar](500) NOT NULL,
	[image_url] [varchar](300) NULL,
	[fund_content] [ntext] NOT NULL,
	[expected_amount] [bigint] NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[fund_status] [varchar](20) NULL,
	[category_id] [int] NOT NULL,
	[foundation_id] [int] NOT NULL,
 CONSTRAINT [PK_tblFund] PRIMARY KEY CLUSTERED 
(
	[fund_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDonation]    Script Date: 5/6/2023 3:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDonation](
	[donation_id] [int] IDENTITY(1,1) NOT NULL,
	[donation_amount] [int] NOT NULL,
	[donation_date] [date] NOT NULL,
	[donation_mess] [nvarchar](200) NULL,
	[fund_id] [int] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_tblDonation] PRIMARY KEY CLUSTERED 
(
	[donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[donationExtend]    Script Date: 5/6/2023 3:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[donationExtend] AS
SELECT d.donation_id, d.donation_amount, d.donation_mess, d.donation_date, d.user_id, u.username, d.fund_id, f.fund_name, f.image_url
FROM tblDonation as d
LEFT JOIN tblUser as u ON d.user_id = u.user_id
LEFT JOIN tblFund as f ON d.fund_id = f.fund_id
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 5/6/2023 3:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
	[category_des] [nvarchar](500) NOT NULL,
	[category_status] [varchar](20) NOT NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFoundation]    Script Date: 5/6/2023 3:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFoundation](
	[foundation_id] [int] IDENTITY(1,1) NOT NULL,
	[foundation_email] [varchar](120) NOT NULL,
	[foundation_name] [nvarchar](100) NOT NULL,
	[foundation_des] [nvarchar](1000) NOT NULL,
	[foundation_status] [varchar](20) NULL,
 CONSTRAINT [PK_tblFoundation] PRIMARY KEY CLUSTERED 
(
	[foundation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[fundExtend]    Script Date: 5/6/2023 3:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[fundExtend] AS
SELECT f.*, fo.foundation_name, c.category_name
FROM tblFund as f
LEFT JOIN tblFoundation as fo ON f.foundation_id = fo.foundation_id
LEFT JOIN tblCategory as c ON f.category_id = c.category_id
GO
SET IDENTITY_INSERT [dbo].[tblCategory] ON 

INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (1, N'Vì Trẻ Em', N'Giúp đỡ trẻ em vùng cao, trẻ em nghèo, mồ côi, có hoàn cảnh khó khăn', N'Enable')
INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (2, N'Người Già, Người Khuyết Tật', N'Giúp đỡ người già neo đơn, người vô gia cư, không nơi nương tựa', N'Enable')
INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (3, N'Bệnh Hiểm Nghèo', N'Giúp đỡ trẻ em, người mắc bệnh hiểm nghèo', N'Enable')
INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (4, N'Hoàn Cảnh Khó Khăn', N'Hoàn Cảnh Khó Khăn', N'Enable')
INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (5, N'Hỗ Trợ Giáo Dục', N'Xây dựng trường học - Tủ sách yêu thương tiếp sức đến trường cho trẻ em nghèo', N'Enable')
INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (6, N'Đầu Tư Cơ Sở Vật Chất', N'Giúp đỡ xây dựng cầu đường, cải tạo nước sạch cho những vùng sâu vùng xa khó khăn', N'Enable')
INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (7, N'Cứu Trợ Động Vật', N'Cứu trợ động vật, chó mèo bị bỏ rơi hoặc bị thương cần được chữa trị và chăm sóc phục hồi', N'Enable')
INSERT [dbo].[tblCategory] ([category_id], [category_name], [category_des], [category_status]) VALUES (8, N'Bảo Vệ Môi Trường', N'Bảo vệ môi trường - Trồng rừng, cải tạo môi trường xanh, nước sạch', N'Enable')
SET IDENTITY_INSERT [dbo].[tblCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[tblDonation] ON 

INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (1, 100000000, CAST(N'2023-02-23' AS Date), N'1 chút tấm lòng', 1, 2)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (2, 100000000, CAST(N'2023-02-25' AS Date), N'Chúc dự án thành công', 2, 3)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (3, 200000000, CAST(N'2023-02-20' AS Date), N'1 chút tấm lòng ạ', 3, 4)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (4, 150000000, CAST(N'2023-02-21' AS Date), N'1 chút tấm lòng ạ', 4, 5)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (5, 100000000, CAST(N'2023-02-27' AS Date), N'1 chút tấm lòng', 5, 6)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (6, 100000000, CAST(N'2023-02-24' AS Date), N'A di đà phật', 6, 7)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (7, 100000000, CAST(N'2023-02-23' AS Date), N'Gửi 1 ít quà', 7, 11)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (8, 100000000, CAST(N'2023-02-22' AS Date), N'Gửi tặng 1 ít tiềng', 8, 9)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (9, 20000000, CAST(N'2023-02-26' AS Date), N'1 chút tấm lòng', 9, 10)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (10, 30000000, CAST(N'2023-02-20' AS Date), N'Gửi tặng cho quỹ', 10, 2)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (11, 10000000, CAST(N'2023-02-21' AS Date), N'Chúc may mắn', 11, 2)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (12, 20000000, CAST(N'2023-02-23' AS Date), N'Của ít lòng nhiều', 12, 2)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (13, 15000000, CAST(N'2023-02-20' AS Date), N'1 chút tấm lòng', 13, 6)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (14, 30000000, CAST(N'2023-02-20' AS Date), N'1 chút tấm lòng', 14, 5)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (15, 20000000, CAST(N'2023-02-25' AS Date), N'Của ít lòng nhiều', 15, 3)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (16, 30000000, CAST(N'2023-02-27' AS Date), N'Mong giúp được người khó khăn', 16, 6)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (17, 5000000, CAST(N'2023-04-24' AS Date), N'Hãy cố gắng vượt qua khó khăn nhé', 10, 2)
INSERT [dbo].[tblDonation] ([donation_id], [donation_amount], [donation_date], [donation_mess], [fund_id], [user_id]) VALUES (18, 5000000, CAST(N'2023-04-24' AS Date), N'Hãy cố gắng lên nhé. Cuộc sống sẽ tốt lên thui mà', 11, 2)
SET IDENTITY_INSERT [dbo].[tblDonation] OFF
GO
SET IDENTITY_INSERT [dbo].[tblFoundation] ON 

INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (1, N'duansucmanh2000@gmail.com', N'Sức Mạnh 2000 - Ánh sáng núi rừng', N'Quỹ Sức mạnh 2000 thuộc hệ sinh thái Nuôi Em, được thành lập để nâng cao chất lượng Cơ sở vật chất cho các em nhỏ khó khăn vùng cao.
Mỗi người 2.000 đồng/ngày, chúng tôi đã xây dựng trong 10 năm qua', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (2, N'hope@quyhyvong.com', N'Quỹ Hy Vọng - Hope Foundation', N'Ra đời năm 2017, Quỹ Hy Vọng là một quỹ xã hội - từ thiện hoạt động vì cộng đồng, không vì lợi nhuận, được vận hành bởi Báo điện tử VnExpress và Công ty cổ phần FPT. Quỹ Hy vọng theo đuổi hai mục tiêu: hỗ trợ các hoàn cảnh khó khăn và tạo động lực phát triển.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (3, N'contact@hoachiase.com', N'Quỹ Từ Thiện Hoa Chia Sẻ', N'Quỹ xã hội – từ thiện được thành lập tự nguyện, không vì lợi nhuận, trên nguyên tắc tự tạo vốn. Quỹ hoạt động nhằm mục đích xã hội – từ thiện, ưu tiên giúp đỡ các gia đình khó khăn, có công với cách mạng và hỗ trợ, khuyến khích phát triển văn hóa, giáo dục, y tế, thể dục thể thao, khoa học và các mục đích phát triển cộng đồng phù hợp quy định của pháp luật.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (4, N'info@vinacapitalfoundation.org', N'VinaCapital Foundation', N'Tổ chức VinaCapital Foundation (VCF) hoạt động với sứ mệnh trao quyền cho trẻ em và phụ nữ Việt Nam thông qua các chương trình y tế và giáo dục.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (5, N'lienhe@vitamvocviet.vn', N'Quỹ Vì Tầm Vóc Việt', N'Quỹ Vì Tầm Vóc Việt là tổ chức phi lợi nhuận được thành lập với sứ mệnh đóng góp cho các Mục tiêu Phát triển Bền vững của Liên Hợp Quốc.', N'Disable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (6, N'saigonchildren@gmail.com', N'Saigon Children’s Charity', N'Saigon Children’s Charity (saigonchildren) hoạt động với sứ mệnh xóa bỏ rào cản đến với giáo dục cho trẻ em thiệt thòi trên khắp Việt Nam.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (7, N'scdi@scdi.org.vn', N'SCDI – Mỗi Ngày Một Quả Trứng', N'Quỹ Mỗi Ngày Một Quả Trứng (MNMQT) là sáng kiến gây quỹ của Trung tâm Hỗ trợ Sáng kiến Phát triển Cộng đồng (SCDI) nhằm cứu trợ khẩn cấp, nâng cao khả năng hồi phục, thích ứng và cắt đứt vòng xoáy đói nghèo cho những người khó khăn nhất.', N'Disable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (8, N'chuongtrinhthiennhan@gmail.com', N'Thiện Nhân & Friends - Quỹ Phòng chống Thương vong Châu Á', N'Chương trình “Thiện Nhân và những người bạn” phẫu thuật tái tạo bộ phận sinh dục cho trẻ em thuộc Quỹ Phòng chống Thương vong Châu Á.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (9, N'tuonglaicenter@gmail.com', N'Trung tâm Tương Lai', N'Trung tâm Tương Lai là tổ chức chuyên hoạt động để hỗ trợ giáo dục và bảo vệ trẻ em và thanh thiếu niên.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (10, N'Quytrangkhuyet@gmail.com', N'Quỹ Trăng Khuyết', N'Trăng Khuyết là tổ chức từ thiện nhân đạo, hoạt động độc lập, phi tôn giáo và phi lợi nhuận trên toàn lãnh thổ Việt Nam, nhằm kết nối cộng đồng và thực hiện các hoạt động cứu trợ trực tiếp liên quan đến: bữa ăn, chỗ ở, chăm sóc sức khỏe - tinh thần cho các cụ già không nơi nương tựa và trẻ em bị bỏ rơi.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (11, N'supporters@operationsmile.org', N'Operation Smile', N'Operation Smile mang lại nụ cười và thay đổi cuộc sống của những trẻ em bị dị tật bẩm sinh trên khuôn mặt ở Việt Nam và khắp thế giới.', N'Enable')
INSERT [dbo].[tblFoundation] ([foundation_id], [foundation_email], [foundation_name], [foundation_des], [foundation_status]) VALUES (12, N'contact@msdvietnam.org', N'Viện Nghiên cứu Quản lý Phát triển bền vững (MSD)', N'Là một tổ chức phi chính phủ Việt Nam, MSD nỗ lực hành động thúc đẩy việc thực hiện quyền của các nhóm cộng đồng bị lề hoá, dễ bị tổn thương. MSD cũng là tổ chức đáp ứng nhu cầu và bảo vệ các đối tượng có hoàn cảnh khó khăn, thông qua các dự án và hỗ trợ trẻ em, thanh thiếu niên, phụ nữ, người vô gia cư, người nhập cư và người khuyết tật tại Việt Nam.', N'Enable')
SET IDENTITY_INSERT [dbo].[tblFoundation] OFF
GO
SET IDENTITY_INSERT [dbo].[tblFund] ON 

INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (1, N'Chung tay gây quỹ trao quà đầu năm mới cho 200 trẻ em mắc chứng bại não tại khu vực phía Nam', N'Cùng chung tay với MSD United Way Vietnam và tổ chức CPFAV Gây quỹ trao quà đầu năm mới cho 200 trẻ em mắc chứng bại não tại khu vực phía Nam', N'https://static.mservice.io/blogscontents/momo-upload-api-230220134154-638124973147799737.jpg', N'<p>Đây là mùa xuân thứ 3 MSD United Way Vietnam, CPFAV cùng kết hợp với cộng đồng Heo Đất MoMo để mang lại niềm vui cho các trẻ bại não trong chương trình “Vui Xuân Phương Nam”. Trên giải đất hình chữ S, mỗi năm có hàng ngàn em bé sinh ra và phải sống trọn đời với chứng bại não. Đây là một hội chứng gây ra những biến dạng nặng nề về tư thế và vận động, buộc các em phải sống phụ thuộc vào sự chăm sóc của cha mẹ, người thân, không được đến trường và bước ra ngoài cuộc sống vui tươi như mọi trẻ em khác.</p>

<p>Những em bé không được đến trường không được vui chơi như bạn bè đồng trang lứa</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230220133157-638124967177685103.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Nhiều em bé không được may mắn như bạn bè đồng trang lứa</em></p>

<p>Em Huỳnh Thảo Minh An ở Tổ 1 ấp Bầu Sinh, xã Suối Cao, Xuân Lộc, Đồng Nai. Minh An sinh năm 2015, bị bại não từ khi sinh ra. Dù đã ở tuổi thứ 7 nhưng em mới đang bập bẹ tập nói và vẫn chưa đi được. Em chưa thể đi học hòa nhập do mẹ em là Chu Thu Thảo bị tai nạn nặng, đa chấn thương đã một năm nay. Mọi chi tiêu sinh hoạt trong nhà, chữa bệnh cho mẹ, chăm sóc con phụ thuộc vào mình bố đi làm.</p>

<p>Em Nguyễn Xuân Đức sinh năm 2018, bố em là Nguyễn Xuân Quyết. Gia đình em quê ở Hưng Hòa, Tam Nông, Phú Thọ nhưng hiện đang thuê trọ tại khu phố 3, phường An Phú , thành phố Thuận An, tỉnh Bình Dương. Em Đức bị bại não bẩm sinh, hạn chế nhận thức, chỉ nằm một chỗ. Suốt 8 tháng nay, em ở bệnh viện Nhi Đồng 1 điều trị bệnh viêm phổi và thiếu oxy. Bố của em phải nghỉ làm để chăm con trong bệnh viện. Mọi gánh nặng kinh tế đổ dồn lên đôi vai của mẹ em. Mẹ làm công nhân, thu nhập bấp bênh theo từng đơn hàng nhà máy. Vừa lo chạy chữa cho Đức, bố mẹ em vừa gồng gánh nuôi hai người con nữa ở quê và bà nội bị tai biến, liệt nửa người. Năm nay, bố con em Đức đón giao thừa năm mới trong bệnh viện.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230220133218-638124967383903324.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Các em nhỏ bại não ở khu vực Tây Nguyên hạnh phúc khi nhận được quà từ các nhà hảo tâm</em></p>

<p>Em Phan Nguyễn Quỳnh Như sinh năm 2012, con mẹ Xuân Mai ở khu dân cư khóm 8, phường Châu Phú A, thành phố Châu Đốc, tỉnh An Giang. Em bị bại não thể gồng cứng, không hoạt động tay chân được, ngồi nằm ăn uống cũng phải có người giúp đỡ. Mẹ em là mẹ đơn thân, công việc không ổn định vì phải dành phần lớn thời gian chăm sóc em, một mình vừa là người cha, người mẹ, là trụ cột lo cho cả gia đình nhỏ.</p>

<p>Các em ở đất liền, nơi trung tâm còn đỡ vất vả, trẻ em bại não ở các huyện đảo của Tổ quốc lại càng khó khăn hơn. Sống với đau yếu, bệnh tật, mỗi chuyến đi của các em là gắn với những chuyến tàu cập bờ.</p>

<p>Em Phạm Minh Khôi ở Khu phố 3, phường Dương Đông, thành phố Phú Quốc, Kiên Giang sinh ra là một em bé khỏe mạnh. Nếu như không phải vì một cơn sốt gây tai biến thì mùa xuân 2023 này em đã là một học sinh lớp 2 tiểu học. Nhưng có lẽ, khuôn mặt khôi ngô, ánh mắt nhanh nhẹn chỉ còn lại trong ký ức của người thân, vì giờ đây, hội chứng bại não đã khiến em phải nằm một chỗ, không nhận thức được xung quanh. Càng tội nghiệp hơn khi em bị bệnh thì mẹ em cũng đã bỏ đi. Một mình bố em gồng gánh điều trị cho con tại bệnh viện Nhi đồng 1 Tp.HCM và em bị bại não từ đó. Thiếu vắng hơi ấm của mẹ, mọi sinh hoạt của em đều phụ thuộc vào bàn tay chăm sóc của bố. Thương con, bố Tiến vay mượn tiền cho Khôi vào thành phố Hồ Chí Minh, ra Hà Nội trị liệu. Nhưng bệnh tình Khôi không giảm mà chi phí cho những đợt điều trị cứ thế lớn dần khiến hoàn cảnh gia đình rơi vào khánh kiệt.</p>

<p>Cùng ở giữa huyện đảo xa xôi còn có 2 anh em siêu nhân nhà mẹ Nguyễn Thị Hiền ở Dương Đông, Phú Quốc. Em Nguyễn Duy Hoàng Quân là con trai đầu, năm nay đã 9 tuổi rồi những vẫn phải phụ thuộc mọi thứ vào cha mẹ. Dưới Hoàng còn có em trai cũng có những biểu hiện chậm phát triển. Vợ chồng chị Hiền từ Bắc vào Nam lập nghiệp, việc có 2 con bị bại não khiến gia đình chị khó khăn càng thêm chồng chất khó khăn. Những ngày cuối năm đã cận kề, chị vẫn chỉ mong có được ngày 3 bữa cơm cho các con ấm bụng.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230220133240-638124967606592294.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Còn rất nhiều hoàn cảnh đáng thương cần sự chung tay giúp đỡ của cả cộng đồng</em></p>

<p>Các em chỉ là một trong các hoàn cảnh rất đặc biệt trong hơn 200 hoàn cảnh gia đình có trẻ em mắc chứng bại não ở khu vực phía Nam, trải rộng khắp các tỉnh Long An, Đồng Tháp, Tây Ninh, Sóc Trăng, Cà Mau, An Giang, Kiên Giang,... Các em cùng với gia đình vẫn đang hàng ngày hàng giờ chiến đấu vượt lên sự hạn chế về thân thể khuyết tật, để cảm nhận những ấm áp, yêu thương của cuộc sống này.</p>

<p><strong>Cùng trao quà mừng Năm mới - Gửi yêu thương tới 200 trẻ em bại não dịp xuân Quý Mão</strong></p>

<p>Những ngày đầu xuân năm mới Quý Mão 2023, với mong muốn hỗ trợ cho các gia đình trẻ bại não có hoàn cảnh khó khăn, Viện Nghiên cứu Quản lý và Phát triển bền vững (MSD) – United Way Vietnam phối hợp với Trái tim MoMo và Hội Gia đình Trẻ bại não Việt Nam thành lập dự án Vui xuân phương Nam (CPFAV) - Trao quà mừng xuân 2023. Chúng tôi mong muốn được mọi người chung tay mang đến niềm vui ấm áp nho nhỏ những ngày đầu năm mới, cũng như nỗ lực để Việt Nam chúng ta không có trẻ em khuyết tật nào bị bỏ rơi lại phía sau.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230220133318-638124967981353931.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230220133327-638124968076976011.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>200 phần quà mừng năm mới trao đi sẽ góp phần san sẻ gánh nặng với các gia đình kém may mắn</em></p>

<p>Để hiện thực hóa kế hoạch ấy, chúng tôi kêu gọi cộng đồng cùng chung tay quyên góp số tiền là 150.000.000 đồng. Số tiền sẽ được sử dụng để mua 200 phần quà, mỗi phần quà 750.000 VND tặng cho các em trong dịp đầu xuân năm mới. Đó cũng là món quà nhỏ thay cho lời chúc của cộng đồng gửi đến trẻ em bại não, tiếp thêm sức mạnh cho các em chiến đấu với bệnh tật cũng như phần nào san sẻ gánh nặng với gia đình các em.</p>

<p><u><strong>Về Viện Nghiên cứu Quản lý Phát triển bền vững (MSD) – United Way Vietnam:</strong></u><br />
Là một tổ chức phi chính phủ Việt Nam, MSD – United Way Việt Nam nỗ lực hành động vì một môi trường phát triển thuận lợi cho sự phát triển của khối các tổ chức xã hội và thúc đẩy việc thực hiện quyền của các nhóm cộng đồng bị lề hoá và dễ bị tổn thương, đặc biệt là nhóm trẻ em, thanh niên, phụ nữ và người khuyết tật. Hiện nay, MSD – United Way Việt Nam được công nhận là một tổ chức hàng đầu trong việc phối hợp, hỗ trợ và cung cấp các dịch vụ nâng cao năng lực, đào tạo và tham vấn cho các tổ chức xã hội tại Việt Nam. Thêm vào đó, MSD – United Way Việt Nam cũng là một tổ chức chuyên nghiệp đáp ứng hiệu quả nhu cầu và bảo vệ quyền lợi của các đối tượng có hoàn cảnh khó khăn, thông qua tổ chức các dự án và hỗ trợ trẻ em, thanh thiếu niên, phụ nữ, người vô gia cư, người nhập cư và người khuyết tật tại Việt Nam.</p>

<p><u><strong>Về Hội Gia đình Trẻ bại não Việt Nam:</strong></u><br />
Hội Gia đình trẻ bại não Việt Nam (tên viết tắt là CPFAV, tên gọi thân thương là Gia đình Siêu nhân), được chính các cha mẹ có con bị bại não (CP) chung tay thành lập từ năm 2015. CPFAV là một tổ chức chính danh của cha mẹ trẻ bại não trên cả nước. Hiện nay, CPFAV là một cộng đồng lớn và uy tín của trẻ bại não với gần gần 4000 trẻ bại não trên cả nước. Là một tổ chức của cha mẹ và trẻ em mắc chứng bại não, CPFAV nỗ lực xây dựng một mạng lưới của và vì cộng đồng trẻ bại não Việt Nam, để thực hiện sứ mệnh là tổ chức tiên phong trong việc thúc đẩy các chương trình hỗ trợ phục hồi chức năng dựa vào cộng đồng, góp phần cải thiện chất lượng cuộc sống, hòa nhập xã hội và hướng nghiệp</p>
', 100000000, CAST(N'2023-01-02' AS Date), CAST(N'2023-03-19' AS Date), N'Enable', 1, 12)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (2, N'Xây dựng mở rộng sân chơi tại bờ vở sông Hồng giúp trẻ em nâng cao sức khỏe tâm trí và thể chất', N'Cùng chung tay xây dựng mở rộng sân chơi cho trẻ em ở bờ vở sông Hồng để loại bỏ những hệ quả tâm lý và thể chất cho trẻ sau đại dịch Covid-19', N'https://static.mservice.io/blogscontents/momo-upload-api-230216133948-638121515889398519.jpg', N'<p>Đại dịch Covid-19 là một cú sốc gây thiệt hại lớn đến toàn cầu nói chung và Việt Nam nói riêng. Ngoài các ảnh hưởng hiện hữu dễ dàng có thể nhận ra về mặt kinh tế, xã hội, Covid 19 còn làm dấy lên những lo ngại về sức khỏe tâm trí của một thế hệ trẻ em bị cô lập trong đại dịch.</p>

<p>Cuối năm 2021, Quỹ Nhi đồng Liên Hợp Quốc (UNICEF) đã đưa ra báo cáo cảnh báo về những tác động, hậu quả khôn lường của Covid 19 đến sức khỏe tâm trí và tinh thần của trẻ em, thanh thiếu niên. Tác động này đến từ những đợt phong tỏa toàn quốc và việc hạn chế di chuyển liên quan đến đại dịch đã khiến các em phải trải qua những năm tháng cuộc đời khó quên khi phải rời xa gia đình, bạn bè, trường lớp, việc vui chơi – những yếu tố then chốt của tuổi thơ. Những rối loạn tâm trí được chẩn đoán phổ biến ở trẻ bao gồm rối loạn tăng động giảm chú ý (ADHD), lo âu, tự kỷ, rối loạn lưỡng cực, rối loạn cư xử, trầm cảm, rối loạn ăn uống, khuyết tật trí tuệ,… có thể gây tổn hại đáng kể đến sức khỏe, việc học tập, kết quả cuộc sống sau này của trẻ em và thanh thiếu niên.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230216134033-638121516332471965.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230216134046-638121516466335854.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Covid 19 làm dấy lên những lo ngại về sức khỏe tâm trí của một thế hệ trẻ em bị cô lập trong đại dịch</em></p>

<p>Hơn lúc nào hết, trẻ em, đặc biệt là những bạn nhỏ sống ở thành phố hiện tại đang rất cần những không gian công cộng, nơi vui chơi, sinh hoạt cộng đồng để hàn gắn những vết thương tâm lý hậu đại dịch. Những sân chơi xanh là giải pháp tối ưu giúp trẻ hòa mình cùng thiên nhiên, hít thở không khí trong lành và thoải mái vui đùa. Một trong những không gian tiềm năng và phù hợp để kiến tạo sân chơi cho trẻ em chính là khu vực bờ vờ sông Hồng.</p>

<p>Đoạn bờ vở sông Hồng từ Đền Sơn Hải tới ngách 43/32 đường Bạch Đằng (GPS: 21.03147363882461, 105.86016905629931) kéo dài 150 mét, là vùng đất sát sông Hồng có hệ thực vật phong phú, đa tầng. Sau nhiều nỗ lực cải tạo môi trường của người dân, chính quyền và các tổ chức xã hội, nơi đây đang từng bước thay đổi trở thành một công viên sinh thái đa dạng kết nối con người với dòng sông. Quanh khu vực này có khoảng 500 hộ gia đình với hơn 400 trẻ em đủ mọi lứa tuổi đang sinh sống. Tuy nhiên trong khu chỉ có một sân chơi nhỏ ngoài trời với ít thiết bị không đáp ứng đủ nhu cầu. Thực tế dẫn đến một nhu cầu cấp thiết bổ sung không gian vui chơi công cộng để bờ vở trở thành điểm đến hấp dẫn, lý thú cho tất cả trẻ em.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230216134103-638121516636810180.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Những sân chơi xanh là giải pháp tối ưu giúp trẻ hòa mình cùng thiên nhiên</em></p>

<p>Việc xây dựng sân chơi sẽ bao gồm mở rộng và bổ sung các thiết bị mới và tổ chức các hoạt động tham quan, vui chơi cho trẻ em tại bờ Vở. Hiện tại khu vực bờ vở đang trong quá trình cải tạo môi trường hướng đến mục tiêu trở thành một công viên đa dạng sinh thái. Những sân chơi dưới tán cây, dung hòa với thiên nhiên cùng với sự hiện diện của trẻ em là một phần không thể thiếu trong mục tiêu phát triển của công viên. Để hoạt động xây dựng sân chơi được triển khai cần nguồn tài chính và sự chung tay ủng hộ của mọi người.</p>

<p>Với mong muốn mọi đứa trẻ đều có không gian vui chơi, trải nghiệm thiên nhiên và cải tạo sức khỏe tâm trí, MoMo phối hợp cùng các tổ chức Vì một Hà Nội đáng sống với đại diện là Think Playgrounds, và nhà tài trợ Đại sứ quán New Zealand tại Việt Nam, Investing in Women (IW) lên kế hoạch quyên góp để thực hiện hoạt động xây dựng sân chơi cho trẻ em tại bờ vở sông Hồng. Hoạt động này nằm trong dự án dài hơi, góp phần cải thiện môi trường và không gian sống của Hà Nội.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230216134123-638121516834864128.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chung tay giúp các em nhỏ có không gian công cộng để vui chơi và sáng tạo</em></p>

<p>Để làm được điều này, chúng tôi dự tính dự án cần tổng số tiền là 464.000.000 đồng. Chúng tôi mong muốn có thể gây quỹ 100.000.000 đồng trên Trái Tim MoMo để có thể triển khai các hoạt động xây dựng sân chơi cho trẻ em ở bờ vở sông Hồng. Ngoài ra, chúng tôi còn kêu gọi cộng đồng Heo Đất MoMo quyên góp 1.820.000 Heo Vàng tương ứng với số tiền là 364.000.000 đồng.</p>

<p>Số tiền mà bạn ủng hộ sẽ được sử dụng cho các hoạt động:</p>

<ul>
	<li>Thiết kế và thi công sân chơi dưới tán cây tại công viên bờ vở sông Hồng;</li>
	<li>Tổ chức các chương trình cho trẻ em, học sinh tham quan và vui chơi cải thiện sức khỏe tâm trí tại khu vực bờ vở.</li>
</ul>

<p>Các hoạt động này sẽ giúp các bạn nhỏ ở khu vực bờ vở cũng như trẻ em trên toàn thành phố có thêm một địa điểm vui chơi, trải nghiệm gần gũi và thân thiện với thiên nhiên; có thêm những tour tham quan kích thích tinh thần học hỏi, sáng tạo. Từ đó sẽ góp phần nâng cao kiến thức, kỹ năng và sức khỏe tâm trí cho trẻ.</p>

<p>Mọi sự đóng của các bạn đều góp phần kiến tạo nên không gian vui chơi lành mạnh, bổ ích cho trẻ em. Hãy cùng chung tay vì một thế hệ trẻ được vui chơi và phát triển toàn diện!</p>

<p><u><strong>Về Đại sứ quán New Zealand tại Việt Nam:</strong></u><br />
Sau hơn 40 năm thiết lập quan hệ ngoại giao, New Zealand luôn được biết đến là một trong những đối tác chiến lược và thân thiện của Việt Nam. Đại sứ quán New Zealand tại Việt Nam rất quan tâm đến các dự án phát triển, viện trợ hướng đến các cộng đồng dễ bị tổn thương tại Việt Nam. Đại sứ quán tham gia dự án xây dựng không gian xanh cho các thanh thiếu niên tại bờ vở sông Hồng với mục đích giúp các em khắc phục một số vấn đề về sức khỏe tinh thần sau đại dịch COVID-19.</p>

<p><u><strong>Về Investing in Woman (IW):</strong></u><br />
Investing in Woman (IW) là một sáng kiến ​​của Chính phủ Úc, thúc đẩy tăng trưởng kinh tế bao trùm thông qua trao quyền kinh tế cho phụ nữ ở Đông Nam Á. Được thành lập vào năm 2016, IW giải quyết một trong những vấn đề kinh tế và xã hội quan trọng nhất của thời đại chúng ta: bất bình đẳng giới. IW sử dụng các phương pháp tiếp cận sáng tạo để cải thiện sự tham gia kinh tế của phụ nữ với tư cách là nhân viên và doanh nhân, đồng thời tác động đến môi trường thuận lợi để thúc đẩy trao quyền kinh tế của phụ nữ ở Philippines, Indonesia, Việt Nam và Myanmar. IW tham gia dự án với mục đích xây dựng không gian cộng đồng, sân chơi, khu tập thể dục thể thao dành cho đa dạng lứa tuổi, giới tính ở bờ vở.</p>

<p><u><strong>Về Think Playgrounds:</strong></u><br />
Think playgrounds (TPG) là một doanh nghiệp xã hội được thành lập với sứ mệnh vận động cho “Quyền được chơi” của trẻ em thông qua việc chung tay cải tạo các không gian công cộng xanh sinh thái thân thiện với trẻ em và với môi trường (sân chơi tái chế, vườn cộng đồng, công viên nhỏ, tác phẩm nghệ thuật cộng đồng….) Cho đến cuối năm 2022, TPG cùng các đối tác đã xây dựng hơn 230 sân chơi công cộng và vườn cộng đồng trên cả nước, thử nghiệm mô hình sân chơi phiêu lưu đầu tiên ở VN, tổ chức hơn 30 sự kiện chơi trên phố, ngày vui chơi, chơi tái chế... ở Hà Nội và TP HCM. Trong mảng kinh doanh, TPG đã thực hiện gần 100 sân chơi cho các trường học tư nhân, trang trại giáo dục và các khu đô thị mới. 50% lợi nhuận trong mảng kinh doanh được sử dụng để duy trì các sân chơi công cộng trong thành phố.</p>

<p><u><strong>Về tổ chức Vì một Hà Nội đáng sống (VMHNĐS):</strong></u><br />
Vì một Hà Nội đáng sống là một mạng lưới của những cá nhân và tổ chức đang sống và làm việc ở Hà Nội, yêu Hà Nội, và có mong muốn đóng góp để cải thiện không gian công cộng, môi trường, và văn hóa của thành phố. Bên cạnh các hoạt động hướng đến người lao động di cư, quan tâm đến những người yếu thế trong xã hội, mạng lưới VMHNĐS đã thực hiện nhiều dự án giúp nâng cao chất lượng cuộc sống cho người dân thông qua mở rộng không gian công cộng, giảm thiểu ô nhiễm môi trường. Gần đây nhất là các dự án cải tạo “bãi rác” ở Chương Dương (Hoàn Kiếm) thành tổ hợp không gian đa chức năng, trong đó có vườn rừng cộng đồng, sân chơi với mong muốn đóng góp tạo ra một Hà Nội đáng sống cho tất cả mọi người.</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-04-23' AS Date), N'Enable', 1, 4)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (3, N'Hỗ trợ thiết bị chăm sóc trẻ sơ sinh cho Trung tâm Y tế huyện Điện Biên Đông, Điện Biên', N'Cùng chương trình Nâng niu Sự sống hỗ trợ thiết bị chăm sóc trẻ sơ sinh để các em bé được điều trị và chăm sóc cơ bản ngay từ khi chào đời.', N'https://static.mservice.io/blogscontents/momo-upload-api-230215135642-638120662021465935.jpg', N'<p>Điện Biên Đông là một huyện của tỉnh Điện Biên, thuộc vùng núi phía bắc có địa hình núi non hiểm trở, bị chia cắt bởi nhiều khe suối, vực sâu, đồi núi chiếm 90% đất tự nhiên. Đây là nơi sinh sống của gần 54.000 người thuộc 6 đồng bào dân tộc: Mông, Thái, Lào, Khơ Mú, Sinh Mun, Kinh và các dân tộc khác. Trong đó người Mông chiếm đa số với hơn 53%. Năm 2021, Điện Biên Đông nằm trong danh sách một trong 74 huyện nghèo nhất của cả nước theo quyết định số 353 của Thủ tướng Chính phủ.</p>

<p>Trung tâm Y tế huyện Điện Biên Đông là cơ sở y tế có năng lực cao nhất trong vùng và điều trị cho toàn bộ bệnh nhân đến từ 13 xã, 1 thị trấn của huyện và các khu vực lân cận. Số lượng bệnh nhi vì thế cũng rất đông, nhưng việc thiếu các trang thiết bị y tế thiết yếu cũng như năng lực đội ngũ y bác sĩ còn bị hạn chế cho nên trung tâm y tế sẽ không thể có đủ năng lực cứu chữa cho các bé. Theo báo cáo năm 2021, tỷ lệ tử vong ở trẻ sơ sinh của huyện vẫn còn rất cao 100%₀, và 67%₀ đối với trẻ dưới 5 tuổi, điều này có nghĩa là cứ 1000 trẻ được sinh ra thì 100 trẻ phải tử vong do gặp các biến chứng sau sinh, rất cần sự can thiệp kịp thời của y bác sĩ nhưng vì thiếu máy móc và kỹ năng định bệnh cho nên các bé đã không được cứu chữa kịp thời, gây đau thương và mất mát cho gia đình đặc biệt là các bà mẹ.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230215135727-638120662470819512.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230215135742-638120662620456478.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Theo báo cáo năm 2021, cứ 1.000 trẻ được sinh ra thì 100 trẻ tử vong do gặp các biến chứng sau sinh.</em></p>

<p>Với đặc trưng khí hậu và địa hình vùng núi, đa phần các bé đến trung tâm khi bệnh đã chuyển nặng, nhất là các chứng bệnh viêm phổi nặng, viêm màng não, ngạt nặng sau sinh, sinh non, vv. Đây đều là những bệnh rất cần sự can thiệp y tế nhanh chóng, chính xác và đúng cách. Việc chuyển bệnh đối với Điện Biên Đông cũng là một thách thức vô cùng to lớn, bởi khoảng cách từ trung tâm y tế đến bệnh viện đa khoa tỉnh là khoảng hơn 50km, nhưng với địa hình đồi núi và khúc khuỷu nên con đường chuyển viện lại càng gian nan hơn rất nhiều.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230215135757-638120662777281786.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Với địa hình đồi núi và khúc khuỷu nên con đường chuyển viện của các bệnh nhi lại càng gian nan hơn rất nhiều</em></p>

<p>Với mục tiêu mong muốn giảm thiểu tỷ lệ tử vong ở trẻ sơ sinh tại các vùng sâu, vùng xa, vùng đặc biệt khó khăn, chương trình Nâng niu Sự sống được thiết kế nhằm trang bị các thiết bị y tế chăm sóc sơ sinh thiết yếu cùng với đào tạo về sử dụng trang thiết bị để các bác sĩ và y tá ở vùng nông thôn, vùng sâu vùng xa như Điện Biên có thể thực hiện việc chăm sóc cơ bản và cấp cứu cho những em bé ngay từ khi mới lọt lòng.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230215135815-638120662953039365.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chung tay gây quỹ hỗ trợ thiết bị y tế cho Trung tâm Y tế huyện Điện Biên Đông</em></p>

<p>Thông qua kênh quyên góp của MoMo, chương trình Nâng niu Sự sống đặt mục tiêu gây quỹ 245.000.000 đồng từ các nhà hảo tâm để nhanh chóng có đủ kinh phí hỗ trợ các thiết bị y tế cho Trung tâm Y tế huyện Điện Biên Đông. Các thiết bị bao gồm:</p>

<ul>
	<li>1 máy thở áp lực dương liên tục (CPAP) để điều trị suy hô hấp cấp,</li>
	<li>1 đèn chiếu để điều trị bệnh vàng da ở trẻ sơ sinh,</li>
	<li>1 giường sưởi ấm trẻ sơ sinh kết hợp đèn chiếu vàng da để các bé vừa được chiếu đèn, vừa được giữ ấm dưới tiết trời giá lạnh,</li>
	<li>1 bơm truyền dịch,</li>
	<li>1 máy monitor theo dõi bệnh nhi,</li>
	<li>1 bóp bóng ambu để giúp thông khí khi các bé bị ngạt.</li>
</ul>

<p>Toàn bộ các trang thiết bị này sẽ được lắp đặt cho Trung tâm Y tế huyện Điện Biên Đông tại tỉnh Điện Biên nhằm nâng cao năng lực chăm sóc và điều trị bệnh lý sơ sinh, giảm tỷ lệ chuyển tuyến và giảm tỷ lệ tử vong sơ sinh ở các vùng sâu, vùng xa.</p>

<p>Mọi sự đóng góp dù lớn hay nhỏ của Quý vị cũng sẽ giúp giảm thiểu tỉ lệ tử vong của trẻ sơ sinh ở huyện Điện Biên Đông, đồng thời giúp cho trẻ sơ sinh cùng gia đình được tiếp cận với nền y tế tiến bộ hơn.</p>

<p><em>*Sau khi hoàn tất chiến dịch kêu gọi đóng góp, số tiền 245.000.000 đồng sẽ được chuyển đến dự án Nâng niu Sự sống sử dụng để tiến hành dự án. Chúng tôi sẽ cập nhật thêm thông tin về tiến độ dự án đến Quý vị trong thời gian sớm nhất.</em></p>

<p><u><strong>Về Chương trình Nâng niu Sự sống:</strong></u><br />
Chương trình Nâng Niu Sự Sống được triển khai từ năm 2009 nhằm hỗ trợ cải thiện năng lực nhi khoa thông qua trao tặng các thiết bị chăm sóc trẻ sơ sinh thiết yếu và tập huấn sử dụng các trang thiết bị một cách hiệu quả. Thông qua những hoạt động này, Nâng niu Sự sống hướng tới mục tiêu giảm tỷ lệ tử vong của trẻ sơ sinh trên khắp cả nước bằng cách cung cấp hỗ trợ kịp thời trong việc chăm sóc cho trẻ sơ sinh cho các trung tâm y tế. Kể từ khi thành lập đến tháng 9/2022, chương trình Nâng niu Sự sống đã trao tặng 542 thiết bị chăm sóc sơ sinh cho các khoa hồi sức cấp cứu sơ sinh của 145 bệnh viện và trung tâm y tế tại Thành phố Hồ Chí Minh, Đà Nẵng, Kon Tum, Cao Bằng, Sơn La, Bắc Kạn, Hà Giang, Lai Châu, Yên Bái, Khánh Hòa, Quảng Nam và Quảng Ngãi, và điều trị cho 123.835 trẻ sơ sinh.</p>

<p>Kể từ khi bắt đầu hợp tác với MoMo, tính đến tháng 3/2022, chương trình Nâng niu Sự sống đã nhận được tổng nguồn hỗ trợ là 250.000.000 VNĐ giúp hỗ trợ các thiết bị chăm sóc trẻ sơ sinh bao gồm 1 máy thở áp lực dương liên tục (CPAP) để điều trị suy hô hấp cấp, 1 máy đo oxy SPO2, 2 bơm tiêm điện, 2 bộ đặt nội khí quản và 4 giường sơ sinh cho Trung tâm Y tế huyện Mường Tè tại tỉnh Lai Châu.</p>
', 200000000, CAST(N'2022-11-19' AS Date), CAST(N'2023-03-19' AS Date), N'Enable', 6, 4)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (4, N'Chung tay hỗ trợ 120 hộ gia đình khó khăn có vốn phát triển kinh tế cho năm 2023 (Đợt 1)', N'Lạm phát ở mức cao, lãi suất ngân hàng ngày càng tăng, biên giới giao thương với Trung Quốc đóng cửa khiến cho cuộc sống của nhiều hộ gia đình tại các vùng quê nghèo ngày càng chật vật', N'https://static.mservice.io/blogscontents/momo-upload-api-230213132800-638118916805012378.jpg', N'<p>“Mấy cây lũ vừa rồi quét qua, giờ nhà anh còn gì đâu em, hết vốn liếng làm ăn rồi nên phải bán hết đất đai, để lại vợ con ở nhà, anh đi nước ngoài làm việc rồi gửi tiền về gia đình.” Đây là lời tâm sự của một trong những người dân nghèo, bởi vì ảnh hưởng nặng nề của thiên tai mà quyết tâm đi đến Ukraina để xuất khẩu lao động. Mặc dù không biết tiếng anh, cũng chưa biết sẽ phải làm công việc gì, thế nhưng họ vẫn quyết tâm rời xa quê hương. Chính là với hy vọng có thêm nguồn thu nhập để cải thiện kinh tế gia đình và giúp các con có chi phí tiếp tục theo đuổi giấc mơ đến trường.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230213132833-638118917130205187.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Một trong những người dân quyết tâm đi xuất khẩu lao động để có thêm thu nhập cho gia đình</em></p>

<p>Những nỗi trăn trở của người nông dân không phải ai cũng biết được. Nhiều người sinh sống ở những thành phố lớn, có thể dễ dàng phàn nàn về việc giá một bó rau, một loại trái cây có giá cao, thế nhưng họ không hề hay biết những khó khăn vất vả của những người làm nông. Những nông sản được thu mua đều được lựa chọn những loại tốt nhất, chất lượng cao nhất. Vì thế những thiệt hại và rủi ro trong quá trình sản xuất nông nghiệp, người nông dân đều phải tự mình gánh vác.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230213132907-638118917474192655.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230213132918-638118917585161894.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Nông dân gặp nhiều khó khăn trong quá trình sản xuất nông nghiệp</em></p>

<p>Khó khăn càng chồng chất khó khăn khi những hộ nghèo muốn tiếp tục quay vòng vốn thì cần phải vay ngân hàng. Thế nhưng lãi suất cao khiến họ trở nên đắn đo hơn nhiều, bởi họ không thể dự đoán được năm nay sẽ mất mùa hay được mùa, sẽ bán được nông sản giá cao hay giá thấp. Nếu gặp rủi ro thì sẽ không có kinh phí trả nợ cho ngân hàng và chi phí sinh hoạt cho cả gia đình cũng hao hụt đi rất nhiều.</p>

<p>Sau 17 năm làm việc với cộng đồng khó khăn, Thiện Chí hiểu rõ cộng đồng hơn bao giờ hết. Nhu cầu của hộ khó khăn chỉ từ 3-5 triệu, và cần sự theo dõi hỗ trợ kỹ thuật. Dự án sẽ hỗ trợ cho 240 hộ khó khăn. Trong đó đợt quyên góp này, với sự hỗ trợ từ cộng đồng MoMo sẽ có 120 hộ khó khăn nhận được vốn (5 triệu đồng) để phát triển kinh tế. Chúng tôi mong muốn kêu gọi cộng đồng các nhà hảo tâm Trái Tim MoMo gây quỹ số tiền 105.000.000 đồng. Ngoài ra chúng tôi còn kêu gọi cộng đồng Yêu Heo Đất ủng hộ 495.000.000 đồng thông qua Heo Đất MoMo.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230213132946-638118917864297423.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230213132959-638118917994183740.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chung tay giúp các hộ dân nghèo có thêm nguồn vốn để tiếp tục phát triển kinh tế</em></p>

<p>Sau khi hỗ trợ vốn, Thiện Chí sẽ tập huấn kiến thức cho hộ và thăm hộ hàng tháng để đảm bảo rằng hộ có đủ kỹ thuật trồng trọt chăn nuôi, và hạn chế tối đa rủi ro từ đồng vốn vay. Vốn hỗ trợ cho bà con đảm bảo 0% lãi suất.</p>

<p>Sự đồng hành từ cộng đồng MoMo sẽ là món quà quý giá nhất cho cộng đồng nghèo cho năm mới 2023. Dự án sẽ hỗ trợ cho tổng cộng 240 hộ khó khăn và được chia thành 2 đợt:</p>

<ul>
	<li>Đợt 1: Quyên góp &amp; Hỗ trợ 120 hộ vào tháng 2/2023</li>
	<li>Đợt 2: Quyên góp &amp; Hỗ trợ 120 hộ vào tháng 3/2023</li>
</ul>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230213133025-638118918251924044.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Không chỉ hỗ trợ vốn, Thiện Chí còn tập huấn kiến thức cho bà con</em></p>

<p><u><strong>Về Thiện Chí:</strong></u><br />
Thiện Chí là một tổ chức Phi Chính phủ, hoạt động trong lĩnh vực phát triển cộng đồng từ năm 2005 tại Bình Thuận (Tánh Linh, Đức Linh, Hàm Thuận Nam). Các hoạt động của Thiện Chí 100% là hỗ trợ các hộ khó khăn phát triển kinh tế, học bổng cho các học sinh nghèo, tạo việc làm cho phụ nữ nghèo, các chương trình trường học như giới tính, vệ sinh răng miệng, môi trường.</p>

<p>Mỗi năm Thiện Chí hỗ trợ cho hơn 2,000 hộ khó khăn phát triển kinh tế, hơn 1,500 học bổng cho các em học sinh cấp 1,2,3. Gần 100 người thất nghiệp có thu nhập trung bình hơn 2,000,000đ/tháng với những công việc part-time từ Thiện Chí, trung bình hơn 20,000 trẻ em, học sinh tiểu học, THCS có các kiến thức về vệ sinh răng miệng, giáo dục giới tính mỗi năm. Với kinh nghiệm làm việc với cộng đồng hơn 17 năm qua, chúng tôi và cộng đồng luôn là một. Và chúng tôi làm việc với một đội ngũ nhân sự kinh nghiệm và nhiệt huyết với cộng đồng khó khăn.</p>
', 150000000, CAST(N'2022-12-08' AS Date), CAST(N'2023-03-19' AS Date), N'Enable', 4, 8)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (5, N'Chung tay giúp chú Hùng có chi phí chăm sóc sức khỏe sau những ngày tháng khó khăn', N'Cùng chung tay hỗ trợ chi phí chăm sóc sức khỏe cho chú Hùng, để những ngày tháng cuối đời chú được sống yên bình tại quán trọ', N'https://static.mservice.io/blogscontents/momo-upload-api-230209142223-638115493430633823.jpg', N'<p><strong>Những tháng ngày lưu lạc</strong></p>

<p>Chú Phan Thanh Hùng sinh năm 1948 tại Bến Tre. Chú lớn lên trong thời kỳ kháng chiến chống Mỹ ác liệt tại miền Nam. Những năm tháng ấy, hoàn cảnh gia đình khó khăn, dù còn nhỏ nhưng chú phải ra đồng phụ cha mẹ trong tiếng súng nổ, đạn lạc đầy trời. Trong một lần nghe tiếng đạn, chú sợ hãi chạy loạn theo toán người rồi lưu lạc lên Sài Gòn. Ngót nghét đã hơn 50 năm, chú sống ngoài vỉa hè.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209142305-638115493852876006.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209142316-638115493960504120.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chú Hùng chưa từng nghĩ bản thân sẽ có được mái nhà ấm cúng những năm tháng cuối đời</em></p>

<p>Sau chừng ấy năm, chú Hùng không nhà cửa, không tiền bạc, cũng không có cách nào liên lạc được với người thân. Chú chỉ còn nhớ mang máng những kỷ niệm xưa và chấp nhận một cuộc sống lấy trời làm nhà, lấy đất làm giường. Chú cũng không biết ngày mai, cuộc sống mình sẽ thế nào khi tuổi cao sức yếu.</p>

<p><strong>Cùng chung tay giúp đỡ chú Hùng để giảm bớt những đau đớn do bệnh tật dày vò</strong></p>

<p>Chú Hùng về ở Quán trọ Trăng Khuyết Quận 8 thấm thoát đã được 5 tháng. Những mỗi khi nghĩ đến chú đều ngỡ như mới ngày hôm qua. Chú tâm sự, bản thân chưa từng nghĩ mình sẽ có được mái nhà ấm cúng những năm tháng cuối đời, hơn nữa còn có thể đùm bọc và chăm sóc nhau giữa những người bạn già cùng cảnh ngộ. May mắn bất ngờ ập tới nên chú càng biết ơn và trân trọng những gì mình nhận được. Tuy chú lớn tuổi, sức khỏe yếu, nhưng luôn hăng hái giúp đỡ mọi người. Từ khuân vác, bưng bê,… tới trang trí Quán trọ đón những ngày lễ tết với niềm vui dạt dào. Chú không biết chữ nhưng vẫn hàng ngày xem hình trên báo, rồi kể lại cho mọi người vô cùng hào hứng. Nhờ thế mà mọi người trong quán trọ không ngớt những trận cười vui vẻ.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209142339-638115494192986800.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209142357-638115494374319989.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chú Hùng luôn hăng hái giúp đỡ mọi người và nhận nhiều công việc trong quán trọ để đỡ đần các cụ khác</em></p>

<p>Dẫu chú sống tích cực và lạc quan nhưng hơn 50 năm sống ngoài sương gió, khi tuổi đã cao, sức khỏe chú cũng dần suy yếu. Chú vẫn luôn đau nhức khi trái gió trở trời, hay những trận ho dai dẳng.</p>

<p>Với mong muốn giúp chú Hùng có thêm kinh phí khám chữa bệnh, Ví MoMo phối hợp cùng Quỹ Từ Thiện &amp; BTXH Trăng Khuyết kêu gọi cộng đồng cùng chung tay gây quỹ số tiền 30.000.000 đồng. Toàn bộ số tiền này sau khi kêu gọi được sẽ được dùng làm chi phí hỗ trợ khám chữa bệnh cho chú Hùng.</p>

<p>Rất mong các mạnh thường quân, các nhà hảo tâm sẽ đồng hành cùng chương trình quyên góp lần này của MoMo và Trăng Khuyết để hỗ trợ cho những số phận đơn chiếc. Dù đóng góp nào cũng đều đáng quý, cùng là tình yêu thương đong đầy của của cô chú, anh chị dành cho các cụ già neo đơn.</p>

<p><em>*Sau khi hoàn tất chiến dịch kêu gọi đóng góp, MoMo sẽ chuyển toàn bộ số tiền 30.000.000 đồng đã gây quỹ gửi đến Quỹ Từ Thiện &amp; BTXH Trăng Khuyết hỗ trợ chi phí khám chữa bệnh cho chú Hùng. Chúng tôi sẽ cập nhật thêm thông tin về tiến độ dự án đến Quý vị trong thời gian sớm nhất. </em></p>

<p><strong><u>Về Quỹ Từ Thiện &amp; BTXH Trăng Khuyết:</u></strong><br />
Trăng Khuyết là một tổ chức từ thiện về nhân đạo và sự sống, nhằm kết nối cộng đồng và thực hiện các hoạt động trợ giúp trực tiếp cho các cụ già không nơi nương tựa và trẻ em bị bỏ rơi. Thông qua các hoạt động: cứu trợ khẩn cấp, cung cấp bữa ăn, chỗ ở và cải thiện cuộc sống. Trăng Khuyết hoạt động độc lập, phi tôn giáo và phi lợi nhuận trên toàn lãnh thổ Việt Nam. Thông qua pháp nhân là Quỹ Từ Thiện &amp; BTXH Trăng Khuyết, một doanh nghiệp xã hội, hoạt động 100% vì cộng đồng.</p>

<p>*MoMo biết rằng còn rất nhiều hoàn cảnh khó khăn trên khắp đất nước của chúng ta cần được bảo trợ. Bạn hay các công ty hãy liên hệ với chúng tôi để cùng tài trợ, giúp đỡ tạo nên một cộng đồng Việt Nam nhân ái nhé! donation@mservice.com.vn</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-03-19' AS Date), N'Enable', 4, 10)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (6, N'Giúp chú Minh có thêm chi phí thuốc men và khám suy tim khi về già quạnh hiu', N'Cùng chung tay giúp chú Minh có kinh phí khám chữa bệnh, sống an vui những ngày tháng tuổi già tại Quán trọ Trăng Khuyết Q.8', N'https://static.mservice.io/blogscontents/momo-upload-api-230209141427-638115488679470036.jpg', N'<p><strong>Dành nửa đời người báo hiếu, chú Minh giữ trọn đạo làm con</strong></p>

<p>Chú tên Nguyễn Hữu Minh sinh năm 1963. Chú sinh ra và lớn lên ở Sài Gòn. Chú Minh đam mê và tâm huyết với công việc ở đài truyền hình. Nhưng ước mơ ấy cũng dần dang dở vì ba mẹ chú Minh bệnh nặng. Ba chú Minh bị biến chứng tai biến 14 năm nên nằm liệt giường. Cũng là ngần ấy năm chú một thân một mình chăm sóc cho ba. Chưa hết khó khăn này tới khó khăn khác ập tới, khi mẹ chú cũng không may bị té gãy xương đùi nằm một chỗ suốt 8 năm.</p>

<p>Thanh xuân của chú cũng dần đi theo những lần bán tài sản trong gia đình để chạy chữa cho ba mẹ. Chú Minh chỉ còn biết bám víu vào ước mơ với nghề. Thế nhưng chú cũng đành từ bỏ bởi công việc không thể cứ trì hoãn để chờ đợi chú.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209141506-638115489069796534.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chú Minh dành hơn nửa đời để chăm sóc cho cha mẹ bệnh tật mà không màng đến điều gì</em></p>

<p>Mẹ chú mất khi chú 55 tuổi. Nhìn lại quanh mình, chú chỉ còn tuổi già đang ập tới và sự cô độc. Bởi chú vì thương ba mẹ già, vì chữ hiếu nên sống lủi thủi chăm sóc ba mẹ. Đến khi chợt nghĩ đến hạnh phúc cho riêng mình, muốn tìm bạn đời thì cũng đã trễ. Tuổi không còn trẻ, tiền cũng chẳng có. Chú lầm lũi bắt đầu công việc bán bánh bò và khoai mì để tự nuôi sống bản thân trong căn nhà trọ.</p>

<p><strong>Cùng chung tay giúp đỡ chú Minh</strong></p>

<p>Tiếng rao hàng của chú vang khắp nẻo đường Sài Gòn. Nhưng chẳng còn mấy người mua, không ít ngày chú phải ăn bánh bò, khoai mì trừ cơm. Trong một lần, chú lên cơn suy tim, ngã khuỵu giữa đường, được người dân đưa vào bệnh viện Nguyễn Tri Phương.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209141700-638115490203795352.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209141712-638115490320327309.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chú hạnh phúc khi nhận được món quà và sự quan tâm của các mạnh thường quân</em></p>

<p>Sau 1 tháng điều trị, chú được bệnh viện gửi gắm đến Quán trọ Trăng Khuyết. Đối với chú Minh, những ngày tháng sống bên những người bạn già, ngỡ như một phép màu. Chú không còn phải lo cơm ăn áo mặc, không còn phải nghĩ suy về những tháng ngày còn lại của tuổi già. Vậy nhưng căn bệnh suy tim khiến sức khỏe chú lại ngày suy yếu, không thể đi làm để có thêm nguồn chi phí cho việc khám và chữa bệnh.</p>

<p>Với mong muốn giúp chú Minh có thêm kinh phí khám chữa bệnh, ví MoMo phối hợp cùng Quỹ Từ Thiện &amp; BTXH Trăng Khuyết kêu gọi số tiền 30.000.000 VNĐ. Toàn bộ số tiền này sau khi kêu gọi được sẽ được dùng làm chi phí hỗ trợ khám chữa bệnh cho chú Minh.</p>

<p>Rất mong các mạnh thường quân, các nhà hảo tâm sẽ đồng hành cùng chương trình quyên góp lần này của MoMo và Trăng Khuyết hỗ trợ cho những số phận đơn chiếc. Dù đóng góp nào cũng đều đáng quý, cùng là tình yêu thương đong đầy của của cô chú, anh chị dành cho các cụ già neo đơn.</p>

<p><em>*Sau khi hoàn tất chiến dịch kêu gọi đóng góp, MoMo sẽ chuyển toàn bộ số tiền 30.000.000 đồng đã gây quỹ gửi đến Quỹ Từ Thiện &amp; BTXH Trăng Khuyết hỗ trợ chi phí khám chữa bệnh cho chú Minh. Chúng tôi sẽ cập nhật thêm thông tin về tiến độ dự án đến Quý vị trong thời gian sớm nhất. </em></p>

<p><u><strong>Về Quỹ Từ Thiện &amp; BTXH Trăng Khuyết:</strong></u><br />
Trăng Khuyết là một tổ chức từ thiện về nhân đạo và sự sống, nhằm kết nối cộng đồng và thực hiện các hoạt động trợ giúp trực tiếp cho các cụ già không nơi nương tựa và trẻ em bị bỏ rơi. Thông qua các hoạt động: cứu trợ khẩn cấp, cung cấp bữa ăn, chỗ ở và cải thiện cuộc sống. Trăng Khuyết hoạt động độc lập, phi tôn giáo và phi lợi nhuận trên toàn lãnh thổ Việt Nam. Thông qua pháp nhân là Quỹ Từ Thiện &amp; BTXH Trăng Khuyết, một doanh nghiệp xã hội, hoạt động 100% vì cộng đồng</p>

<p>*MoMo biết rằng còn rất nhiều hoàn cảnh khó khăn trên khắp đất nước của chúng ta cần được bảo trợ. Bạn hay các công ty hãy liên hệ với chúng tôi để cùng tài trợ, giúp đỡ tạo nên một cộng đồng Việt Nam nhân ái nhé! donation@mservice.com.vn</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-03-19' AS Date), N'Enable', 4, 10)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (7, N'Cùng giúp ông Trịnh Ngưu ở tuổi 80 vẫn còn lượm ve chai có cuộc sống an vui cuối đời', N'Chung tay giúp ông Minh có kinh phí khám chữa bệnh, sống an vui những ngày tháng tuổi già tại Quán trọ Trăng Khuyết Quận 8', N'https://static.mservice.io/blogscontents/momo-upload-api-230209140451-638115482915040786.jpg', N'<p><strong>80 tuổi ông Trịnh Ngưu vẫn miệt mài mưu sinh</strong></p>

<p>80 tuổi là độ tuổi mà nhiều người đã được an hưởng tuổi già, vui sống cùng con cháu thì ông Trịnh Ngưu vẫn ngày ngày lượm ve chai để kiếm sống. Gương mặt hiền lành, mái tóc bạc trắng, ông luôn tạo thiện cảm cho những người xung quanh nên họ luôn thương quý. Chẳng ai ngờ rằng phía sau nụ cười ấy là một cuộc sống cô độc. Ông Trịnh Ngưu là người Hoa, quê quán ở Trung Quốc. Cuộc sống ở quê nhà nghèo khó nên ông theo cha mẹ sang Việt Nam để tìm công việc.</p>

<p>Nhưng chẳng bao lâu thì cha mẹ ông mất, ông bơ vơ sống tại căn nhà trọ ở Quận Bình Tân. Khi còn trẻ, ông làm đủ nghề để có cái ăn cái mặc. Ông cũng không có vợ con. Bởi ông không muốn làm khổ người khác khi ông chẳng có gì ngoài hai bàn tay trắng.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209140529-638115483295599410.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Khi sức khỏe trở nên suy yếu ông Trịnh Ngưu đã về sống cùng nhiều cụ già tại Quán trọ Trăng Khuyết, Quận 8</em></p>

<p>Tháng rộng ngày dài, tuổi tác càng cao, sức khỏe ông càng yếu. Những công việc nặng nhọc, không đòi hỏi trình độ đã không còn phù hợp với ông. Ông đành chuyển sang lượm ve chai. Chừng ấy đồng cũng không đủ ông duy trì cuộc sống ở nhà trọ. Càng ngày số tiền ông kiếm được càng ít đi. Cuối cùng ông cũng đành chấp nhận cuộc sống của kẻ túng quẫn, dưới mái hiên nhà người khác, là mái nhà người ta.</p>

<p><strong>Luôn san sẻ những người kém may mắn</strong></p>

<p>Vì sống khổ cực, ông Trịnh Ngưu cũng thấu hiểu và đồng cảm với những phận đời tương tự. Khi ông nhận được quà bánh hay được cho tiền, ông chưa bao giờ giữ hết cho mình. Ông luôn san sẻ với mọi người. Bởi đức tính ấy, mà ông được nhiều người yêu mến.</p>

<p>Cực khổ lúc trẻ, về già chẳng thảnh thơi. Ngoài căn bệnh lãng tai của người già, ông còn bị đau nhức xương khớp nặng. Những khi trái gió trở trời, ông đau nhức không thể nào ngủ được.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209140606-638115483662403759.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230209140619-638115483791435285.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chung tay giúp ông Trịnh Ngưu có thêm kinh phí khám chữa bệnh để giảm bớt nỗi đau bệnh tật</em></p>

<p>Với mong muốn giúp ông Trịnh Ngưu có thêm kinh phí khám chữa bệnh, ví MoMo phối hợp cùng Quỹ Từ Thiện &amp; BTXH Trăng Khuyết kêu gọi số tiền 30.000.000 VNĐ. Toàn bộ số tiền này sau khi kêu gọi được sẽ được dùng làm chi phí hỗ trợ khám chữa bệnh cho ông Trịnh Ngưu.</p>

<p>Rất mong các mạnh thường quân, các nhà hảo tâm sẽ đồng hành cùng chương trình quyên góp lần này của MoMo và Trăng Khuyết để những cuộc đời đơn độc này lần nữa được sống trong yêu thương của cộng đồng.</p>

<p><em>*Sau khi hoàn tất chiến dịch kêu gọi đóng góp, MoMo sẽ chuyển toàn bộ số tiền 30.000.000 đồng đã gây quỹ gửi đến Quỹ Từ Thiện &amp; BTXH Trăng Khuyết hỗ trợ chi phí khám chữa bệnh cho ông Trịnh Ngưu. Chúng tôi sẽ cập nhật thêm thông tin về tiến độ dự án đến Quý vị trong thời gian sớm nhất. </em></p>

<p><strong><u>Về Quỹ Từ Thiện &amp; BTXH Trăng Khuyết:</u></strong><br />
Trăng Khuyết là một tổ chức từ thiện về nhân đạo và sự sống, nhằm kết nối cộng đồng và thực hiện các hoạt động trợ giúp trực tiếp cho các cụ già không nơi nương tựa và trẻ em bị bỏ rơi. Thông qua các hoạt động: cứu trợ khẩn cấp, cung cấp bữa ăn, chỗ ở và cải thiện cuộc sống. Trăng Khuyết hoạt động độc lập, phi tôn giáo và phi lợi nhuận trên toàn lãnh thổ Việt Nam. Thông qua pháp nhân là Quỹ Từ Thiện &amp; BTXH Trăng Khuyết, một doanh nghiệp xã hội, hoạt động 100% vì cộng đồng</p>

<p>*MoMo biết rằng còn rất nhiều hoàn cảnh khó khăn trên khắp đất nước của chúng ta cần được bảo trợ. Bạn hay các công ty hãy liên hệ với chúng tôi để cùng tài trợ, giúp đỡ tạo nên một cộng đồng Việt Nam nhân ái nhé!</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-03-19' AS Date), N'Enable', 4, 10)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (8, N'Cùng Quỹ Hy Vọng xây mới nhà vệ sinh cho các em học sinh huyện Mường Nhé, tỉnh Điện Biên (Đợt 2)', N'Dự án Vệ sinh học đường sẽ giúp các em học sinh vùng cao thuộc huyện Mường Nhé, tỉnh Điện Biên sẽ không phải sử dụng những lán vệ sinh tạm bợ khi có sự chung tay của cộng đồng cùng Quỹ Hy Vọng.', N'https://static.mservice.io/blogscontents/momo-upload-api-230206111121-638112786815454308.jpg', N'<p><strong>Những công trình vệ sinh tạm tại Mường Nhé</strong></p>

<p>Quá tải, xuống cấp, hư hỏng... là tình trạng chung của nhiều nhà vệ sinh trường học vùng cao, trong đó có huyện Mường Nhé, tỉnh Điện Biên.</p>

<p>Tại điểm trường Nậm Mì 1 (Trung tâm), thuộc trường Tiểu học Huổi Lếch, huyện Mường Nhé, hơn 300 em học sinh và gần 20 giáo viên sử dụng chung một nhà vệ sinh quây tạm bằng tôn. Hệ thống xử lý chất thải, thoát nước còn chưa được xử lý.</p>

<p>Tại điểm trường Huổi Pinh, thuộc trường Tiểu học Mường Toong 1, nhà vệ sinh từng có nhưng qua thời gian, nay đã xuống cấp và hư hỏng trầm trọng, gần như không sử dụng được.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230206110209-638112781293171338.jpg" style="width:100%" /></p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230206110222-638112781421745280.jpg" style="width:100%" /> <em>Nhà vệ sinh tại điểm trường Nậm Mì 1 cho hơn 300 học sinh.</em></p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230206110312-638112781920420144.jpg" style="width:100%" /> <em>Nhà vệ sinh tại điểm trường Huổi Thanh 1 hiện phục vụ 30 học sinh và 2 giáo viên.</em></p>

<p>Thậm chí, một số điểm trường ở Mường Nhé như bản Huổi Lúm, Huổi Ban, Huổi Lếch, Huổi Pết… không có nhà vệ sinh, giáo viên và học sinh phải đi nhờ. Hoặc tại điểm trường Xi Ma 1-2, Chuyên Gia 1-2, nhà vệ sinh chỉ đơn giản được quây bằng bạt, ván gỗ sơ sài, gây bất tiện và không đảm bảo vệ sinh cho cả giáo viên và học sinh.</p>

<p><strong>Vệ sinh trường học - nỗi ám ảnh của học sinh khi đến trường</strong></p>

<p>Theo số liệu của Bộ Giáo dục và Đào tạo, năm học 2019 - 2020 còn hơn 30% nhà vệ sinh trường học chưa đạt chuẩn trên cả nước. Báo cáo của UNICEF tại Việt Nam chỉ ra rằng, việc thiếu khả năng tiếp cận với nước sạch và vệ sinh môi trường, cùng với các thực hành vệ sinh kém góp phần làm tăng cao tỷ lệ tiêu chảy, viêm phổi và nhiễm ký sinh trùng.</p>

<p>Hiện nay, Chương trình Sức khỏe học đường giai đoạn 2021 - 2025 do Thủ tướng Chính phủ phê duyệt, đặt mục tiêu năm 2025, 100% trường học có nhà vệ sinh, trong đó 50% trường học có đủ nhà vệ sinh cho học sinh theo quy định và 80% nhà vệ sinh bảo đảm điều kiện hợp vệ sinh.</p>

<p>Với việc ra đời dự án "Vệ sinh học đường", Quỹ Hy Vọng đặt mục tiêu xây dựng 100 nhà vệ sinh mới trong năm 2022 - 2023, giúp trẻ em nâng cao hiểu biết về vệ sinh học đường, từ đó biết cách chăm sóc sức khỏe bản thân, tạo nền tảng cho một thế hệ khoẻ mạnh.</p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230206110401-638112782411242492.jpg" style="width:100%" /> <em>Học sinh tại trường Huổi Thanh 1, Trường Tiểu học Nậm Kè phải ngồi ghép lớp.</em></p>

<p>Bà Trương Thanh Thanh, Chủ tịch Hội đồng Quản lý Quỹ Hy Vọng cho biết đây là dự án mà quỹ đã ấp ủ từ lâu, sẽ không chỉ thực hiện tại Sơn La, Điện Biên mà dự kiến còn được triển khai tại một số tỉnh vùng núi phía Bắc trong thời gian tới.</p>

<p>"Nhiều em đã tâm sự rằng không dám đi vệ sinh ở trường vì quá dơ, quá bất tiện. Điều đó thôi thúc Quỹ ngoài xây trường cho các em, còn hướng đến cải tạo thêm hệ thống nhà vệ sinh, để các em có điều kiện học hành tốt hơn. Chúng tôi mong sẽ tiếp tục nhận được sự đồng hành, ủng hộ của các doanh nghiệp, các nhà hảo tâm để cuộc sống của trẻ em Việt Nam càng ngày càng tốt đẹp hơn", bà Thanh Thanh chia sẻ.</p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230206110435-638112782753008839.jpg" style="width:100%" /> <em>Công trình vệ sinh xây mới ở huyện Vân Hồ nhằm tạo môi trường an toàn, đảm bảo hơn cho học sinh khi đến trường.</em></p>

<p>Riêng trong năm học 2022 - 2023, Quỹ Hy Vọng đặt mục tiêu xây dựng 30 nhà vệ sinh mới cho các em học sinh huyện Mường Nhé, Điện Biên, nhằm xóa bỏ nỗi ám ảnh của học sinh khi đi vệ sinh tại trường học. Quỹ Hy Vọng dự kiến tổng kinh phí dự án khoảng 3.7 tỷ đồng.</p>

<p>Sau thành công của đợt gây quỹ lần thứ nhất, lần thứ 2 chúng tôi dự kiến tiếp tục xây 15 nhà vệ sinh với kinh phí dự án khoảng 1.85 tỷ đồng. Để làm được điều này, Quỹ Hy Vọng mong muốn nhận được sự chung tay của cộng đồng Trái Tim MoMo với số tiền gây quỹ là 150.000.000 đồng. Ngoài ra còn có 600.000.000 đồng được quy đổi từ số Heo Vàng sẽ được quyên góp qua Heo Đất MoMo.</p>

<p>Chúng tôi hy vọng đợt gây quỹ lần 2 sẽ tiếp tục thành công để giúp cho học sinh tại các điểm trường có được nhà vệ sinh mới, để các em an tâm học tập.</p>

<p>Trước đó, Quỹ Hy Vọng cũng hoàn thiện 20 nhà vệ sinh tại huyện Vân Hồ, Sơn La, mang đến điều kiện học tập tốt hơn cho 4.000 học sinh và giáo viên tại đây.</p>

<p><u><strong>Về Quỹ Hy Vọng:</strong></u><br />
Hope Foundation là quỹ xã hội - từ thiện hoạt động vì cộng đồng, không vì lợi nhuận, do VnExpress và Công ty Cổ phần FPT vận hành. Quỹ Hy vọng theo đuổi hai mục tiêu: hỗ trợ các hoàn cảnh khó khăn và tạo động lực phát triển. Quỹ Hy Vọng cho rằng để tạo ra một xã hội phát triển thì trước hết cần có nhiều sự kết nối để chia sẻ với những hoàn cảnh khó khăn. Và thúc đẩy các dự án phát triển trong đó mọi người được khuyến khích giải phóng tiềm năng của họ và trang bị cho mình các công cụ, cũng sẽ xóa đói giảm nghèo và tạo ra sự bình đẳng.</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-03-19' AS Date), N'Enable', 6, 2)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (9, N'Trao tặng 10 ca phẫu thuật thay đổi cuộc đời cho các em bé hở môi, hàm ếch', N'Chung tay gây quỹ 10 ca phẫu thuật cho các em bé hở môi, hàm ếch', N'https://static.mservice.io/blogscontents/momo-upload-api-230201154115-638108628754902718.jpg', N'<p><strong>Nhìn lại 2022 triệu yêu thương đong đầy</strong></p>

<p>Trong năm 2022, cộng đồng Heo Đất MoMo đã chung tay cùng Operation Smile giúp cho 565 em bé ở khắp Việt Nam của nhận được nụ cười mới. Đây là một kết quả vô cùng phấn khởi cho người nhà, gia đình các em. Đặc biệt là những trái tim nhân ái đã chung tay làm nên những điều kì diệu, thay đổi cuộc đời các em qua những ca phẫu thuật điều trị hở môi, hàm ếch miễn phí, an toàn.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230201154155-638108629156922393.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Những ca phẫu thuật miễn phí đã làm thay đổi cuộc đời nhiều em nhỏ</em></p>

<p>Cụ thể, trong năm 2022, chúng ta có tổng cộng 22 chương trình, cộng đồng Heo Đất MoMo đóng góp được gần 27 triệu Heo Vàng. Ngoài ra, cộng đồng đã kết nối cùng với 9 đối tác doanh nghiệp để thực hiện hoá giấc mơ nụ cười cho các em.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230201154238-638108629588234210.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230201154253-638108629731832518.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Khắp đất nước còn nhiều hoàn cảnh cần sự chung tay của cả cộng đồng</em></p>

<p>Trong suốt nhiều năm mang đến nụ cười trẻ thơ, Operation Smile đã gặp và điều trị cho rất nhiều em bé sinh ra không may mắc nhiều loại dị tật khác nhau trên gương mặt. Mỗi hoàn cảnh là thêm một động lực cho cả Operation Smile, đội ngũ y tế và các đối tác của chúng tôi dặn lòng mình phải tiếp tục cố gắng. Vì trên khắp đất nước chúng ta, còn biết bao cảnh ngộ đến đau lòng, mà gia đình quá khó khăn để có thể trang trải cho các em nhận được điều trị y tế kịp thời. May mắn thay, trên hành trình đó, chúng tôi được sự góp sức của cộng đồng người dùng Ví MoMo và Heo Đất MoMo để đồng hành cùng các đối tác, doanh nghiệp.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230201154319-638108629990230760.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Mỗi sự đóng góp của cộng đồng đều giúp các em nhỏ đến gần hơn với những điều tốt đẹp</em></p>

<p>Trong chương trình gây quỹ lần này, chúng ta hãy cùng mang đến nụ cười đón Tết, đón năm mới cho 10 em bé hở môi, hàm ếch với tổng chi phí dự kiến của dự án là 100.000.000 đồng. Chúng tôi và các em nhỏ hở môi, hàm ếch vô cùng biết ơn mỗi đóng góp dù nhỏ dù lớn của các nhà hảo tâm, các mạnh thường quân. Từ nguồn tài trợ này, các bệnh viện, bác sĩ, tình nguyện viên sẽ có thể cùng nhau biến đóng góp đó trở thành những nụ cười lành lặn. Nó sẽ tiếp thêm sự tự tin để các em vững bước hơn trong con đường bước đến tương lai.</p>

<p><em>*Sau khi chiến dịch được hoàn thành, Ví MoMo sẽ tiến hành trao 100.000.000 đồng đến Operation Smile để tiến hành thăm khám và thực hiện phẫu thuật cho các em nhỏ. Mọi thông tin về chương trình sẽ được chúng tôi cập nhật tới độc giả trong các bài viết tiếp theo.</em></p>

<p><u><strong>Về Operation Smile Vietnam:</strong></u><br />
Operation Smile (Phẫu thuật Nụ cười) là một tổ chức nhân đạo phi lợi nhuận hoạt động trong lĩnh vực chăm sóc sức khỏe cộng đồng, tập trung vào việc thực hiện phẫu thuật miễn phí cho các trẻ em sinh ra bị dị tật hở môi, hàm ếch và dị tật hàm mặt tại các nước đang phát triển. Trong hơn 33 năm hoạt động, tổ chức đã cùng với các tình nguyện viên y tế và phi y tế mang lại dịch vụ khám và điều trị miễn phí cho hơn 64,000 trường hợp, đem lại nụ cười và tương lai tươi sáng hơn cho trẻ em Việt Nam.</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-06-23' AS Date), N'Enable', 1, 11)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (10, N'Tặng 30 suất học bổng và truyền thông kỹ năng phòng chống xâm hại, bạo lực trẻ em cho học sinh có hoàn cảnh đặc biệt tại huyện Cần Giờ, TP.HCM', N'Ảnh hưởng dịch Covid – 19 khiến thu nhập của người dân không ổn định, kinh tế gia đình khó khăn cho nên ảnh hưởng đến việc chăm lo ăn uống và học hành của con cái. Hơn lúc nào hết, trẻ em rất cần nhận được sự quan tâm, tiếp sức từ cộng đồng để có thêm cơ hội, nghị lực và hành trang cho tương lai phía trước.', N'https://static.mservice.io/blogscontents/momo-upload-api-230130112523-638106747231538786.jpg', N'<p>Đại dịch Covid – 19 đã càn quét 4 đợt liên tục tại nhiều tỉnh thành trong cả nước. Trong đó TP.HCM bị ảnh hưởng nặng nề với 618.347 ca tính tới ngày 10/01/2023. Huyện Cần Giờ là một trong những huyện cũng chịu ảnh hưởng với hơn 22.473 ca nhiễm, đặc biệt có rất nhiều đối tượng là trẻ em.</p>

<p><strong>Những hoàn cảnh khó khăn bị ảnh hưởng bởi dịch Covid - 19</strong></p>

<p>Người dân huyện Cần Giờ chủ yếu là sống bằng nghề đi biển, làm lưới, làm muối và lao động tự do. Ảnh hưởng của dịch Covid – 19 khiến thu nhập của người dân nơi đây vô cùng bấp bênh. Cũng chính vì kinh tế gia đình khó khăn cho nên ảnh hưởng đến việc chăm lo ăn uống, sinh hoạt và học tập của nhiều trẻ em đang trong độ tuổi đến trường. Hơn lúc nào hết, trẻ em rất cần nhận được sự quan tâm, tiếp sức từ cộng đồng để có thêm cơ hội và nghị lực bước tiếp những chặng đường tri thức. Đặc biệt hơn là để chuẩn bị hành trang cho tương lai phía trước.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230130112612-638106747729077913.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230130112623-638106747837941352.jpg" style="width:100%" /></p>

<p>&nbsp;</p>

<p style="text-align:center"><em>Kinh tế gia đình khó khăn nên nhiều học sinh nghèo gặp trở ngại trong hành trình tiếp cận tri thức</em></p>

<p>&nbsp;</p>

<p>Gia đình em Lê Long Nhựt, hiện đang là học sinh lớp 10, có hoàn cảnh rất khó khăn. Mẹ em làm nội trợ, ba làm nghề biển. Khi tình hình dịch bệnh trở nên căng thẳng, ba em không đi làm lưới được, thu nhập càng không ổn định. Vì vậy kinh tế gia đình đã khó khăn lại chồng thêm khó khăn. Thế nhưng ba mẹ vẫn cố gắng làm thêm để có thêm chi phí cho Nhựt đến lớp như những bạn bè đồng trang lứa.</p>

<p>Gia đình em Lê Thị Ngọc Điệp, hiện đang là học sinh lớp 9, cũng bị ảnh hưởng bởi dịch Covid – 19. Ba em không còn việc làm nên chỉ làm lao động tự do, ai thuê gì làm đó, thu nhập mỗi ngày cũng chỉ được bữa đói bữa no. Dù vậy, em Điệp vẫn vô cùng chăm lo cho việc học và tự giác phụ giúp ba mẹ việc nhà để đỡ đần nỗi vất vả.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230130112649-638106748098878580.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230130112700-638106748209597091.jpg" style="width:100%" /></p>

<p>&nbsp;</p>

<p style="text-align:center"><em>Cùng nhau tiếp thêm sức mạnh để các em vững bước trên con đường đến trường</em></p>

<p>&nbsp;</p>

<p><strong>Chung tay trao học bổng cho 30 em học sinh nghèo</strong></p>

<p>Với tinh thần lá lành đùm lá rách, tương thân tương ái của người Việt Nam, Trung tâm Giáo dục Sức khỏe và Phát triển Cộng đồng Tương Lai – TP.HCM phối hợp cùng Ví MoMo gây quỹ và kêu gọi ủng hộ 30.000.000 đồng cho chương trình trao học bổng và truyền thông kỹ năng phòng chống xâm hại, bạo lực trẻ em có hoàn cảnh đặc biệt. Với truyền thống và tình cảm yêu thương trẻ em chúng tôi hy vọng các nhà hảo tâm, các mạnh thường quân sẽ cùng chung tay để dự án được tiến hành. Toàn bộ số tiền ủng hộ sẽ được sử dụng để trao học bổng cho 30 học sinh có hoàn cảnh đặc biệt và tổ chức truyền thông kỹ năng phòng chống xâm hại, bạo lực trẻ em cho học sinh có hoàn cảnh đặc biệt tại huyện Cần Giờ, TP.HCM.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230130112729-638106748497292406.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230130112740-638106748604707747.jpg" style="width:100%" /></p>

<p>&nbsp;</p>

<p style="text-align:center"><em>Cùng Trung tâm Tương Lai trao học bổng và truyền thông cho các em về phòng chống xâm hại, bạo lực trẻ em</em></p>

<p>&nbsp;</p>

<p><em>*Sau khi chiến dịch được hoàn thành, Ví MoMo cùng Trung tâm Tương Lai sẽ tiến hành trao học bổng và truyền thông ngay cho các em tại địa phương. Mọi thông tin về chương trình sẽ được chúng tôi cập nhật tới độc giả trong các bài viết tiếp theo.</em></p>

<p><u><strong>Về Trung tâm Tương Lai:</strong></u><br />
Trung tâm Giáo dục Sức khỏe và Phát triển Cộng đồng Tương Lai (Trung tâm Tương Lai) thành lập năm 2011 là tổ chức xã hội với sứ mệnh hoạt động vì trẻ em và thanh thiếu niên có hoàn cảnh đặc biệt. Đến thời điểm hiện tại, đã có hơn 30.000 trẻ em và thanh thiếu niên có hoàn cảnh đặc trên khắp 20 tỉnh thành cả nước được hưởng lợi. Trung tâm Tương lai không chỉ giúp đỡ về mặt tài chính mà còn quan tâm giúp đỡ trẻ em và thanh thiếu niên về hướng nghiệp, kỹ năng sống và vui chơi giải trí lành mạnh.</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-07-28' AS Date), N'Enable', 5, 9)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (11, N'Cùng chung tay giúp đỡ cô giáo cấp 1 từ bỏ nghề bởi di chứng sốt bại liệt', N'Từng ước mơ và ấp ủ nhiều hoài bão, cô Tâm rời khỏi bục giảng bởi di chứng của sốt bại liệt. Cô Tâm rất cần sự giúp đỡ kinh phí khám chữa bệnh, thuốc men', N'https://static.mservice.io/blogscontents/momo-upload-api-230118135520-638096469203857632.jpg', N'<p>Cô Đặng Thị Tâm sinh năm 1950, từng là giáo viên dạy cấp 1. Giọng người Hà Nội dịu dàng, trầm ấm đã từng đọc biết bao bài văn, dạy biết bao điều tốt đẹp cho thế hệ học trò. Cô Tâm chẳng ngờ rằng, sẽ có ngày mình lại lâm vào tình cảnh trớ trêu khi đi khám ở bệnh viện.</p>

<p>Cô Tâm từng bị sốt bại liệt khi còn nhỏ khiến hai chân cô đi lại bất tiện. Sau này, cô cũng vì nó mà ngừng sự nghiệp giảng dạy. Nỗi nhớ nghề khiến cô Tâm luôn đau đáu. Khi cô đi bệnh viện khám khối u ở ngực. Chân đi chập chững, ngực đau nhói nhưng không đau đớn bằng việc cô bị người khác chế giễu khi tập tễnh từng bước xếp hàng chờ khám.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118135604-638096469648456598.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Vì bại liệt mà cô Tâm phải ngừng sự nghiệp giảng dạy</em></p>

<p>Rời bục giảng, cô làm giúp việc để mưu sinh. Cô phải sống cô độc trong căn nhà trọ. Mọi gánh nặng đè lên đôi vai cô. Nhất là khi cô mắc thêm căn bệnh u vú, phải thăm khám và thuốc men thường xuyên. Tiền trọ hàng tháng, tiền ăn hàng ngày khiến cô không thể nào kham nổi.</p>

<p>Cũng từ đó, cô Tâm bước vào mái ấm Sài Gòn Bao Dung sống những ngày tháng hạnh phúc nhất của đời mình.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118135635-638096469954354700.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118135650-638096470106819748.jpg" style="width:100%" /></p>

<p>&nbsp;</p>

<p style="text-align:center"><em>Ở Quán trọ Trăng Khuyết, cô có thêm nhiều người bạn cùng đối thơ </em></p>

<p>&nbsp;</p>

<p>Cô Tâm không nghĩ rằng cuối đời mình có thể sống được những ngày tháng tươi đẹp như vậy. Nơi này, cô có bạn bè tri kỷ cùng đối thơ, cùng đố nhau về hằng đẳng thức đáng nhớ. Cô từ một người tứ cố vô thân, đã có thêm những anh hai, chị hai, chị ba… cùng ăn, cùng nghỉ, cùng đi dạo mát… Niềm hạnh phúc to lớn ấy đã khiến cô phải thốt lên xúc động rằng: “Tôi nguyện ở đây cho tới chết!”</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118135707-638096470273986447.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Căn bệnh vẫn dày vò cô qua nhiều năm tháng</em></p>

<p>Tuy nhiên, để làm được điều này, Trăng Khuyết rất mong có thêm kinh phí để cho cô Tâm có thể duy trì sức khỏe vượt qua bệnh tật, để vui khỏe cùng những người bạn già nơi đây. Để tiếp thêm hy vọng cho cô Đặng Thị Tâm, Trăng Khuyết cùng Ví MoMo kêu gọi số tiền khám chữa bệnh tim cho cô là 30.000.000 VNĐ thông qua cộng đồng các nhà hảo tâm, các mạnh thường quân.</p>

<p>Người hạnh phúc nhất chính là người có cơ hội được cho đi. Rất mong các mạnh thường quân, các nhà hảo tâm sẽ đồng hành cùng chương trình quyên góp lần này của MoMo và Trăng Khuyết hỗ trợ cho những số phận đơn chiếc. Dù đóng góp nào cũng đều đáng quý, cùng là tình yêu thương đong đầy của của cô chú, anh chị dành cho các cụ già neo đơn.</p>

<p><em>*Sau khi hoàn tất chiến dịch kêu gọi đóng góp, MoMo sẽ chuyển toàn bộ số tiền 30.000.000 đồng đã gây quỹ gửi đến Quỹ Từ Thiện &amp; BTXH Trăng Khuyết hỗ trợ chi phí khám chữa bệnh cho cô Tâm Chúng tôi sẽ cập nhật thêm thông tin về tiến độ dự án đến Quý vị trong thời gian sớm nhất. </em></p>

<p><u><strong>Về Quỹ Từ Thiện &amp; BTXH Trăng Khuyết:</strong></u><br />
Trăng Khuyết là một tổ chức từ thiện về nhân đạo và sự sống, nhằm kết nối cộng đồng và thực hiện các hoạt động trợ giúp trực tiếp cho các cụ già không nơi nương tựa và trẻ em bị bỏ rơi. Thông qua các hoạt động: cứu trợ khẩn cấp, cung cấp bữa ăn, chỗ ở và cải thiện cuộc sống. Trăng Khuyết hoạt động độc lập, phi tôn giáo và phi lợi nhuận trên toàn lãnh thổ Việt Nam. Thông qua pháp nhân là Quỹ Từ Thiện &amp; BTXH Trăng Khuyết, một doanh nghiệp xã hội, hoạt động 100% vì cộng đồng.</p>

<p><em>*MoMo biết rằng còn rất nhiều hoàn cảnh khó khăn trên khắp đất nước của chúng ta cần được bảo trợ. Bạn hay các công ty hãy liên hệ với chúng tôi để cùng tài trợ, giúp đỡ tạo nên một cộng đồng Việt Nam nhân ái nhé! <span style="color:#0066cc">donation@mservice.com.vn</span></em></p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-06-19' AS Date), N'Enable', 4, 10)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (12, N'Chung tay giúp những ngày cuối đời của thầy giáo Lưu Mạc Phong giảm bớt nỗi lo từ bệnh tật', N'Từng là thầy giáo rèn chữ cho biết bao thế hệ, nhưng thầy Phong lại chẳng thể nắn nót cuộc đời mình trở nên đẹp đẽ hơn. Cùng chung tay hỗ trợ kinh phí khám chữa bệnh cho thầy Phong.', N'https://static.mservice.io/blogscontents/momo-upload-api-230118134838-638096465180404701.jpg', N'<p><strong>Cuộc sống ngặt nghèo của người thầy giáo</strong></p>

<p>Thầy Lưu Mạc Phong, sinh 1962, dọn về quán trọ Trăng Khuyết sau trận bệnh nặng, đột quỵ và viêm phổi. Trong lúc làm bảo vệ ở một cửa hàng thời trang, thầy Phong đột ngột ngưng thở, ngã khuỵu trước cửa hàng. Thầy được đưa vào bệnh viện 115 cấp cứu. Suốt 2 tuần nằm viện, tiền lương, tiền dành dụm bao năm qua của thầy đã chi trả cho đợt chữa trị đó.</p>

<p>Sức khỏe không đủ, thầy nghỉ việc bảo vệ, nhà trọ cũng bị công ty lấy lại, không nhà, không tiền, không kế sinh nhai. Cuộc sống ngặt nghèo bủa vây. Trước đây, thầy từng lập gia đình nhưng hôn nhân đổ vỡ, con trai sống cùng mẹ. Một mình thầy lang bạt khắp nơi.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118134916-638096465567788324.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Sức khỏe khiến cho chú Phong phải chịu nhiều khó khăn trong sinh hoạt</em></p>

<p>Chẳng ai ngờ rằng người đàn ông gầy gò, xanh xao ấy từng là thầy giáo cấp 1. Đôi bàn tay gân guốc ấy từng ân cần dạy biết bao thế hệ học trò. Nét chữ mạnh mẽ, dứt khoát như nết người kiên cường, tận tụy của thầy Phong. Trong ánh mắt của thấy, vẫn còn ánh lên niềm vui và niềm tự hào khi nhắc về những tháng ngày đứng trên bục giảng.</p>

<p>Đáng tiếc rằng thầy lại không thể nắn nót cuộc đời mình tươi đẹp hơn.</p>

<p><strong>Chung tay hỗ trợ chi phí khám chữa bệnh cho thầy Phong</strong></p>

<p>Sau cơn bạo bệnh, sức khỏe của thầy sa sút hẳn, di chứng để lại thầy không thể làm việc nặng, đi tới đi lui nhiều cũng khó thở bởi không đủ oxy cấp lên phổi. Thầy tiếp tục nhập viện mấy lần nhưng thầy chẳng có gì ngoài cơ thể suy nhược.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118134935-638096465756898500.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Mặc dù đã không còn đi dạy, nhưng ước mơ gieo con chữ của thầy Phong cho các em nhỏ vẫn còn tới hôm nay</em></p>

<p>Trăng Khuyết đã tìm tới thầy trong hoàn cảnh mà khi bệnh viện cho xuất viện, cũng không biết đưa thầy đi đâu về đâu. Ngày thầy vào Quán trọ Trăng Khuyết tại Quận 12, gương mặt hốc hác, thất thần. Nhưng sau những tháng ngày không có chốn đi về, thầy Phong dần hòa nhập và sống vui vẻ bên cạnh những người bạn già của mình. Thầy đọc sách, ngâm thơ, luyện chữ… và chia sẻ về tâm huyết làm nghề giáo của mình “Phạt học trò đau một, thầy cô lại đau tới mười!”</p>

<p>Một người thầy đã từng nhiệt huyết với nghề giáo, giúp bao thế hệ sang sông, vẫn còn ưu tư những khi thăm khám, thuốc men đều đặn bởi di chứng để lại. Vì vậy Quỹ Trăng Khuyết kết hợp cùng Ví MoMo kêu gọi các mạnh thường quân chung tay quyên góp 30.000.000 đồng để góp thêm một phần chi phí giúp cho người thầy vượt qua những ngày khó khăn phía trước.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118135000-638096466001859604.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chung tay giúp thầy Phong có thêm chi phí khám chữa bệnh trong những ngày tháng còn lại</em></p>

<p>Cuộc sống muôn màu muôn vẻ, bên cạnh những người hạnh phúc thì không thiếu những người bi thương. Chính vì lí do đó mà cuộc sống cần phải có sự sẻ chia, tương trợ lẫn nhau. Rất mong các mạnh thường quân, các nhà hảo tâm sẽ đồng hành cùng chương trình quyên góp lần này của MoMo và Trăng Khuyết hỗ trợ cho những số phận đơn chiếc. Dù đóng góp nào cũng đều đáng quý, cùng là tình yêu thương đong đầy của của cô chú, anh chị dành cho các cụ già neo đơn.</p>

<p><em>*Sau khi hoàn tất chiến dịch kêu gọi đóng góp, MoMo sẽ chuyển toàn bộ số tiền 30.000.000 đồng đã gây quỹ gửi đến Quỹ Từ Thiện &amp; BTXH Trăng Khuyết hỗ trợ chi phí khám chữa bệnh cho thầy Phong. Chúng tôi sẽ cập nhật thêm thông tin về tiến độ dự án đến Quý vị trong thời gian sớm nhất.</em></p>

<p><u>Về Quỹ Từ Thiện &amp; BTXH Trăng Khuyết:</u><br />
Trăng Khuyết là một tổ chức từ thiện về nhân đạo và sự sống, nhằm kết nối cộng đồng và thực hiện các hoạt động trợ giúp trực tiếp cho các cụ già không nơi nương tựa và trẻ em bị bỏ rơi. Thông qua các hoạt động: cứu trợ khẩn cấp, cung cấp bữa ăn, chỗ ở và cải thiện cuộc sống. Trăng Khuyết hoạt động độc lập, phi tôn giáo và phi lợi nhuận trên toàn lãnh thổ Việt Nam. Thông qua pháp nhân là Quỹ Từ Thiện &amp; BTXH Trăng Khuyết, một doanh nghiệp xã hội, hoạt động 100% vì cộng đồng</p>

<p><em>*MoMo biết rằng còn rất nhiều hoàn cảnh khó khăn trên khắp đất nước của chúng ta cần được bảo trợ. Bạn hay các công ty hãy liên hệ với chúng tôi để cùng tài trợ, giúp đỡ tạo nên một cộng đồng Việt Nam nhân ái nhé! <span style="color:#0066cc">donation@mservice.com.vn</span></em></p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-07-09' AS Date), N'Enable', 4, 10)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (13, N'Chung tay hỗ trợ chi phí giúp ông Chương hồi phục sức khỏe sau đại dịch covid-19', N'Cùng chung tay hỗ trợ chi phí chăm sóc sức khỏe cho ông Chương, để những ngày tháng cuối đời ông được sống yên bình tại mái ấm', N'https://static.mservice.io/blogscontents/momo-upload-api-230118133853-638096459331757773.jpg', N'<p><strong>Mất tất cả sau đại dịch</strong></p>

<p>Sau 1 năm, khi tất cả mọi người đã dần chấp nhận sống chung với đại dịch Covid - 19. Dù vậy nỗi đau mà những người còn ở lại thì vẫn chưa thể nguôi ngoai. Ông Lê Hùng Chương sinh 1942 là một trong những hoàn cảnh đáng thương đã mất tất cả sau đại dịch.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118133951-638096459911219755.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Nỗi đau mất mát của ông Chương vẫn chưa thể nguôi ngoai</em></p>

<p>Chỉ trong thời gian ngắn ngủi, ông mất đi vợ con của mình. Tuy ông may mắn hơn, nhưng sức khỏe cùng kiệt khiến ông không thể nào tiếp tục công việc bảo vệ tại cửa hàng. Không còn người thân, ông sống cô độc tại phòng trọ. Khốn khổ khi tuổi già, thất nghiệp, ông Chương không tiền đóng trọ, không biết xoay sở thế nào để có được bữa ăn qua ngày. Gương mặt hiền hậu ấy càng hằn sâu những nỗi lo toan, vất vả cho những ngày tháng sau này.</p>

<p><strong>Những nỗi lo âm thầm</strong></p>

<p>Sau khi được về sống ở mái ấm Sài Gòn Bao Dung, ông Chương vẫn cố gắng dùng công sức của mình để đóng góp cho những hoạt động ở mái ấm.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118134023-638096460232986013.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Những bữa ăn được san sẻ cùng nhau của ông Chương và chú Mỹ</em></p>

<p>Thương thân mình nên nghĩ thương đến những người bạn già. Dù người gầy gò, ốm yếu nhưng ông vẫn hăng hái giúp đỡ quản lý không gian trong ngoài mái ấm, hỗ trợ những cụ già có sức khỏe yếu hơn ông để đưa đi khám,...</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230118134047-638096460470061661.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Ông Chương hướng dẫn cho người nước ngoài tá túc khi gặp nạn</em></p>

<p>Thế nhưng, trong cơ thể nhỏ bé đầy nghị lực ấy, là một lá phổi đã hư tổn, và một trái tim đang chống chọi với bệnh tật. Trăng Khuyết rất đồng cảm trước những mất mát của ông, càng lo lắng cho sức khỏe của ông Chương ở thời điểm hiện tại. Trăng Khuyết mong rằng sẽ có thêm kinh phí để có thể hỗ trợ ông Chương khám chữa bệnh và nâng cao sức khỏe, để ông có thể giúp đỡ những người bạn già kém may mắn hơn mình. Để tiếp thêm hy vọng cho ông, Trăng khuyết kêu gọi số tiền khám chữa bệnh tim là 30.000.000VNĐ thông qua Trái Tim MoMo. Rất mong các mạnh thường quân, các nhà hảo tâm sẽ đồng hành cùng chương trình quyên góp lần này của MoMo và Trăng Khuyết hỗ trợ cho những số phận đơn chiếc. Dù đóng góp nào cũng đều đáng quý, cùng là tình yêu thương đong đầy của của cô chú, anh chị dành cho các cụ già neo đơn.</p>

<p>Cuộc sống muôn màu muôn vẻ, bên cạnh những người hạnh phúc thì không thiếu những người bi thương. Chính vì lý do đó mà cuộc sống cần phải có sự sẻ chia, tương trợ lẫn nhau.</p>

<p><em>*Sau khi hoàn tất chiến dịch kêu gọi đóng góp, MoMo sẽ chuyển toàn bộ số tiền 30.000.000 đồng đã gây quỹ gửi đến Quỹ Từ Thiện &amp; BTXH Trăng Khuyết hỗ trợ chi phí khám chữa bệnh cho ông Chương. Chúng tôi sẽ cập nhật thêm thông tin về tiến độ dự án đến Quý vị trong thời gian sớm nhất. </em></p>

<p><u><strong>Về Quỹ Từ Thiện &amp; BTXH Trăng Khuyết:</strong></u><br />
Trăng Khuyết là một tổ chức từ thiện về nhân đạo và sự sống, nhằm kết nối cộng đồng và thực hiện các hoạt động trợ giúp trực tiếp cho các cụ già không nơi nương tựa và trẻ em bị bỏ rơi. Thông qua các hoạt động: cứu trợ khẩn cấp, cung cấp bữa ăn, chỗ ở và cải thiện cuộc sống. Trăng Khuyết hoạt động độc lập, phi tôn giáo và phi lợi nhuận trên toàn lãnh thổ Việt Nam. Thông qua pháp nhân là Quỹ Từ Thiện &amp; BTXH Trăng Khuyết, một doanh nghiệp xã hội, hoạt động 100% vì cộng đồng</p>

<p><em>*MoMo biết rằng còn rất nhiều hoàn cảnh khó khăn trên khắp đất nước của chúng ta cần được bảo trợ. Bạn hay các công ty hãy liên hệ với chúng tôi để cùng tài trợ, giúp đỡ tạo nên một cộng đồng Việt Nam nhân ái nhé! <span style="color:#0066cc">donation@mservice.com.vn</span></em></p>
', 200000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-08-22' AS Date), N'Enable', 4, 10)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (14, N'Gây quỹ trao 50 phần quà Tết cho trẻ em và gia đình có hoàn cảnh khó khăn tại Tp.HCM', N'Cùng MSD United Way Vietnam chung tay gây quỹ trao tặng 50 phần quà Tết cho trẻ em và gia đình có hoàn cảnh khó khăn thuộc Trang mới cuộc đời – khu vực Tp.HCM', N'https://static.mservice.io/blogscontents/momo-upload-api-230112141333-638091296130777561.jpg', N'<p>Tết là khoảng thời gian để gia đình sum vầy, là thời gian gợi lên sự sung túc, đầm ấm, yên vui. Tuy nhiên, mặc dù không khí Tết đang tràn về khắp các nẻo đường nhưng vì hoàn cảnh khó khăn, có những đứa trẻ chưa bao giờ được đón một mùa Tết trọn vẹn và đầy đủ như bao bạn bè cùng trang lứa. Với các em, việc có một cái Tết đủ đầy như bao người khác là một điều gì đó rất xa vời.</p>

<p>Những bạn nhỏ mà MSD United Way Vietnam biết đến và đang hỗ trợ hầu hết là những bạn có hoàn cảnh gia đình rất khó khăn. Trong đó có không ít bạn còn không có được một tấm giấy khai sinh cho mình. Việc không có giấy khai sinh khiến cuộc sống vốn đã khó khăn càng trở nên vất vả hơn: không thể đến trường học, không được tham gia bảo hiểm y tế và được hưởng những quyền lợi cơ bản.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230112141419-638091296598895503.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Không khí Tết đang về trên khắp nẻo đường nhưng nhiều hoàn cảnh khó khăn chưa bao giờ đón một mùa Tết trọn vẹn</em></p>

<p>Gia đình bốn chị em nhà họ Thạch mà MSD United Way Vietnam ghé thăm vào tháng 7.2022 vừa qua tại huyện Bình Chánh, Tp.HCM là một trường hợp rất đặc biệt. 20 em nhỏ trong đại gia đình này đều không có giấy khai sinh. Trong khuôn khổ dự án Trang Mới Cuộc Đời, MSD United Way Vietnam đã hỗ trợ làm giấy khai sinh cho 10 trẻ. Nhưng vẫn còn 10 trẻ nữa vẫn chưa hoàn thiện thủ tục để có được một tấm giấy khai sinh cho các em. Tuy vậy, các em vẫn rất mong muốn được đến trường và cũng mong cho các anh chị em khác trong gia đình ai cũng được đến trường đi học giống mình. Gia đình và hoàn cảnh khó khăn, cái Tết đủ đầy với các em và gia đình cũng giống như một mơ ước.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230112141451-638091296915417474.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230112141502-638091297028833486.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Nhiều em nhỏ khó khăn vẫn luôn mong muốn được tiếp tục đến trường như bao bạn bè trang lứa</em></p>

<p>Vì vậy, trước thềm năm mới Quý Mão 2023, MSD United Way Vietnam phối hợp với Trái im MoMo phát động dự án Trao quà Tết 2023 với mong muốn mang đến niềm vui ấm áp nho nhỏ ngày Tết cũng như nỗ lực để vì một Việt Nam không ai bị bỏ lại phía sau.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230112141535-638091297353870426.jpg" style="width:100%" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-230112141545-638091297456426979.jpg" style="width:100%" /></p>

<p style="text-align:center"><em>Chung tay cùng MSD mang đến Tết ấm áp hơn cho các em nhỏ nghèo khó khăn </em></p>

<p>Để hiện thực hóa dự án này, chúng tôi kêu gọi những tấm lòng nhân ái tham gia hỗ trợ và đóng góp 50.000.000 VND – tương đương 50 phần quà cho 50 trẻ em và gia đình có hoàn cảnh khó khăn tại TP.HCM. Phần quà bao gồm: quà Tết cho trẻ em, cùng thực phẩm (gạo, trứng, sữa, dầu ăn, bánh kẹo…) và đồ dùng thiết yếu. Những phần quà này sẽ là lời chúc mừng năm mới mà cộng đồng gửi đến các em, nhằm mang đến cho các em hy vọng tốt đẹp về một năm mới tươi sáng, hạnh phúc hơn và phần nào san sẻ gánh nặng với gia đình các em.</p>

<p><u><strong>Về Viện Nghiên cứu Quản lý Phát triển bền vững (MSD) – United Way Việt Nam:</strong></u><br />
Là một tổ chức phi chính phủ Việt Nam, MSD – United Way Việt Nam nỗ lực hành động vì một môi trường phát triển thuận lợi cho sự phát triển của khối các tổ chức xã hội và thúc đẩy việc thực hiện quyền của các nhóm cộng đồng bị lề hoá và dễ bị tổn thương, đặc biệt là nhóm trẻ em, thanh niên, phụ nữ và người khuyết tật. Hiện nay, MSD – United Way Việt Nam được công nhận là một tổ chức hàng đầu trong việc phối hợp, hỗ trợ và cung cấp các dịch vụ nâng cao năng lực, đào tạo và tham vấn cho các tổ chức xã hội tại Việt Nam. Thêm vào đó, MSD – United Way Việt Nam cũng là một tổ chức chuyên nghiệp đáp ứng hiệu quả nhu cầu và bảo vệ quyền lợi của các đối tượng có hoàn cảnh khó khăn, thông qua tổ chức các dự án và hỗ trợ trẻ em, thanh thiếu niên, phụ nữ, người vô gia cư, người nhập cư và người khuyết tật tại Việt Nam.</p>
', 300000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-09-13' AS Date), N'Enable', 4, 12)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (15, N'Đại sứ Nước – Đem nước sạch về cho người dân Xóm Chiềng Cang, Tỉnh Hòa Bình', N'Chung tay cùng Đại sứ Nước – để xây dựng công trình nước sinh hoạt đem nước sạch về cho người dân Xóm Chiềng Cang, huyện Đà Bắc, Tỉnh Hòa Bình', N'https://static.mservice.io/blogscontents/momo-upload-api-221229133836-638079179168237393.jpg', N'<p>Từ bao đời nay, Nước luôn luôn là nguồn sống không thể thiếu của con người. Vậy nhưng, vẫn còn nhiều khu vực tại các khu vực miền núi, hoặc các vùng sâu vùng xa, thì nước sạch vẫn là một điều gì đó vô cùng xa xỉ. Và xóm Chiềng Cang, thuộc xã Mường Chiềng, huyện Đà Bắc, tỉnh Hoà Bình mà tổ chức MSD United Way Việt Nam và RIC muốn đem nước sạch về trong dự án Đại sứ nước lần này là một ví dụ điển hình.</p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221229133927-638079179671384998.jpg" style="width:100%" /> <em>Ở nhiều vùng sâu vùng xa của đất nước, được sử dụng nước sạch đối với người dân là vô cùng khó khăn</em></p>

<p>Đây là một trong những xóm nghèo của xã Mường Chiềng, huyện Đà Bắc. Xóm có 106 hộ dân với 49 hộ nghèo (chiếm 46,2%) và 25 hộ cận nghèo (chiếm 23,5%). Nghề nghiệp chính của người dân trong thôn là nông lâm nghiệp kết hợp (trồng ngô và lúa là chủ yếu) nên việc sử dụng nước sạch càng cần thiết hơn. Ấy vậy mà hệ thống cung cấp nước sinh hoạt cho người dân xóm Chiềng Cang đã bị xuống cấp trầm trọng từ năm 2017 đến nay. Bể nước và đường ống dẫn nước đã không còn sử dụng được, nên người dân nơi đây phải sử dụng thau, chậu để đựng nước từ các mó nước đầu nguồn về để sử dụng.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221229134104-638079180640834111.jpg" style="width:100%" /></p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221229134125-638079180859179074.jpg" style="width:100%" /> <em>Hệ thống cung cấp nước sạch vừa sơ sài lại vừa bị hư hỏng nặng nề</em></p>

<p>Để có nước sinh hoạt, các gia đình phải đi bộ từ 2-3km đường núi để gánh nước từ suối về dùng. Đặc biệt vào mùa khô, người dân phải chia nhau từng xô nước đem về được. Nhưng chính nguồn nước này cũng tiềm ẩn nhiều nguy cơ về sức khỏe. Do địa hình gần các khu vực có đá vôi và các khu công nghiệp, nên nguồn nước cũng bị ô nhiễm và sẽ gây hại cho sức khỏe nếu sử dụng trong một thời gian dài. Cụ thể người dân tại xóm Chiềng Cang có tỷ lệ mắc các bệnh về đường ruột, vàng da, đau mắt,...cao hơn mặt bằng chung của địa phương.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221229134200-638079181206437670.jpg" style="width:100%" /></p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221229134217-638079181375876799.jpg" style="width:100%" /> <em>Nguồn nước không đảm bảo vệ sinh nên còn tiềm ẩn nhiều nguy cơ về sức khỏe</em></p>

<p><strong>Cùng Đại sứ nước mang nước sạch về xóm Chiềng Cang</strong></p>

<p>Nhận thấy được tình hình này, MSD United Way Vietnam phối hợp cùng các đối tác triển khai chương trình “Đại sứ nước”để cùng chung tay với bà con xóm Chiềng Cang. Dự án sẽ nâng cấp và sửa chữa lại hệ thống cấp nước sinh hoạt tự chảy cho người dân nơi đây. Sau khi khảo sát địa điểm và cùng nhau ngồi lại tìm ra phương án thích hợp, công trình bao gồm những hạng mục sau:</p>

<ol>
	<li>Tu sửa lại 01 bể bể đầu nguồn (dài 2,5m, rộng 2,5m, cao 1,5m).</li>
	<li>Lắp mới tuyến đường ống dẫn nước bị hỏng từ bai chứa nước đầu nguồn đến bể chia nước về bể chứa khu dân cư dài bằng ống nhựa HPDE Tiền Phong ph 50x 1500m.</li>
	<li>Xây dựng 01 bể chia nước bằng gạch chỉ đỏ, bê tông cốt thép (dài 3m, rộng 2,5m, cao 1,2m). Các hộ dân sẽ dẫn nước từ bể chứa này về nhà.</li>
	<li>Tu sửa 01 bể chứa nước cũ với việc thau rửa vệ sinh bể và thay mới các van vòi chia nước Các hộ gia đình sẽ dẫn nước từ bể chứa nước tập trung tại khu dân cư về các bể chứa của các hộ gia đình.</li>
</ol>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221229134251-638079181717209626.jpg" style="width:100%" /> <em>Chung tay mang đến nguồn nước sạch cho các em nhỏ và bà con vùng sâu vùng xa</em></p>

<p><em>*Khi chương trình đã hoàn thành quyên góp, toàn bộ số tiền quyên góp được sẽ được Ví MoMo gửi tới Viện Nghiên cứu Quản lý Phát triển bền vững (MSD) và Trung tâm Nghiên cứu Sáng kiến Phát triển Cộng đồng (RIC) để triển khai chiến dịch xây dựng hệ thống nước sạch. Chúng tôi sẽ cập nhật thông tin về tiến độ dự án tới các bạn trong thời gian sớm nhất.</em></p>

<p><u><strong>Về MSD United Way VietNam:</strong></u><br />
Là một tổ chức phi chính phủ Việt Nam, MSD nỗ lực hành động vì một môi trường phát triển thuận lợi cho sự phát triển của khối các tổ chức xã hội và thúc đẩy việc thực hiện quyền của các nhóm cộng đồng bị lề hoá và dễ bị tổn thương, đặc biệt là nhóm trẻ em, thanh niên, phụ nữ và người khuyết tật. MSD được công nhận là một tổ chức hàng đầu trong phối hợp, hỗ trợ và cung cấp các dịch vụ nâng cao năng lực, đào tạo và tham vấn cho các tổ chức xã hội tại Việt Nam. Bên cạnh đó, MSD cũng là tổ chức chuyên nghiệp đáp ứng hiệu quả nhu cầu và bảo vệ các đối tượng có hoàn cảnh khó khăn, thông qua tổ chức các dự án và hỗ trợ trẻ em, thanh thiếu niên, phụ nữ, người vô gia cư, người nhập cư và người khuyết tật tại Việt Nam.</p>

<p><u><strong>Về Trung tâm RIC:</strong></u><br />
RIC kết nối và thúc đẩy các sáng kiến trong việc nâng cao năng lực tự quản cho cộng đồng thiểu số thông qua huy động các nguồn viện trợ Quốc tế và trong nước để thực hiện các dự án phát triển, góp phần thúc đẩy phát triển bền vững cho các cộng đồng DTTS tại Việt Nam. RIC được công nhận là 1 tổ chức hàng đầu trong việc nâng cao năng lực tự quản cho cộng đồng để thực hiện việc xây dựng, duy tu, bảo dưỡng các công trình cơ sở hạ tầng tại các vùng đồng bào DTTS. Đặc biệt, hiện tại RIC là một tổ chức duy nhất có thể giúp các cộng đồng tiếp cận được với nguồn ngân sách nhà nước từ Chương trình 135 để thực hiện việc xây dựng, duy tu bảo dưỡng công trình cơ sở hạ tầng quy mô nhỏ tại vùng DTTS và miền núi.</p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-07-20' AS Date), N'Enable', 6, 12)
INSERT [dbo].[tblFund] ([fund_id], [fund_name], [fund_des], [image_url], [fund_content], [expected_amount], [start_date], [end_date], [fund_status], [category_id], [foundation_id]) VALUES (16, N'Cùng xây dựng điểm trường Mầm non thôn Nậm Siệu, Tân Lập - Bắc Quang - Hà Giang', N'Điểm trường có trên 45 học sinh bao gồm cấp mầm non và cấp tiểu học, trong đó có 27 em học sinh mầm non. Thế nhưng các em đang phải học tập trong phòng học dựng tạm và không còn an toàn.', N'https://static.mservice.io/blogscontents/momo-upload-api-221227105457-638077352974758289.jpg', N'<p>Điểm trường Mầm Non Nậm Siệu thuộc xã Tân Lập, huyện Bắc Quang, tỉnh Hà Giang, là điểm trường có số lượng học sinh lớn, nhu cầu học tập cao. Tuy nhiên điều kiện vật chất tại điểm trường chính không đáp ứng được yêu cầu cơ sở vật chất để giúp các em nhỏ tiếp cận được với nền giáo dục chất lượng.</p>

<p>Thôn Nậm Siệu cách Ủy Ban Nhân Dân Xã Tân Lập khoảng 9km với 46 hộ gia đình, trong đó 70% hộ nghèo và cận nghèo. Người dân trong thôn chủ yếu là đồng bào người Dao và người Mông. Nghề nghiệp chủ yếu của các gia đình là làm nông, nên thu nhập của họ còn thấp. Vì thế dù chịu khó làm ăn nhưng kinh tế của họ chưa được cải thiện hoàn toàn. Người dân nơi đây vẫn luôn hiểu rằng đầu tư việc học cho con em là con đường cần thiết và đúng đắn nhất. Các em học sinh cũng không vì đường xa hay cơ sở vật chất thiếu thốn mà từ bỏ lớp học.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221227105600-638077353606819602.jpg" style="width:100%" /></p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221227105625-638077353859551363.jpg" style="width:100%" /> <em>Điểm trường Mầm Non Nậm Siệu đang cần kêu gọi đầu tư bởi cơ sở vật chất đã xuống cấp nặng nề</em></p>

<p>Hiện tại điểm trường có trên 45 học sinh bao gồm cấp mầm non và cấp tiểu học, trong đó có 27 em học sinh mầm non. Điểm trường đã xây dựng trên 12 năm, trải qua điều kiện thời tiết và thời gian dài sử dụng, đến thời điểm này nhà đã bị hư hỏng hoàn toàn và không thể sử dụng. Vì thế điểm trường đã tiến hành tháo dỡ và các em đang phải học nhờ tại Hội trường thôn. Nhà lớp học tại Hội trường thôn được làm bằng loại nhà gỗ, tre nhưng cũng đã mọt mối, hư hỏng.</p>

<p>Điểm trường mầm non Nậm Siệu là điểm trường nằm trong quy hoạch các điểm giáo dục cần kêu gọi đầu tư xây dựng trên địa bàn xã Tân Lập, trường đã được cấp mặt bằng tuy nhiên chưa vận động được nguồn kinh phí xây dựng. Hiểu rõ những khó khăn vất vả và mơ ước được tiếp tục đến trường học tập của thầy trò trường mầm non Nậm Siệu, Trung tâm Tình nguyện Quốc gia, Sức Mạnh và Anh chị nuôi Dự án Nuôi Em kết hợp cùng Ví MoMo kêu gọi cộng đồng Trái Tim MoMo chung tay quyên góp 150.000.000 đồng tiền mặt.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221227105650-638077354106031879.jpg" style="width:100%" /></p>

<p style="text-align:center"><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221227105700-638077354206055787.jpg" style="width:100%" /> <em>Chung tay mang đến phòng học khang trang và an toàn hơn cho các em học sinh tại điểm trường Nậm Siệu</em></p>

<p>Dự án dự kiến sẽ xây dựng nhà lớp học cấp IV gồm: 02 phòng học, 01 phòng công vụ với tổng diện tích 115 m2 và xây dựng 01 nhà vệ sinh. Chúng tôi hy vọng cộng đồng các nhà hảo tâm, các mạnh thường quân cùng chung tay để dự án xây trường có thể được tiến hành. Mỗi sự đóng góp dù lớn hay nhỏ của Quý vị cũng giúp các em nhỏ có phòng học kiên cố, khang trang và an toàn hơn.</p>

<p><u><strong>Về Trung tâm Tình nguyện Quốc gia:</strong></u><br />
Trung tâm Tình nguyện Quốc gia (VVC) do TW Đoàn TNCS Hồ Chí Minh thành lập, là tổ chức cấp Quốc gia nhằm mục tiêu thúc đẩy, hỗ trợ và điều phối hoạt động tình nguyện vì sự phát triển ở Việt Nam. VVC Cung cấp đầy đủ thông tin về mọi hoạt động tình nguyện, tập huấn, hội thảo, hội nghị, diễn đàn thanh niên về các vấn đề xã hội trong nước và quốc tế. Là cầu nối giữa những tổ chức xã hội và những người đam mê tình nguyện.</p>

<p><u><strong>Về dự án Sức mạnh 2000 - Ánh Sáng Núi Rừng:</strong></u><br />
Là một dự án gây quỹ xây trường được khởi xướng và điều hành bởi anh Hoàng Hoa Trung - Forbes 30 Under 30 2020, Gương mặt trẻ Việt Nam Tiêu biểu 2019. Tính tới tháng 2/2021, dự án đã xây dựng thành công gần 130 điểm trường, nhà nội trú, nhà hạnh phúc, cầu dân sinh ở các tỉnh vùng cao, giúp hơn 7000 trẻ em được đến trường. Tìm hiểu về dự án thêm tại: <span style="color:#0066cc">http://sucmanh2000.com</span></p>
', 100000000, CAST(N'2023-02-19' AS Date), CAST(N'2023-07-05' AS Date), N'Enable', 6, 1)
SET IDENTITY_INSERT [dbo].[tblFund] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (1, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'TienTV', N'96truongtien@gmail.com', 2, N'Trương Văn Tiển', N'Hồ Chí Minh', N'0329975177', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (2, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'DuyLV', N'98leduy@gmail.com', 1, N'Lê Văn Duy', N'Hồ Chí Minh', N'0329975178', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (3, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'PhongNT', N'98thanhphong@gmail.com', 1, N'Nguyễn Thanh Phong', N'Hồ Chí Minh', N'0329975179', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (4, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'AnhND', N'98duyanh@gmail.com', 1, N'Nguyễn Duy Anh', N'Hồ Chí Minh', N'0329975180', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (5, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'PhongLT', N'98phongle@gmail.com', 1, N'Lê Thanh Phong', N'Hồ Chí Minh', N'0329975182', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (6, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'NamTV', N'98namtran@gmail.com', 1, N'Trần Văn Nam', N'Hồ Chí Minh', N'0329975181', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (7, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'LanNN', N'98lanngoc@gmail.com', 1, N'Nguyễn Ngọc Lan', N'Hồ Chí Minh', N'0329975183', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (9, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'NamLV', N'98namle@gmail.com', 1, N'Lê Văn Nam', N'Hồ Chí Minh', N'0329975185', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (10, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'NgọcNN', N'98ngocmy@gmail.com', 1, N'Nguyễn Mỹ Ngọc', N'Hồ Chí Minh', N'0329975186', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (11, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'Nguyễn Ngọc Mai', N'95maingoc@gmail.com', 2, N'Nguyễn Ngọc Mai', N'Huế', N'0329972122', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (12, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'VanNam', N'92vannam@gmail.com', 1, N'Nguyễn Văn Nam', N'Đà Nẵng', N'0329971122', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (13, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'MinhTran', N'86minhtran@gmail.com', 1, N'Trần Quang Minh', N'Quảng Bình', N'0392275177', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (14, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'Lê Thành Công', N'95thanhcong@gmail.com', 1, N'Lê Thành Công', N'Vũng Tàu', N'0328822122', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (15, N'0d107d09f5bbe40cade3de5c71e9e9b7', N'PhatNguyen55', N'phatnguyen55@gmail.com', 1, N'Nguyễn Văn Phát', N'Cần Thơ', N'0339975122', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (17, N'd9f83deb245b25beaf9a19e22ad529d4', N'NamNv', N'namnv99@gmail.com', 1, N'Nguyen Van Nam', N'Đà Nẵng', N'1234567891', N'Enable')
INSERT [dbo].[tblUser] ([user_id], [password], [username], [user_email], [user_role], [user_fullname], [user_address], [user_phone], [user_status]) VALUES (19, N'a309e81dfdb9f7e155de34cf1b3ad6e9', N'duongdt', N'duongdt97@gmail.com', 2, N'Truong Van Duong', N'Hồ Chí Minh', N'1234567891', N'Enable')
SET IDENTITY_INSERT [dbo].[tblUser] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unqCategory]    Script Date: 5/6/2023 3:50:41 PM ******/
ALTER TABLE [dbo].[tblCategory] ADD  CONSTRAINT [unqCategory] UNIQUE NONCLUSTERED 
(
	[category_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unqFoundation]    Script Date: 5/6/2023 3:50:42 PM ******/
ALTER TABLE [dbo].[tblFoundation] ADD  CONSTRAINT [unqFoundation] UNIQUE NONCLUSTERED 
(
	[foundation_email] ASC,
	[foundation_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unqFund]    Script Date: 5/6/2023 3:50:42 PM ******/
ALTER TABLE [dbo].[tblFund] ADD  CONSTRAINT [unqFund] UNIQUE NONCLUSTERED 
(
	[fund_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unqUser]    Script Date: 5/6/2023 3:50:42 PM ******/
ALTER TABLE [dbo].[tblUser] ADD  CONSTRAINT [unqUser] UNIQUE NONCLUSTERED 
(
	[username] ASC,
	[user_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblCategory] ADD  DEFAULT ('enable') FOR [category_status]
GO
ALTER TABLE [dbo].[tblFoundation] ADD  DEFAULT ('enable') FOR [foundation_status]
GO
ALTER TABLE [dbo].[tblFund] ADD  DEFAULT ('enable') FOR [fund_status]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ('enable') FOR [user_status]
GO
ALTER TABLE [dbo].[tblDonation]  WITH CHECK ADD  CONSTRAINT [FK_tblDonation_fundId] FOREIGN KEY([fund_id])
REFERENCES [dbo].[tblFund] ([fund_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblDonation] CHECK CONSTRAINT [FK_tblDonation_fundId]
GO
ALTER TABLE [dbo].[tblDonation]  WITH CHECK ADD  CONSTRAINT [FK_tblDonation_userId] FOREIGN KEY([user_id])
REFERENCES [dbo].[tblUser] ([user_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblDonation] CHECK CONSTRAINT [FK_tblDonation_userId]
GO
ALTER TABLE [dbo].[tblFund]  WITH CHECK ADD  CONSTRAINT [FK_tblFund_categoryID] FOREIGN KEY([category_id])
REFERENCES [dbo].[tblCategory] ([category_id])
GO
ALTER TABLE [dbo].[tblFund] CHECK CONSTRAINT [FK_tblFund_categoryID]
GO
ALTER TABLE [dbo].[tblFund]  WITH CHECK ADD  CONSTRAINT [FK_tblFund_foundationID] FOREIGN KEY([foundation_id])
REFERENCES [dbo].[tblFoundation] ([foundation_id])
GO
ALTER TABLE [dbo].[tblFund] CHECK CONSTRAINT [FK_tblFund_foundationID]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCategories]    Script Date: 5/6/2023 3:50:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteCategories](@idStr varchar(max), @status tinyint output) as
begin
	declare @sql as nvarchar(max);
	declare @countF as int = 0;
	set @sql = N'
	select @countF = count(*) from tblFund where category_id in (' + @idStr + ')';
	exec sp_executesql @sql, 
                    N'@countF int output', @countF output;
	if (@countF > 0) 
	begin
	set @status = 0;
	return
	end
	else
	begin
	set @sql = N'delete from tblCategory where category_id in (' + @idStr + ')' ;
	exec sp_executesql @sql;
	set @status = 1;
	return
	end
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteFoundations]    Script Date: 5/6/2023 3:50:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteFoundations](@idStr varchar(max), @status tinyint output) as
begin
	declare @sql as nvarchar(max);
	declare @countF as int = 0;
	set @sql = N'
	select @countF = count(*) from tblFund where foundation_id in (' + @idStr + ')';
	exec sp_executesql @sql, 
                    N'@countF int output', @countF output;
	if (@countF > 0) 
	begin
	set @status = 0;
	return
	end
	else
	begin
	set @sql = N'delete from tblFoundation where foundation_id in (' + @idStr + ')' ;
	exec sp_executesql @sql;
	set @status = 1;
	return
	end
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteFunds]    Script Date: 5/6/2023 3:50:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteFunds](@idStr varchar(max), @status tinyint output) as
begin
	declare @sql as nvarchar(max);
	set @sql = N'delete from tblFund where fund_id in (' + @idStr + ')' ;
	exec sp_executesql @sql;
	set @status = 1;
	return
end
GO
USE [master]
GO
ALTER DATABASE [FundraiserDB] SET  READ_WRITE 
GO
