import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_oder/model/cartmodel.dart';
import 'package:sales_oder/provider/product_provider.dart';
import 'package:sales_oder/screens/homepage.dart';
import 'package:sales_oder/screens/widgets/cartsingleproduct.dart';
import 'package:sales_oder/screens/widgets/notification_button.dart';

import 'mybutton.dart';

class CheckOut extends StatefulWidget {
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ProductProvider productProvider;
  Widget _buildBottomDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          endName,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  late User user;
  late double total;
  late List<CartModel> myList;

  Widget _buildButton() {
    return Column(
        children: productProvider.userModelList.map((e) {
      return Container(
        height: 55,
        child: MyButton(
          name: "Buy",
          onPressed: () {
            if (productProvider.getCheckOutModelList.isNotEmpty) {
              FirebaseFirestore.instance.collection("Order").add({
                "Product": productProvider.getCheckOutModelList
                    .map((c) => {
                          "ProductName": c.name,
                          "ProductPrice": c.price,
                          "ProductQuetity": c.quentity,
                          "ProductImage": c.image,
                        })
                    .toList(),
                "TotalPrice": total.toStringAsFixed(2),
                "UserName": e.userName,
                "UserEmail": e.userEmail,
                "UserNumber": e.userPhoneNumber,
                "UserAddress": e.userAddress,
                "UserId": user.uid,
              });
              setState(() {
                myList.clear();
              });

              productProvider.addNotification("Notification");
            } else {
              _scaffoldKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text("No Item Yet"),
                ),
              );
            }
          },
        ),
      );
    }).toList());
  }

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser!;
    double subTotal = 0;
    double discount = 3;
    double discountRupees;
    double shipping = 60;

    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.getCheckOutModelList.forEach((element) {
      subTotal += element.price * element.quentity;
    });
    discountRupees = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupees;

    if (productProvider.checkOutModelList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout Page",
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
      bottomNavigationBar: Container(
        height: 70,
        width: 90,
        padding: EdgeInsets.only(bottom: 15),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: _buildButton(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (ctx, myIndex) {
                    return CartSingleProduct(
                      index: myIndex,
                      image: myList[myIndex].image,
                      name: myList[myIndex].name,
                      price: myList[myIndex].price,
                      quentity: myList[myIndex].quentity,
                      isCount: false,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomDetail(
                      startName: "Your Price",
                      endName: "\$ ${subTotal.toStringAsFixed(2)}",
                    ),
                    _buildBottomDetail(
                      startName: "Discount",
                      endName: "\$ ${discount.toStringAsFixed(2)}%",
                    ),
                    _buildBottomDetail(
                      startName: "Shipping",
                      endName: "\$ ${shipping.toStringAsFixed(2)}",
                    ),
                    _buildBottomDetail(
                      startName: "Total",
                      endName: "\$ ${total.toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
