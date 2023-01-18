import 'package:aug_new_demo/Provider/cartmodel.dart';
import 'package:aug_new_demo/controller/product.dart';
import 'package:aug_new_demo/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable

// ignore: camel_case_types
class cart_page extends StatelessWidget {
  const cart_page({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Cart").text.xl4.bold.center.make(),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Column(
        children: [
          cartlist().p32().expand(),
          const Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  // final _cart = Product();
  final cart = CartModel();
  _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          "\$${999}".text.xl5.color(Colors.black38).make(),
          // "\$${cart.totalprice}".text.xl5.color(Colors.black38).make(),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              Get.bottomSheet(
                exitBottomSheetDuration: const Duration(seconds: 1),
                SizedBox(
                  height: context.height,
                  child: Column(
                    children: [
                      IconButton(
                        alignment: Alignment.topLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            // Get.to(LoginPage());
                          },
                          child: const Text('Buying Not Supported Now',
                              textScaleFactor: 1)),
                    ],
                  ),
                ),
                barrierColor: Colors.red[50],
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                enableDrag: false,
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            child: "Buy".text.white.make(),
          ).w24(context)
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class cartlist extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  cartlist({Key? key}) : super(key: key);

  @override
  State<cartlist> createState() => _cartlistState();
}

// ignore: camel_case_types
class _cartlistState extends State<cartlist> {
  // CartPage({Key? key, required Product product}) : super(key: key);
  // var cartcontroller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final cart = CartModel();

    // List<Map<String, dynamic>> product = [];

    return ListView.builder(
        // itemCount: _cart.items?.length,
        itemCount: cart.items.length,
        // itemCount: 5,
        // itemCount: cart.productList.length,
        itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.done),
              trailing: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // cart.removeProductFromCaart(index);
                },
              ),
              title: cart.items[index].name?.text.make(),
              // title: const Text("Item"),
            )

        // {
        //   var product = cartcontroller.productList[index];
        //   return Container();
        // },
        );
  }
}
