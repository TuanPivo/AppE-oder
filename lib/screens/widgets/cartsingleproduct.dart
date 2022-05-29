import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_oder/provider/product_provider.dart';
import 'package:sales_oder/screens/cartscreen.dart';

class CartSingleProduct extends StatefulWidget {
  late final String name;
  late final String image;
  final bool isCount;
  int quentity;
  late final double price;
  final int index;

  CartSingleProduct({
    required this.index,
    required this.image,
    required this.name,
    required this.price,
    required this.quentity,
    required this.isCount,
  });

  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutData(
      name: widget.name,
      image: widget.image,
      price: widget.price,
      quentity: widget.quentity,
    );
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  width: widget.isCount == true ? 244 : 270,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.name),
                              IconButton(
                                  onPressed: () {
                                    widget.isCount == false
                                        ? productProvider
                                            .deleteCartProduct(widget.index)
                                        : productProvider.deleteCheckoutProduct(
                                            widget.index);
                                  },
                                  icon: Icon(Icons.close)),
                            ],
                          ),
                        ),
                        Text("Iphone"),
                        Text(
                          "\$ ${widget.price.toString()}",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 35,
                          width: widget.isCount == false ? 120 : 80,
                          color: Color(0xfff2f2f2),
                          child: widget.isCount == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.remove),
                                      onTap: () {
                                        setState(() {
                                          if (widget.quentity > 1) {
                                            widget.quentity--;
                                            productProvider.getCheckOutData(
                                              name: widget.name,
                                              image: widget.image,
                                              price: widget.price,
                                              quentity: widget.quentity,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      widget.quentity.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    GestureDetector(
                                      child: Icon(Icons.add),
                                      onTap: () {
                                        setState(() {
                                          widget.quentity++;
                                          productProvider.getCheckOutData(
                                            name: widget.name,
                                            image: widget.image,
                                            price: widget.price,
                                            quentity: widget.quentity,
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Quentity"),
                                    Text(
                                      widget.quentity.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
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
