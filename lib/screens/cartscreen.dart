import 'package:flutter/material.dart';
import 'package:sales_oder/screens/detailscreen.dart';
import 'package:sales_oder/screens/homepage.dart';
import 'package:sales_oder/screens/widgets/cartsingleproduct.dart';
import 'package:sales_oder/screens/widgets/checkout.dart';
import 'package:sales_oder/screens/widgets/notification_button.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

late ProductProvider productProvider;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        padding: EdgeInsets.only(bottom: 18),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: RaisedButton(
          color: Colors.pink,
          child: Text(
            "Continue",
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            productProvider.addNotification("Notification");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CheckOut(),
              ),
            );
          },
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => HomePage()));
          },
        ),
        actions: [
          NotificationButton(),
        ],
      ),
      body: ListView.builder(
        itemCount: productProvider.getCartModelListLength,
        itemBuilder: (ctx, index) => CartSingleProduct(
          isCount: false,
          index: index,
          image: productProvider.getCartModelList[index].image,
          name: productProvider.getCartModelList[index].name,
          price: productProvider.getCartModelList[index].price,
          quentity: productProvider.getCartModelList[index].quentity,
        ),
      ),
    );
  }
}
