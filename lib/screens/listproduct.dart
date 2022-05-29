import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_oder/model/product.dart';
import 'package:sales_oder/provider/category_provider.dart';
import 'package:sales_oder/provider/product_provider.dart';
import 'package:sales_oder/screens/homepage.dart';
import 'package:sales_oder/screens/search_category.dart';
import 'package:sales_oder/screens/search_product.dart';
import 'package:sales_oder/screens/widgets/singeproduct.dart';

class ListProduct extends StatelessWidget {
  bool isCategory;
  final String name;
  final List<Product> snapShot;
  ListProduct(
      {Key? key,
      required this.name,
      required this.snapShot,
      required this.isCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        actions: [
          isCategory == true
              ? IconButton(
                  onPressed: () {
                    categoryProvider.getSearchList(list: snapShot);
                    showSearch(context: context, delegate: SearchCategory());
                  },
                  icon: Icon(Icons.search),
                  color: Colors.black,
                )
              : IconButton(
                  onPressed: () {
                    productProvider.getSearchList(list: snapShot);
                    showSearch(context: context, delegate: SearchProduct());
                  },
                  icon: Icon(Icons.search),
                  color: Colors.black,
                ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
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
                            name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 700,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    scrollDirection: Axis.vertical,
                    children: snapShot
                        .map(
                          (e) => SingleProduct(
                              image: e.image, name: e.name, price: e.price),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
