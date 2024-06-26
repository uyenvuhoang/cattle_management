USE [Cattlemanagement]
GO
/****** Object:  Table [dbo].[blog]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [varchar](255) NULL,
	[description] [varchar](max) NULL,
	[image] [varchar](255) NULL,
	[name] [varchar](255) NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK__blog__3213E83F2CFDEAAF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[categoryname] [varchar](255) NULL,
	[status] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cattle]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cattle](
	[cattle_id] [int] IDENTITY(1,1) NOT NULL,
	[date_of_birth] [varchar](255) NULL,
	[description] [varchar](255) NULL,
	[gender] [bit] NULL,
	[image] [varchar](255) NULL,
	[name] [varchar](255) NULL,
	[price] [float] NULL,
	[status] [bit] NULL,
	[cattle_category_id] [int] NULL,
	[user_id] [int] NULL,
	[weight] [float] NULL,
	[classify] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cattle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cattle_category]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cattle_category](
	[cattle_category_id] [int] IDENTITY(1,1) NOT NULL,
	[cattle_category_name] [varchar](255) NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cattle_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cattle_sale]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cattle_sale](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[address] [varchar](255) NULL,
	[assist] [bit] NULL,
	[date_recorded] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[cattle_id] [int] NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[comment] [varchar](255) NULL,
	[rating] [int] NULL,
	[product_id] [int] NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[items] [int] NULL,
	[payments] [varchar](255) NULL,
	[total] [float] NULL,
	[updatedate] [varchar](255) NULL,
	[productcart_id] [int] NULL,
	[user_id] [int] NULL,
	[status] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [varchar](255) NULL,
	[description] [varchar](max) NULL,
	[image] [varchar](255) NULL,
	[price] [float] NULL,
	[productname] [varchar](255) NULL,
	[quantity] [int] NULL,
	[sale] [float] NULL,
	[status] [varchar](255) NULL,
	[categoryid] [int] NULL,
	[user_id] [int] NULL,
	[units] [varchar](255) NULL,
 CONSTRAINT [PK__product__3213E83FA7F38590] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_cart]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_cart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[quantity] [int] NULL,
	[sellingprice] [float] NULL,
	[startdate] [varchar](255) NULL,
	[status] [bit] NULL,
	[subtotal] [float] NULL,
	[product_id] [int] NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2/23/2024 11:09:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[country] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[password] [varchar](255) NULL,
	[phone] [varchar](255) NULL,
	[role] [varchar](255) NULL,
	[username] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[blog] ON 

INSERT [dbo].[blog] ([id], [date], [description], [image], [name], [user_id]) VALUES (2, N'Wed Jan 24 21:16:50 ICT 2024', N'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. Integer Nec Odio.Praesent Libero. Sed Cursus Ante Dapibus Diam. Sed Nisi. Nulla Quis Sem At Nibh Elementum Imperdiet. Duis Sagittis Ipsum.Praesent Mauris. Fusce Nec Tellus Sed Augue Semper Porta. Mauris Massa. Vestibulum Lacinia Arcu Eget Nulla.Class Aptent Taciti Sociosqu Ad Litora Torquent Per Conubia Nostra, Per Inceptos Himenaeos. Curabitursodales Ligula In Libero.Sed Dignissim Lacinia Nunc.', N'5.jpg', N'Why Organic Food Is Full Of Benefits', NULL)
INSERT [dbo].[blog] ([id], [date], [description], [image], [name], [user_id]) VALUES (6, N'Thu Jan 25 17:22:42 ICT 2024', N'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet', N'post-7-800x394.jpg', N'How Much Sugar Does Flavored Milk Contain?', NULL)
INSERT [dbo].[blog] ([id], [date], [description], [image], [name], [user_id]) VALUES (7, N'Thu Jan 25 17:23:16 ICT 2024', N'Capios persuadere in oenipons! Hercle, sensorem peritus!, bassus poeta! Solem de bi-color competition, gratia resistentia! Ubi est gratis silva? Nunquam transferre ignigena. Verpa noceres, tanquam festus zirbus. A falsis, barcas peritus calcaria. Humani generiss messis! Eheu, noster bubo! Cum musa credere, omnes lacteaes', N'post-9-800x394.jpg', N'5 Most Popular Dairy Products According to Our Customers', 1)
SET IDENTITY_INSERT [dbo].[blog] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [categoryname], [status]) VALUES (2, N'milk', N'ok')
INSERT [dbo].[category] ([id], [categoryname], [status]) VALUES (3, N'meat', N'ok')
INSERT [dbo].[category] ([id], [categoryname], [status]) VALUES (4, N'Milk Products', N'ok')
INSERT [dbo].[category] ([id], [categoryname], [status]) VALUES (5, N'Beef products', N'ok')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[cattle] ON 

INSERT [dbo].[cattle] ([cattle_id], [date_of_birth], [description], [gender], [image], [name], [price], [status], [cattle_category_id], [user_id], [weight], [classify]) VALUES (1, N'20', N'Quality Gir Cow of 1 year(s) age is available in Hatsahi B.O, . The price of the cattle is Rs. 8000/-. Enquire Now to know more. pure 100? gir calf mixed white and red color 20ltr milk capacity( of mother) so calm and suitable for every atmosphere', 1, N'e83f550a2dc3de04a177b5b2de81676a40a27af144179ca1e90fd00604b6c6fd_595e45dd-e616-4f39-b5cb-230965e04cae_thumb.jpg', N'Gir Heifer Cow G064', 8000, 0, 1, 1, 120, N'breed cows')
INSERT [dbo].[cattle] ([cattle_id], [date_of_birth], [description], [gender], [image], [name], [price], [status], [cattle_category_id], [user_id], [weight], [classify]) VALUES (2, N'18', N'Quality Gir Cow of 3 year(s) age is available in Daldi BO, . The price of the cattle is Rs. 65000/-. The Cow is 6 month(s) pregnant The Cow is in 1st lactation. Enquire Now to know more.', 1, N'957c4bbd131a2336a81711afa0202e0a8ca14c8e5f2126dd934b4854c01dd865.jpg', N'Gir Cow G0635', 6500, 0, 1, 1, 140, N'cows for meat')
INSERT [dbo].[cattle] ([cattle_id], [date_of_birth], [description], [gender], [image], [name], [price], [status], [cattle_category_id], [user_id], [weight], [classify]) VALUES (6, N'16', N'Quality Gir Cow of 3 year(s) age is available in Sartanpar BO, . The price of the cattle is Rs. 120000/-. The Cow is in 2nd lactation. It Produces 15 Litres of milk on daily basis. Enquire Now to know more.', 1, N'c97d1f87a7c07fecd8da456a3bed98fa2ff100046c7e2480c5d74881480375ab.jpg', N'Gir Cow G0647', 1200, 0, 1, 1, 130, N'cows for meat')
INSERT [dbo].[cattle] ([cattle_id], [date_of_birth], [description], [gender], [image], [name], [price], [status], [cattle_category_id], [user_id], [weight], [classify]) VALUES (7, N'21', N'Quality Gir Cow of 3 year(s) age is available in Daldi BO, . The price of the cattle is Rs. 85000/-. The Cow is in 2nd lactation. It Produces 14 Litres of milk on daily basis. Enquire Now to know more.', 0, N'e19a97487495af7c03ec2e2318fc455e105f276b15609076cd6aa1eb76a8b253.jpg', N'Gir Cow G0633', 85000, 0, 1, 1, 160, N'breed cows')
INSERT [dbo].[cattle] ([cattle_id], [date_of_birth], [description], [gender], [image], [name], [price], [status], [cattle_category_id], [user_id], [weight], [classify]) VALUES (8, N'24', N' Quality Tharparkar Cow of 3 year(s) age is available in Krishi Upaj Mandi S.O, . The price of the cattle is Rs. 75000/-. The Cow is in 2nd lactation. It Produces 16 Litres of milk on daily basis. Enquire Now to know more.', 1, N'a77729ed89c93d1206.jpg', N'Tharparkar Cow T0150', 75000, 0, 2, 1, 130, N'cows give milk')
INSERT [dbo].[cattle] ([cattle_id], [date_of_birth], [description], [gender], [image], [name], [price], [status], [cattle_category_id], [user_id], [weight], [classify]) VALUES (9, N'17', N'Quality Tharparkar Cow of 3 year(s) age is available in Krishi Upaj Mandi S.O, . The price of the cattle is Rs. 75000/-. The Cow is in 2nd lactation. It Produces 14 Litres of milk on daily basis. Enquire Now to know more. Milk capacity per day 14 liter +', 1, N'03801946493330d49f49618e1d579bf7c400a4fd3898386b5560ec56d48e3220.jpg', N'Tharparkar Cow T0149', 75000, 1, 2, 1, 150, N'cows give milk')
SET IDENTITY_INSERT [dbo].[cattle] OFF
GO
SET IDENTITY_INSERT [dbo].[cattle_category] ON 

INSERT [dbo].[cattle_category] ([cattle_category_id], [cattle_category_name], [description]) VALUES (1, N'GIR', N' GIR COWS')
INSERT [dbo].[cattle_category] ([cattle_category_id], [cattle_category_name], [description]) VALUES (2, N'THARPARKAR', N'THARPARKAR COWS')
SET IDENTITY_INSERT [dbo].[cattle_category] OFF
GO
SET IDENTITY_INSERT [dbo].[cattle_sale] ON 

INSERT [dbo].[cattle_sale] ([id], [address], [assist], [date_recorded], [status], [cattle_id], [user_id]) VALUES (1019, NULL, 0, N'Fri Feb 23 15:05:44 ICT 2024', N'In progress', 9, 2)
SET IDENTITY_INSERT [dbo].[cattle_sale] OFF
GO
SET IDENTITY_INSERT [dbo].[comment] ON 

INSERT [dbo].[comment] ([id], [comment], [rating], [product_id], [user_id]) VALUES (1, N'very good', 4, 6, 2)
INSERT [dbo].[comment] ([id], [comment], [rating], [product_id], [user_id]) VALUES (6, N'good', 3, 6, 2)
INSERT [dbo].[comment] ([id], [comment], [rating], [product_id], [user_id]) VALUES (7, N'Good', 4, 7, 13)
INSERT [dbo].[comment] ([id], [comment], [rating], [product_id], [user_id]) VALUES (8, N'Good', 4, 7, 13)
SET IDENTITY_INSERT [dbo].[comment] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (1, 3, N'paypal', 161, N'Wed Feb 21 21:38:44 ICT 2024', NULL, 2, N'Completed')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (2, 3, N'Cash On Delivery', 161, N'Wed Feb 21 21:40:29 ICT 2024', NULL, 3, N'Completed')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (3, 4, N'VNPAY', 217, N'Wed Feb 21 21:43:28 ICT 2024', NULL, 4, N'Completed')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (4, 3, N'Cash On Delivery', 174, N'Thu Feb 22 11:01:37 ICT 2024', NULL, 2, N'In progress')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (11, 3, N'Cash On Delivery', 85, N'Thu Feb 22 21:18:14 ICT 2024', NULL, 13, N'Completed')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (12, 2, N'Cash On Delivery', 67, N'Thu Feb 22 22:54:53 ICT 2024', NULL, 13, N'In progress')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (14, 2, N'Cash On Delivery', 100, N'Fri Feb 23 19:58:52 ICT 2024', NULL, 3, N'In progress')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (15, 2, N'	Cash On Delivery', 58, N'Fri Feb 23 20:20:37 ICT 2024', NULL, 3, N'Completed')
INSERT [dbo].[orders] ([id], [items], [payments], [total], [updatedate], [productcart_id], [user_id], [status]) VALUES (16, 2, N'', 58, N'Fri Feb 23 21:25:42 ICT 2024', NULL, 4, N'In progress')
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (5, N'2024-01-10', N'Fresh meat means meat that has undergone no cooking, heating, or other processing except boning, cutting, comminuting, or freezing.', N'images13.jpg', 29, N'Fresh Meat', 2, 19, N'New', 3, 1, N'3 kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (6, N'2024-01-10', N'milk, liquid secreted by the mammary glands of female mammals to nourish their young for a period beginning immediately after birth. The milk of domesticated animals is also an important food source for humans, either as a fresh fluid or processed into a number of dairy products such as butter and cheese', N'20210922-152232-JWR2nLXf.jpg', 30, N'Milk', 2, 20, N'Sale', 2, 1, N'3 ml')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (7, N'2024-01-08', N'Ground beef, minced beef or beef mince is beef that has been finely chopped with a knife, meat grinder (American English), mincer or mincing machine (British English). It is used in many recipes including hamburgers, bolognese sauce, meatloaf, meatballs and kofta.', N'321.jpg', 30, N'ground beef', 3, 20, N'New', 3, 1, N'2 kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (9, N'2024-01-11', N'A format description is the manner in which the time crate knows how a value should be formatted and parsed. However, a format description is not a single type; it is instead represented by two internal traits (one for formatting and one for parsing) that are implemented by a number of types. Currently, all types that implement one trait also implement the other, but this is not guaranteed.', N'download1111.jpg', 50, N'fomat', 3, 40, N'Sale', 4, 1, N'1 kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (12, N'2024-02-20', N'Beef sausage is a type of processed meat product primarily made from ground beef, mixed with seasonings and spices, and packed into a casing.', N'download (1).jpg', 50, N'beef sausage', 3, 38, N'Sale', 5, 1, N'3kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (13, N'2024-02-20', N'Ground beef, minced beef or beef mince is beef that has been finely chopped with a knife, meat grinder (American English), mincer or mincing machine (British English). It is used in many recipes including hamburgers, bolognese sauce, meatloaf, meatballs and kofta.', N'aez2AoJ.jpg', 40, N'ground beef', 4, 27, N'New', 3, 1, N'0.7 kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (14, N'2024-02-20', N'Sour cream (sometimes known as soured cream in British English) is a dairy product obtained by fermenting regular cream with certain kinds of lactic acid bacteria. The bacterial culture, which is introduced either deliberately or naturally, sours and thickens the cream.', N'sua-chua-yaourt-thumbnail.jpg', 50, N'sour cream', 3, 40, N'Sale', 4, 1, N'4 ml')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (16, N'2024-02-20', N'Cream is a dairy product composed of the higher-fat layer skimmed from the top of milk before homogenization. In un-homogenized milk, the fat, which is less dense, eventually rises to the top', N'huong-yogurt.jpg', 30, N'Cream', 3, 20, N'Sale', 4, 1, N'4 ml')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (17, N'2024-02-20', N'Our Beef Leg Bone provides an all-natural, long-lasting chew that keeps your pup entertained and occupied for longer. Air-dried to lock in flavour, it also helps to clean your dog''s teeth while they chew, making it a perfect treat for larger dogs or those that love to chew.', N'xuong-bo-th-food-2.jpg', 60, N'BEEF LEG BONE', 3, 40, N'Sale', 3, 1, N'4 kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (18, N'2024-02-20', N'A sausage is a type of meat product usually made from ground meat—often pork, beef, or poultry—along with salt, spices and other flavourings. Other ingredients, such as grains or breadcrumbs may be included as fillers or extenders.', N'xuc-xich-gia-thit-gia-lam-sao-phan-biet.jpg', 50, N'Mixed sausages', 3, 40, N'New', 5, 1, N'4 kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (19, N'2024-02-20', N'Maybe the idea of it being “organ meat” makes you turn away. But I’m here to tell you there’s nothing concerning or intimating about about this cut of meat in the least. And let me put your main worry to rest by saying that while beef hearts are considered an “organ meat”, remember that hearts are a muscle so you’re not going to get any of that organ flavor, instead what you get is amplified beef.', N'tim-bo.png', 40, N'beef heart', 3, 30, N'Sale', 5, 1, N'4 kg')
INSERT [dbo].[product] ([id], [date], [description], [image], [price], [productname], [quantity], [sale], [status], [categoryid], [user_id], [units]) VALUES (20, N'2024-02-20', N'milk, liquid secreted by the mammary glands of female mammals to nourish their young for a period beginning immediately after birth. The milk of domesticated animals is also an important food source for humans, either as a fresh fluid or processed into a number of dairy products such as butter and cheese', N'thu-tuc-nhap-khau-sua-tuoi.webp', 40, N'Milk', 3, 30, N'New', 2, 1, N'3 ml')
SET IDENTITY_INSERT [dbo].[product] OFF
GO
SET IDENTITY_INSERT [dbo].[product_cart] ON 

INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (1, 2, 20, N'Tue Feb 20 22:41:50 ICT 2024', 1, 40, 16, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2, 2, 40, N'Tue Feb 20 22:41:50 ICT 2024', 1, 80, 17, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (8, 2, 40, N'Tue Feb 20 22:41:50 ICT 2024', 1, 80, 14, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (14, 1, 30, N'Tue Feb 20 22:41:50 ICT 2024', 1, 30, 19, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (1018, 2, 30, N'Wed Feb 21 20:09:17 ICT 2024', 1, 60, 20, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (1027, 1, 38, N'Wed Feb 21 20:09:17 ICT 2024', 1, 38, 12, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (1028, 2, 30, N'Wed Feb 21 20:09:17 ICT 2024', 1, 60, 19, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (1029, 1, 40, N'Wed Feb 21 20:09:17 ICT 2024', 1, 40, 18, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (1030, 2, 27, N'Wed Feb 21 21:31:57 ICT 2024', 1, 54, 13, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2027, 1, 40, N'Wed Feb 21 21:31:57 ICT 2024', 1, 40, 9, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2028, 1, 40, N'Wed Feb 21 21:31:57 ICT 2024', 1, 40, 17, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2029, 1, 40, N'Wed Feb 21 21:31:57 ICT 2024', 1, 40, 18, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2030, 3, 38, N'Wed Feb 21 21:31:57 ICT 2024', 1, 114, 12, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2031, 2, 20, N'Wed Feb 21 21:31:57 ICT 2024', 1, 40, 16, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2032, 1, 30, N'Wed Feb 21 21:31:57 ICT 2024', 1, 30, 20, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2033, 3, 27, N'Wed Feb 21 21:38:44 ICT 2024', 1, 81, 13, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2034, 2, 20, N'Wed Feb 21 21:38:44 ICT 2024', 1, 40, 16, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2035, 1, 40, N'Wed Feb 21 21:38:44 ICT 2024', 1, 40, 14, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2036, 2, 20, N'Wed Feb 21 21:40:29 ICT 2024', 1, 40, 7, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2037, 3, 27, N'Wed Feb 21 21:40:29 ICT 2024', 1, 81, 13, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2038, 1, 40, N'Wed Feb 21 21:40:29 ICT 2024', 1, 40, 14, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2039, 1, 20, N'Wed Feb 21 21:43:28 ICT 2024', 1, 20, 6, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2040, 1, 27, N'Wed Feb 21 21:43:28 ICT 2024', 1, 27, 13, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2041, 2, 40, N'Wed Feb 21 21:43:28 ICT 2024', 1, 80, 14, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2042, 3, 30, N'Wed Feb 21 21:43:28 ICT 2024', 1, 90, 20, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2043, 1, 20, N'Thu Feb 22 11:01:37 ICT 2024', 1, 20, 7, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2044, 3, 38, N'Thu Feb 22 11:01:37 ICT 2024', 1, 114, 12, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2046, 1, 40, N'Thu Feb 22 11:01:37 ICT 2024', 1, 40, 17, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2048, 2, 40, N'Thu Feb 22 11:11:20 ICT 2024', 1, 80, 9, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2049, 3, 38, N'Thu Feb 22 11:11:20 ICT 2024', 1, 114, 12, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2050, 1, 20, N'Thu Feb 22 21:06:22 ICT 2024', 1, 20, 7, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2051, 1, 20, N'Thu Feb 22 21:06:22 ICT 2024', 1, 20, 7, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2053, 1, 40, N'Thu Feb 22 21:06:22 ICT 2024', 1, 40, 9, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2054, 1, 38, N'Thu Feb 22 21:06:22 ICT 2024', 1, 38, 12, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2055, 1, 40, N'Thu Feb 22 21:06:22 ICT 2024', 1, 40, 17, 2)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2056, 3, 38, N'Thu Feb 22 21:06:22 ICT 2024', 1, 114, 12, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2057, 2, 40, N'Thu Feb 22 21:06:22 ICT 2024', 1, 80, 17, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2058, 1, 40, N'Thu Feb 22 21:06:22 ICT 2024', 1, 40, 18, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2059, 1, 40, N'Thu Feb 22 21:14:53 ICT 2024', 1, 40, 9, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2060, 1, 40, N'Thu Feb 22 21:14:53 ICT 2024', 1, 40, 17, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2061, 1, 40, N'Thu Feb 22 21:14:53 ICT 2024', 1, 40, 18, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2062, 1, 20, N'Thu Feb 22 21:18:14 ICT 2024', 1, 20, 6, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2063, 1, 27, N'Thu Feb 22 21:18:14 ICT 2024', 1, 27, 13, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2064, 1, 38, N'Thu Feb 22 21:18:14 ICT 2024', 1, 38, 12, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2065, 1, 40, N'Thu Feb 22 22:54:53 ICT 2024', 1, 40, 9, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2066, 1, 27, N'Thu Feb 22 22:54:53 ICT 2024', 1, 27, 13, 13)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2067, 2, 20, N'Fri Feb 23 19:38:32 ICT 2024', 1, 40, 7, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2069, 3, 38, N'Fri Feb 23 19:38:33 ICT 2024', 1, 114, 12, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2075, 1, 20, N'Fri Feb 23 19:58:52 ICT 2024', 1, 20, 6, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2076, 2, 40, N'Fri Feb 23 19:58:52 ICT 2024', 1, 80, 9, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2077, 1, 20, N'Fri Feb 23 20:20:37 ICT 2024', 1, 20, 6, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2078, 2, 19, N'Fri Feb 23 20:20:37 ICT 2024', 1, 38, 5, 3)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2079, 1, 38, N'Fri Feb 23 21:25:42 ICT 2024', 1, 38, 12, 4)
INSERT [dbo].[product_cart] ([id], [quantity], [sellingprice], [startdate], [status], [subtotal], [product_id], [user_id]) VALUES (2080, 1, 20, N'Fri Feb 23 21:25:42 ICT 2024', 1, 20, 16, 4)
SET IDENTITY_INSERT [dbo].[product_cart] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [country], [email], [password], [phone], [role], [username]) VALUES (1, N'SQ', N'Admin@gmail.com', N'admin123', N'039232343', N'Admin', N'Admin')
INSERT [dbo].[users] ([id], [country], [email], [password], [phone], [role], [username]) VALUES (2, N'SQ', N'chinh@gmail.com', N'1234', N'0392374543', N'User', N'chinh')
INSERT [dbo].[users] ([id], [country], [email], [password], [phone], [role], [username]) VALUES (3, N'LD', N'chi@gmail.com', N'12345', N'039403823', N'User', N'chi')
INSERT [dbo].[users] ([id], [country], [email], [password], [phone], [role], [username]) VALUES (4, N'asd', N'chu@gmail.com', N'123', N'4234234', N'User', N'chu')
INSERT [dbo].[users] ([id], [country], [email], [password], [phone], [role], [username]) VALUES (6, N'590 cach mang thang tam', N'hoa@gmail.com', N'1234', N'0423425454', N'User', N'hoa hui')
INSERT [dbo].[users] ([id], [country], [email], [password], [phone], [role], [username]) VALUES (12, N'ngo quyen', N'duong@gmail.com', N'duong123', N'0962380135', N'User', N'duong')
INSERT [dbo].[users] ([id], [country], [email], [password], [phone], [role], [username]) VALUES (13, N'HCM', N'uyen@gmail.com', N'123', N'0987654321', N'User', N'Uyen')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[blog]  WITH CHECK ADD  CONSTRAINT [FKkr2fy24puc3x3sdnla4r1iok1] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[blog] CHECK CONSTRAINT [FKkr2fy24puc3x3sdnla4r1iok1]
GO
ALTER TABLE [dbo].[cattle]  WITH CHECK ADD  CONSTRAINT [FK37uwvcvnialoyulwk5cbiw8f0] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[cattle] CHECK CONSTRAINT [FK37uwvcvnialoyulwk5cbiw8f0]
GO
ALTER TABLE [dbo].[cattle]  WITH CHECK ADD  CONSTRAINT [FKsoxvoju1pky6uuo3omia9aufg] FOREIGN KEY([cattle_category_id])
REFERENCES [dbo].[cattle_category] ([cattle_category_id])
GO
ALTER TABLE [dbo].[cattle] CHECK CONSTRAINT [FKsoxvoju1pky6uuo3omia9aufg]
GO
ALTER TABLE [dbo].[cattle_sale]  WITH CHECK ADD  CONSTRAINT [FK2k7esvc4jslq0xffheqpjw8ms] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[cattle_sale] CHECK CONSTRAINT [FK2k7esvc4jslq0xffheqpjw8ms]
GO
ALTER TABLE [dbo].[cattle_sale]  WITH CHECK ADD  CONSTRAINT [FK6qyaah8eubst7aglem0oao132] FOREIGN KEY([cattle_id])
REFERENCES [dbo].[cattle] ([cattle_id])
GO
ALTER TABLE [dbo].[cattle_sale] CHECK CONSTRAINT [FK6qyaah8eubst7aglem0oao132]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FKm1rmnfcvq5mk26li4lit88pc5] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FKm1rmnfcvq5mk26li4lit88pc5]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FKqm52p1v3o13hy268he0wcngr5] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FKqm52p1v3o13hy268he0wcngr5]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK32ql8ubntj5uh44ph9659tiih] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK32ql8ubntj5uh44ph9659tiih]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FKolpisgw5iye3yv92o1ygu2clr] FOREIGN KEY([productcart_id])
REFERENCES [dbo].[product_cart] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FKolpisgw5iye3yv92o1ygu2clr]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK47nyv78b35eaufr6aa96vep6n] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK47nyv78b35eaufr6aa96vep6n]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK4ort9abhumpx4t2mlngljr1vi] FOREIGN KEY([categoryid])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK4ort9abhumpx4t2mlngljr1vi]
GO
ALTER TABLE [dbo].[product_cart]  WITH CHECK ADD  CONSTRAINT [FK1bjryvahnabl70opha6rc0ubv] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[product_cart] CHECK CONSTRAINT [FK1bjryvahnabl70opha6rc0ubv]
GO
ALTER TABLE [dbo].[product_cart]  WITH CHECK ADD  CONSTRAINT [FKhpnrxdy3jhujameyod08ilvvw] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[product_cart] CHECK CONSTRAINT [FKhpnrxdy3jhujameyod08ilvvw]
GO
