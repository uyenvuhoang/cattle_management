import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cattle_management/service/Odersservice.dart';
import 'package:cattle_management/service/Productservice.dart';
import 'package:cattle_management/service/user_provider.dart';
import 'package:cattle_management/ui/AboutUsPage.dart';
import 'package:cattle_management/ui/LoginPage.dart';
import 'package:cattle_management/ui/RegisterPage.dart';
import 'package:cattle_management/ui/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'ContactUsPage.dart';
import 'ProductPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> productList = [];

  int selectedButton = 1;
  int colorChangeButton = 0;
  int colorChangeButton1 = 0;
  bool _status = false;
  void changeColor(int buttonIndex) {
    setState(() {
      colorChangeButton = buttonIndex;
    });
  }

  void changeColor1(int buttonIndex) {
    setState(() {
      colorChangeButton1 = buttonIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      // Gọi hàm lấy dữ liệu khách hàng từ API
      List<Map<String, dynamic>> products =
          await Productservice().getProducts();

      setState(() {
        productList = products;
      });
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error loading products: $e');
      // Hiển thị thông báo lỗi cho người dùng nếu cần thiết
      // showDialog(context: context, builder: (context) => AlertDialog(title: Text('Error'), content: Text('Failed to load customers. $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Text(
                'Dairy',
                style: TextStyle(
                    color: Color(0xFF3e6d99),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              Image(
                image: AssetImage('assets/cow-logo.png'),
                height: 60,
                width: 60,
              ),
              SizedBox(width: 6),
              Text('Farm',
                  style: TextStyle(
                      color: Color(0xFFbdc53b),
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 80),
              Icon(
                Icons.search,
                size: 25,
                color: Color(0xFF3e6d99),
              ),
              SizedBox(width: 20),
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFbdc53b),
                  ),
                  child: PopupMenuButton(
                    color: Colors.black87,
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: GestureDetector(
                          child: Column(
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                    color: Color(0xFF3e6d99),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Consumer<UserProvider>(
                                  builder: (context, userProvider, child) {
                                return Text(userProvider.username,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal));
                              }),
                              Consumer<UserProvider>(
                                  builder: (context, userProvider, child) {
                                return Text(userProvider.email,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal));
                              }),
                              SizedBox(height: 15),
                              userProvider.isLoggedIn
                                  ? GestureDetector(
                                      onTap: () {
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .logout();
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF848b21),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));
                                          },
                                          child: Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF848b21),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPage()));
                                          },
                                          child: Text(
                                            'REGISTER',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF848b21),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      body: ListView(
        // padding: EdgeInsets.zero,
        children: [
          // Start Banner
          CarouselSlider(
            options: CarouselOptions(
              height: 500,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(milliseconds: 700),
              viewportFraction: 1,
            ),
            items: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/carousel-1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Overlay
                    child: Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              0.5), // Màu overlay với độ trong suốt
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'FRESH',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFc9d14c)),
                            ),
                            Text(
                              'DAIRY PRODUCE',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Nulla Quis Sem At Nibh Elementum Imperdiet Fusce Nec Tellus Sed Augue Semper Porta Vestibulum Lacinia Arcu Eget Nulla!',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFd7d7d7)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 18),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'SHOP NOW',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF629bd0),
                                fixedSize: Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      3), // Độ bo tròn góc của nút
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/carousel-2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Overlay
                    child: Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              0.5), // Màu overlay với độ trong suốt
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'ORGANIC',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFc9d14c)),
                            ),
                            Text(
                              'MILK PRODUCTS',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Nulla Quis Sem At Nibh Elementum Imperdiet Fusce Nec Tellus Sed Augue Semper Porta Vestibulum Lacinia Arcu Eget Nulla!',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFd7d7d7)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 18),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'SHOP NOW',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF629bd0),
                                fixedSize: Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      3), // Độ bo tròn góc của nút
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Hinh-anh-bo-1-800x532.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Overlay
                    child: Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              0.5), // Màu overlay với độ trong suốt
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'FRESH',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFc9d14c)),
                            ),
                            Text(
                              'DAIRY PRODUCE',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Nulla Quis Sem At Nibh Elementum Imperdiet Fusce Nec Tellus Sed Augue Semper Porta Vestibulum Lacinia Arcu Eget Nulla!',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFd7d7d7)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 18),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'SHOP NOW',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF629bd0),
                                fixedSize: Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      3), // Độ bo tròn góc của nút
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // End Banner

          // Start Quality Tested by Time
          SizedBox(height: 18),
          Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFFc9d14c),
            child: Stack(
              children: [
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/pngtree-dry-barley-and-greek-yogurt-served-in-a-rustic-wooden-bowl-photo-image_38928526.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Overlay
                  child: Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black
                            .withOpacity(0.5), // Màu overlay với độ trong suốt
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Quality Tested by Time',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFc9d14c)),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'We are the leading producer and processor of store-brand organic dairy products for U.S. retailers. Based in California, we deliver high-quality dairy products that are nationally recognized.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(height: 18),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'READ MORE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFc9d14c),
                                fixedSize: Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // End Quality Tested by Time

          // Start Welcome To Our Farm
          SizedBox(height: 18),
          Title(
            color: Color(0xFF2f567a),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'WELCOME TO OUR FARM',
                style: TextStyle(
                  color: Color(0xFF2f567a),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 500,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(milliseconds: 700),
              viewportFraction: 1,
            ),
            items: [
              SizedBox(
                width: 370,
                height: 520,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: EdgeInsets.all(18),
                      children: [
                        Image(
                          image: AssetImage('assets/8 (1).jpg'),
                        ),
                        Title(
                          color: Color(0xFF2f567a),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "OUR PRODUCT",
                                  style: TextStyle(
                                    color: Color(0xFF2f567a),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ),
                        Text(
                          "We provide our customers with a wide variety of dairy products, from organic milk to butter and cheese.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('READ MORE'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 370,
                // height: 520,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: EdgeInsets.all(18),
                      children: [
                        Image(
                          image: AssetImage('assets/9 (1).jpg'),
                        ),
                        Title(
                          color: Color(0xFF2f567a),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "WHY ORGANIC?",
                                  style: TextStyle(
                                    color: Color(0xFF2f567a),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ),
                        Text(
                          "We provide our customers with a wide variety of dairy products, from organic milk to butter and cheese.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('READ MORE'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 370,
                height: 520,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: EdgeInsets.all(18),
                      children: [
                        Image(
                          image: AssetImage('assets/download.jpg'),
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Title(
                          color: Color(0xFF2f567a),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "WORKING PROCESS",
                                  style: TextStyle(
                                    color: Color(0xFF2f567a),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ),
                        Text(
                          "We provide our customers with a wide variety of dairy products, from organic milk to butter and cheese.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('READ MORE'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // End Welcome To Our Farm

          // Start New Products
          Title(
            color: Color(0xFF2f567a),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'PRODUCTS',
                style: TextStyle(
                  color: Color(0xFF2f567a),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 370,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(milliseconds: 700),
              viewportFraction: 0.5,
            ),
            items: productList.map((product) {
              var _quantity = 1;
              var _sellingprice = product['sale'];
              var _subtotal = product['sale'];
              var _productid = product['id'];
              var _userid = userProvider.id;
              return Builder(
                builder: (BuildContext context) {
                  return ListView(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 170,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/${product['image']}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Container(
                              width: 70,
                              height: 30,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Color(0xFF629bd0),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                'SALE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Text(
                        product['productname'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF43567a),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 18),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$${product['price']}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: '\t\t\t\$' +
                                  product['sale']
                                      .toString(), // Có thể thay đổi nếu cần
                              style: TextStyle(
                                color: Color(0xFF6c9dd0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF629bd0),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        productDetails: product['id']),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF629bd0), // Màu nền của nút
                                  shape: CircleBorder(),
                                  padding:
                                      EdgeInsets.all(10) // Hình dạng hình tròn
                                  ),
                              child: Icon(
                                Icons.production_quantity_limits,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFc9d14c),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (userProvider.isLoggedIn) {
                                  Odersservice().createOrder(
                                      _quantity,
                                      _sellingprice,
                                      _status,
                                      _productid,
                                      _userid);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('add to cart successfully'),
                                          backgroundColor: Colors.blue));
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFc9d14c), // Màu nền của nút
                                  shape: CircleBorder(),
                                  padding:
                                      EdgeInsets.all(10) // Hình dạng hình tròn
                                  ),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          // End New Products

          // Start Why Choose Us
          Title(
            color: Color(0xFF2f567a),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'WHY CHOOSE US',
                style: TextStyle(
                  color: Color(0xFF2f567a),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFc9d14c),
                ),
                child: Icon(
                  Icons.house_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'MODERN FARM',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325976)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Milk Farm is a fully innovative farm, which combines modern methods of dairy production with traditions.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Divider(
                  height: 0,
                  thickness: 0,
                ),
              )
            ],
          ),
          SizedBox(height: 18),
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFc9d14c),
                ),
                child: Icon(
                  Icons.house_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'NO PESTICIDES',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325976)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Milk Farm is a fully innovative farm, which combines modern methods of dairy production with traditions.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Image(image: AssetImage('assets/19 (1).jpg')),
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFc9d14c),
                ),
                child: Icon(
                  Icons.house_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '100% ORGANIC',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325976)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Milk Farm is a fully innovative farm, which combines modern methods of dairy production with traditions.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Divider(
                  height: 0,
                  thickness: 0,
                ),
              )
            ],
          ),
          SizedBox(height: 18),
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFc9d14c),
                ),
                child: Icon(
                  Icons.house_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'NATURAL FEED',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325976)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Milk Farm is a fully innovative farm, which combines modern methods of dairy production with traditions.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          // End Why Choose Us

          // Start Summer Sale
          SizedBox(
            height: 500,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/F-Sua-va-cac-san-pham-tu-sua.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Overlay
                  child: Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SUMMER SALE',
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFc9d14c)),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '-40%',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF629bd0))),
                            TextSpan(
                                text: ' ON ALL PRODUCTS',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ])),
                          Padding(
                            padding: EdgeInsets.all(18),
                            child: Text(
                              'Purchase the best organic dairy products for your family at our online shop and save more money than anywhere else.',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFFd7d7d7)),
                            ),
                          ),
                          SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'SHOP NOW',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF629bd0),
                              fixedSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // End Summer Sale

          // Start About Us
          Title(
            color: Color(0xFF2f567a),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'ABOUT US',
                style: TextStyle(
                  color: Color(0xFF2f567a),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(18),
                child: Image(image: AssetImage('assets/211.jpg')),
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedButton = 1;
                        changeColor(1);
                      });
                    },
                    child: Text(
                      'OUR MISSION',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: colorChangeButton == 1
                          ? Color(0xFF629bd0)
                          : Color(0xFFf2f9ff),
                      foregroundColor: colorChangeButton == 1
                          ? Colors.white
                          : Color(0xFF629bd0),
                      fixedSize: Size(140, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedButton = 2;
                        changeColor(2);
                      });
                    },
                    child: Text(
                      'QUALITY CONTROL',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: colorChangeButton == 2
                          ? Color(0xFF629bd0)
                          : Color(0xFFf2f9ff),
                      foregroundColor: colorChangeButton == 2
                          ? Colors.white
                          : Color(0xFF629bd0),
                      fixedSize: Size(190, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedButton = 3;
                        changeColor(3);
                      });
                    },
                    child: Text(
                      'OUR GOALS',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: colorChangeButton == 3
                          ? Color(0xFF629bd0)
                          : Color(0xFFf2f9ff),
                      foregroundColor: colorChangeButton == 3
                          ? Colors.white
                          : Color(0xFF629bd0),
                      fixedSize: Size(130, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Visibility(
                        visible: selectedButton == 1,
                        child: Column(
                          children: [
                            Text(
                              'INTEGRATING INNOVATIONS INTO DAIRY TRADITIONS',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2f567a)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Our mission is to create a sustainable, environmentally and technologically advanced dairy farm. We adhere to traditions of raising cows naturally combined with innovations.Our mission is to create a sustainable, environmentally and technologically advanced dairy farm. We adhere to traditions of raising cows naturally combined with innovations.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )),
                    Visibility(
                        visible: selectedButton == 2,
                        child: Column(
                          children: [
                            Text(
                              'ENSURING THE HIGHEST QUALITY OF OUR PRODUCTS',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2f567a)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Our mission is to create a sustainable, environmentally and technologically advanced dairy farm. We adhere to traditions of raising cows naturally combined with innovations.Our mission is to create a sustainable, environmentally and technologically advanced dairy farm. We adhere to traditions of raising cows naturally combined with innovations.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )),
                    Visibility(
                        visible: selectedButton == 3,
                        child: Column(
                          children: [
                            Text(
                              'OUR POSITION IS PRINCIPLED TO FEED YOU WITH TASTY PRODUCE',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2f567a)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Our mission is to create a sustainable, environmentally and technologically advanced dairy farm. We adhere to traditions of raising cows naturally combined with innovations.Our mission is to create a sustainable, environmentally and technologically advanced dairy farm. We adhere to traditions of raising cows naturally combined with innovations.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
                child: Text(
                  'READ MORE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFc9d14c),
                  fixedSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          // End About Us

          // Start Our Team
          Title(
            color: Color(0xFF2f567a),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'OUR TEAM',
                style: TextStyle(
                  color: Color(0xFF2f567a),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  child: Container(
                width: 370,
                height: 370,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFe1f0ff),
                    width: 15,
                  ),
                ),
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/222.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
              SizedBox(height: 18),
              Text(
                'Lorem Magnis',
                style: TextStyle(
                    color: Color(0xFF325976),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Richard has a wide experience in every dairy farming aspect as he’s been in the industry for over 20 years.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      changeColor1(1);
                    },
                    child: Icon(
                      FontAwesomeIcons.rss,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 1
                          ? Color(0xFFf56505)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(2);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 2
                          ? Color(0xFF3b5998)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(3);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 3
                          ? Color(0xFF33ccff)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(4);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.googlePlusG,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 4
                          ? Color(0xFFbd3518)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(5);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 5
                          ? Color(0xFF007bb7)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18),
          Column(
            children: [
              SizedBox(
                  child: Container(
                width: 370,
                height: 370,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFe1f0ff),
                    width: 15,
                  ),
                ),
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/223.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
              SizedBox(height: 18),
              Text(
                'Eget Nulla',
                style: TextStyle(
                    color: Color(0xFF325976),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Richard has a wide experience in every dairy farming aspect as he’s been in the industry for over 20 years.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      changeColor1(6);
                    },
                    child: Icon(
                      FontAwesomeIcons.rss,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 6
                          ? Color(0xFFf56505)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(7);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 7
                          ? Color(0xFF3b5998)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(8);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 8
                          ? Color(0xFF33ccff)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(9);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.googlePlusG,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 9
                          ? Color(0xFFbd3518)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(10);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 10
                          ? Color(0xFF007bb7)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18),
          Column(
            children: [
              SizedBox(
                  child: Container(
                width: 370,
                height: 370,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFe1f0ff),
                    width: 15,
                  ),
                ),
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/224.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
              SizedBox(height: 18),
              Text(
                'Dapibus Diam',
                style: TextStyle(
                    color: Color(0xFF325976),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Richard has a wide experience in every dairy farming aspect as he’s been in the industry for over 20 years.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      changeColor1(11);
                    },
                    child: Icon(
                      FontAwesomeIcons.rss,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 11
                          ? Color(0xFFf56505)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(12);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 12
                          ? Color(0xFF3b5998)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(13);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 13
                          ? Color(0xFF33ccff)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(14);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.googlePlusG,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 14
                          ? Color(0xFFbd3518)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeColor1(15);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorChangeButton1 == 15
                          ? Color(0xFF007bb7)
                          : Color(0xFFc9d14c),
                      fixedSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // End Our Team

          // Start Featured Dairy Recipes
          SizedBox(height: 18),
          SizedBox(
            height: 500,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/4494012_Cover_2048x1268_milk.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Overlay
                  child: Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Featured Dairy Recipes',
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFc9d14c)),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'FROM OUR FARMERS',
                            style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Purchase the best organic dairy products for your family at our online shop and save more money than anywhere else.',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFFd7d7d7)),
                          ),
                          SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'READ MORE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF629bd0),
                              fixedSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // End Featured Dairy Recipes

          // Start Our Clients
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Title(
                  color: Color(0xFF2f567a),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'OUR CLIENTS',
                      style: TextStyle(
                        color: Color(0xFF2f567a),
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 370,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 700),
                    viewportFraction: 1,
                  ),
                  items: [
                    SizedBox(
                      width: 370,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ListView(
                            padding: EdgeInsets.all(18),
                            children: [
                              Title(
                                  color: Color(0xFF2f567a),
                                  child: Text(
                                    'Best Dairy',
                                    style: TextStyle(
                                      color: Color(0xFF2f567a),
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(height: 18),
                              Text(
                                'You have the best milk in the whole state! I’ve never tasted something this tasty and I think of becoming your regular client.',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 18),
                              Center(
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/226.jpg'),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Eget Nulla',
                                style: TextStyle(
                                    color: Color(0xFF629bd0),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'From USA',
                                style: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 370,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ListView(
                            padding: EdgeInsets.all(18),
                            children: [
                              Title(
                                  color: Color(0xFF2f567a),
                                  child: Text(
                                    'Nice Farm',
                                    style: TextStyle(
                                      color: Color(0xFF2f567a),
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(height: 18),
                              Text(
                                'Milk Farm is awesome in many ways. It has the best farmers and a wide range of great dairy products that I regularly buy.',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 18),
                              Center(
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/227.jpg'),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Dapibus Diam',
                                style: TextStyle(
                                    color: Color(0xFF629bd0),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'From Australia',
                                style: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 370,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ListView(
                            padding: EdgeInsets.all(18),
                            children: [
                              Title(
                                  color: Color(0xFF2f567a),
                                  child: Text(
                                    'Best Product',
                                    style: TextStyle(
                                      color: Color(0xFF2f567a),
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(height: 18),
                              Text(
                                'You have the best milk in the whole state! I’ve never tasted something this tasty and I think of becoming your regular client.',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 18),
                              Center(
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/228.jpg'),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Semper Porta',
                                style: TextStyle(
                                    color: Color(0xFF629bd0),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'From India',
                                style: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // End Our Clients

          // Start Latest News
          SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Title(
                  color: Color(0xFF2f567a),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'LATEST NEWS',
                      style: TextStyle(
                        color: Color(0xFF2f567a),
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    height: 470,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/20170328140903-sua1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),

                          // Overlay
                          child: Positioned.fill(
                            child: Container(
                              padding: EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'August 19, 2021',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 14),
                                  Text(
                                    'How Milk is Produced Nowadays: Interview with Our Founder',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/30 (1).jpg'),
                            ),
                            SizedBox(height: 14),
                            Text(
                              'August 19, 2020',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Can Innovations Improve Dairy Production?',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF325976)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/31 (1).jpg'),
                            ),
                            SizedBox(height: 14),
                            Text(
                              'August 19, 2020',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Why You Should Avoid Pesticides in Your Milk',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF325976)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // End Latest News

          // Start News Letter
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Title(
                  color: Color(0xFF2f567a),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'NEWS LETTER',
                      style: TextStyle(
                        color: Color(0xFF2f567a),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Subscribe to our newsletter and get ',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      TextSpan(
                          text: '20%',
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFF629bd0))),
                      TextSpan(
                          text: '  off your first purchase',
                          style: TextStyle(fontSize: 18, color: Colors.black))
                    ])),
                  ],
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFeeeeee)),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30),
                                right: Radius.circular(0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFeeeeee)),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30),
                                right: Radius.circular(0),
                              ),
                            ),
                            hintText: 'Your Email',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'SUBSCRIBE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF629bd0),
                          fixedSize: Size(150, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(0),
                              right: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // End News Letter

          // Start Footer
          Container(
            color: Color(0xFFfeffe7),
            child: Column(
              children: [
                Title(
                  color: Color(0xFF2f567a),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'GALLERY',
                      style: TextStyle(
                        color: Color(0xFF2f567a),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Image(
                      image: AssetImage('assets/download (1).jpg'),
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    )),
                    Container(
                        child: Image(
                      image: AssetImage('assets/images (1).jpg'),
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    )),
                    Container(
                        child: Image(
                      image: AssetImage('assets/download (2).jpg'),
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    )),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Image(
                      image: AssetImage('assets/thit.jpg'),
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    )),
                    Container(
                        child: Image(
                      image: AssetImage('assets/images (2).jpg'),
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    )),
                    Container(
                        child: Image(
                      image: AssetImage('assets/14488728322181.jpg'),
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    )),
                  ],
                ),
                Title(
                  color: Color(0xFF2f567a),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'QUICK LINKS',
                      style: TextStyle(
                        color: Color(0xFF2f567a),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Our Farmers',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'New Products',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Top Sellers',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'About Us',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Fag',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Cheese and Curds',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Milk Products',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Butter',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Yogurt',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Ice Cream',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_right, color: Color(0xFF629bd0)),
                            Text(
                              'Other',
                              style: TextStyle(
                                  color: Color(0xFF325976),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Title(
                  color: Color(0xFF2f567a),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'GET IN TOUCH',
                      style: TextStyle(
                        color: Color(0xFF2f567a),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18, bottom: 18),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.solidMap,
                              color: Color(0xFF629bd0)),
                          SizedBox(width: 10),
                          Text(
                            ' Address :  -312/Gonia, Canada',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18, bottom: 18),
                      child: Row(
                        children: [
                          Icon(Icons.phone, color: Color(0xFF629bd0)),
                          SizedBox(width: 10),
                          Text(
                            '+91 (123) 456 7890',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18, bottom: 18),
                      child: Row(
                        children: [
                          Icon(Icons.email, color: Color(0xFF629bd0)),
                          SizedBox(width: 10),
                          Text(
                            'Info@gmail.com',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            changeColor1(16);
                          },
                          child: Icon(
                            FontAwesomeIcons.rss,
                            color: Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorChangeButton1 == 16
                                ? Color(0xFFf56505)
                                : Color(0xFFc9d14c),
                            fixedSize: Size(45, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              changeColor1(17);
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorChangeButton1 == 17
                                ? Color(0xFF3b5998)
                                : Color(0xFFc9d14c),
                            fixedSize: Size(45, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              changeColor1(18);
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorChangeButton1 == 18
                                ? Color(0xFF33ccff)
                                : Color(0xFFc9d14c),
                            fixedSize: Size(45, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              changeColor1(19);
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.googlePlusG,
                            color: Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorChangeButton1 == 19
                                ? Color(0xFFbd3518)
                                : Color(0xFFc9d14c),
                            fixedSize: Size(45, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              changeColor1(20);
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.linkedinIn,
                            color: Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorChangeButton1 == 20
                                ? Color(0xFF007bb7)
                                : Color(0xFFc9d14c),
                            fixedSize: Size(45, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Divider(
                  thickness: 1,
                  color: Color(0xFFfaffaa),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 18, top: 10, bottom: 10, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: '© 2024 Your Website Cattle Management System ',
                          style: TextStyle(fontSize: 16.5, color: Colors.black),
                        ),
                        TextSpan(
                            text: 'TemplateOnWeb',
                            style: TextStyle(
                                fontSize: 16.5,
                                height: 1.5,
                                color: Color(0xFF629bd0))),
                      ])),
                    ],
                  ),
                )
              ],
            ),
          ),
          // End Footer
        ],
      ),
    );
  }
}
