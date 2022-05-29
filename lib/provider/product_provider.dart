import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_oder/model/cartmodel.dart';
import 'package:sales_oder/model/product.dart';
import 'package:sales_oder/model/usermodel.dart';

class ProductProvider with ChangeNotifier {
  List<UserModel> userModelList = [];
  late UserModel userModel;

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot<Map> userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();
    userSnapShot.docs.forEach(
      (element) {
        if (currentUser!.uid == element.data()["UserId"]) {
          userModel = UserModel(
              userEmail: element.data()["UserEmail"],
              userImage: element.data()["UserImage"],
              userAddress: element.data()["UserAddress"],
              userGender: element.data()["UserGender"],
              userName: element.data()["UserName"],
              userPhoneNumber: element.data()["UserNumber"]);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  List<CartModel> cartModelList = [];
  late CartModel cartModel = cartModel;
  void getCartData({
    required String name,
    required String image,
    required double price,
    required int quentity,
  }) {
    cartModel = CartModel(
      price: price.toDouble(),
      name: name,
      image: image,
      // size: size,
      // color: color,
      quentity: quentity,
    );
    cartModelList.add(cartModel);
  }

  List<CartModel> get getCartModelList {
    return List.from(cartModelList);
  }

  int get getCartModelListLength {
    return cartModelList.length;
  }

  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel = cartModel;

  void getCheckOutData({
    required String name,
    required String image,
    required double price,
    required int quentity,
  }) {
    checkOutModel = CartModel(
      price: price.toDouble(),
      name: name,
      image: image,
      // size: size,
      // color: color,
      quentity: quentity,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  List<Product> feature = [];
  late Product featureData = featureData;
  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> featureSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("brEs92x4jsXBNszxzhGf")
        .collection("featureproduct")
        .get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(featureData);
      },
    );
    feature = newList;
  }

  List<Product> get getFeatureList {
    return feature;
  }

  List<Product> achives = [];
  late Product achivesData = achivesData;

  Future<void> getAchivesData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> achivesSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("brEs92x4jsXBNszxzhGf")
        .collection("featureproduct")
        .get();
    achivesSnapShot.docs.forEach(
      (element) {
        achivesData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(achivesData);
      },
    );
    achives = newList;
    notifyListeners();
  }

  List<Product> get getAchivesList {
    return achives;
  }

  List<Product> homefeature = [];
  late Product homefeatureData = homefeatureData;

  Future<void> getHomefeatureData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> homefeatureSnapShot =
        await FirebaseFirestore.instance.collection("homefeature").get();
    homefeatureSnapShot.docs.forEach(
      (element) {
        homefeatureData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(homefeatureData);
      },
    );
    homefeature = newList;
    notifyListeners();
  }

  List<Product> get getHomefeatureList {
    return homefeature;
  }

  List<Product> homeAchives = [];
  late Product homeAchivesData = homeAchivesData;

  Future<void> getHomeAchivesData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> homeAchivesSnapShot =
        await FirebaseFirestore.instance.collection("homeachives").get();
    homeAchivesSnapShot.docs.forEach(
      (element) {
        homeAchivesData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(homeAchivesData);
      },
    );
    homeAchives = newList;
    notifyListeners();
  }

  List<Product> get getHomeAchivesList {
    return homefeature;
  }

  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  late List<Product> searchList;
  void getSearchList({required List<Product> list}) {
    searchList = list;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchPhone = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchPhone;
  }
}
