import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_oder/model/product.dart';

class CategoryProvider with ChangeNotifier {
  List<Product> iphone = [];
  late Product iphoneData = iphoneData;
  List<Product> macbook = [];
  late Product macbookData = macbookData;
  List<Product> oplung = [];
  late Product oplungData = oplungData;
  List<Product> sac = [];
  late Product sacData = sacData;
  List<Product> tainghe = [];
  late Product taingheData = taingheData;

  Future<void> getIphoneData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> iphoneSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("0xar1kzGcdfnlsCwXMtK")
        .collection("iphone")
        .get();
    iphoneSnapShot.docs.forEach(
      (element) {
        iphoneData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(iphoneData);
      },
    );
    iphone = newList;
    notifyListeners();
  }

  List<Product> get getIphoneList {
    return iphone;
  }

  Future<void> getMacbookData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> macbookSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("0xar1kzGcdfnlsCwXMtK")
        .collection("macbook")
        .get();
    macbookSnapShot.docs.forEach(
      (element) {
        macbookData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(macbookData);
      },
    );
    macbook = newList;
    notifyListeners();
  }

  List<Product> get getMacbookList {
    return macbook;
  }

  Future<void> getOplungData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> oplungSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("0xar1kzGcdfnlsCwXMtK")
        .collection("oplung")
        .get();
    oplungSnapShot.docs.forEach(
      (element) {
        oplungData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(oplungData);
      },
    );
    oplung = newList;
    notifyListeners();
  }

  List<Product> get getOplungList {
    return oplung;
  }

  Future<void> getSacData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> sacSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("0xar1kzGcdfnlsCwXMtK")
        .collection("sac")
        .get();
    sacSnapShot.docs.forEach(
      (element) {
        sacData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(sacData);
      },
    );
    sac = newList;
    notifyListeners();
  }

  List<Product> get getSacList {
    return sac;
  }

  Future<void> getTaingheData() async {
    List<Product> newList = [];
    QuerySnapshot<Map> taingheSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("0xar1kzGcdfnlsCwXMtK")
        .collection("tainghe")
        .get();
    taingheSnapShot.docs.forEach(
      (element) {
        taingheData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(taingheData);
      },
    );
    tainghe = newList;
    notifyListeners();
  }

  List<Product> get getTaingheList {
    return tainghe;
  }

  late List<Product> searchList;
  void getSearchList({required List<Product> list}) {
    searchList = list;
  }

  List<Product> searchCategoryList(String query) {
    List<Product> searchPhone = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchPhone;
  }
}
