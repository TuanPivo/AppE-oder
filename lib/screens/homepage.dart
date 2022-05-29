//flutter run --no-sound-null-safety
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_oder/model/usermodel.dart';
import 'package:sales_oder/provider/category_provider.dart';
import 'package:sales_oder/provider/product_provider.dart';
import 'package:sales_oder/screens/about.dart';
import 'package:sales_oder/screens/profilescreen.dart';
import 'package:sales_oder/screens/search_category.dart';
import 'package:sales_oder/screens/signup.dart';
import 'package:sales_oder/screens/widgets/checkout.dart';
import 'package:sales_oder/screens/widgets/notification_button.dart';
import '../model/product.dart';
import 'package:sales_oder/screens/detailscreen.dart';
import 'package:sales_oder/screens/listproduct.dart';
import 'package:sales_oder/screens/widgets/singeproduct.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

Product ipData = ipData;
Product macData = macData;
Product aipodData = aipodData;
var featureSnapShot;
var newAchivesSnapShot;
var iphone;
var macbook;
var sac;
var oplung;
var tainghe;

CategoryProvider categoryProvider = categoryProvider;
ProductProvider productProvider = productProvider;

class _HomePageState extends State<HomePage> {
  _buildCategoryProduct({required String image}) {
    return CircleAvatar(
      maxRadius: 39,
      backgroundImage: AssetImage("images/$image"),
    );
  }

  bool homecolor = true;

  bool cartcolor = false;

  bool aboutcolor = false;

  bool contactUscolor = false;
  bool profileColor = false;

  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = productProvider.userModelList;
    return Column(
        children: userModel.map((e) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          e.userName,
          style: TextStyle(color: Colors.black),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: e.userImage == null
              ? AssetImage("images/iphone.jpg")
              : NetworkImage(e.userImage) as ImageProvider,
        ),
        decoration: BoxDecoration(color: Color(0xfff2f2f2)),
        accountEmail: Text(e.userEmail, style: TextStyle(color: Colors.black)),
      );
    }).toList());
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: [
          _buildUserAccountsDrawerHeader(),
          ListTile(
            selected: homecolor,
            onTap: () {
              setState(() {
                contactUscolor = false;
                cartcolor = false;
                aboutcolor = false;
                homecolor = true;
                profileColor = false;
              });
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            selected: cartcolor,
            onTap: () {
              setState(() {
                contactUscolor = false;
                homecolor = false;
                aboutcolor = false;
                cartcolor = true;
                profileColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => CheckOut()));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          ListTile(
            selected: aboutcolor,
            onTap: () {
              setState(() {
                contactUscolor = false;
                cartcolor = false;
                homecolor = false;
                aboutcolor = true;
                profileColor = false;
              });
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => About()));
            },
            leading: Icon(Icons.info),
            title: Text("About"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                contactUscolor = false;
                cartcolor = false;
                homecolor = false;
                aboutcolor = false;
                profileColor = true;
              });
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ProfileScreen()));
            },
            leading: Icon(Icons.info),
            title: Text("Profile"),
          ),
          ListTile(
            selected: contactUscolor,
            onTap: () {
              setState(() {
                contactUscolor = true;
                homecolor = false;
                cartcolor = false;
                aboutcolor = false;
                profileColor = false;
              });
            },
            leading: Icon(Icons.phone),
            title: Text("Contact us"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => SignUp()));
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log out"),
          )
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 230,
      child: Carousel(
        autoplay: true,
        showIndicator: false,
        images: [
          AssetImage("images/iphone.jpg"),
          AssetImage("images/mac1.jpg"),
          AssetImage("images/oplung1.jpg"),
          AssetImage("images/tainghe1.jpg"),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    List<Product> iphone = categoryProvider.getIphoneList;
    List<Product> macbook = categoryProvider.getMacbookList;
    List<Product> oplung = categoryProvider.getOplungList;
    List<Product> sac = categoryProvider.getSacList;
    List<Product> tainghe = categoryProvider.getTaingheList;
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categorie",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 58,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "Iphones",
                        snapShot: iphone,
                        isCategory: false,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(image: "iphone.jpg"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "Macbook",
                        snapShot: macbook,
                        isCategory: false,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(image: "mac.jpg"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "oplung",
                        snapShot: oplung,
                        isCategory: false,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(image: "oplung.jpg"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "Sac",
                        snapShot: sac,
                        isCategory: false,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(image: "sac.jpg"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "Tainghe",
                        snapShot: tainghe,
                        isCategory: false,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(image: "tainghe.jpg"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    List<Product> feature;
    List<Product> homefeature;
    homefeature = productProvider.getHomefeatureList;
    feature = productProvider.getFeatureList;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Feature",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Feature",
                      snapShot: feature,
                      isCategory: false,
                    ),
                  ),
                );
              },
              child: Text(
                "View more",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: productProvider.getHomefeatureList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price.toDouble(),
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price.toDouble(),
                              name: e.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNewAchives() {
    List<Product> achives = productProvider.getAchivesList;
    return Column(
      children: [
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Achives",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "NewAchives",
                            snapShot: achives,
                            isCategory: false,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View more",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
            children: productProvider.getHomeAchivesList.map((e) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailScreen(
                                      image: e.image,
                                      price: e.price.toDouble(),
                                      name: e.name,
                                    ),
                                  ),
                                );
                              },
                              child: SingleProduct(
                                  image: e.image, price: e.price, name: e.name),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                    image: e.image,
                                    price: e.price.toDouble(),
                                    name: e.name,
                                  ),
                                ),
                              );
                            },
                            child: SingleProduct(
                                image: e.image, price: e.price, name: e.name),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList()),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider.getIphoneData();
    categoryProvider.getMacbookData();
    categoryProvider.getOplungData();
    categoryProvider.getSacData();
    categoryProvider.getTaingheData();

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getAchivesData();
    productProvider.getFeatureData();
    productProvider.getHomefeatureData();
    productProvider.getHomeAchivesData();
    productProvider.getUserData();

    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: Text(
          "Home Phone",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchCategory());
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          NotificationButton(),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSlider(),
                  _buildCategory(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildFeature(),
                  _buildNewAchives(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
