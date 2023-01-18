import 'package:aug_new_demo/controller/product.dart';
import 'package:aug_new_demo/ui_pages/cartpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/product_controller.dart';
import 'brand_Product_page.dart';

// ignore: camel_case_types
class productdetailpage extends StatelessWidget {
  final Product product;
  productdetailpage({
    Key? key,
    required this.product,
    // ignore: unnecessary_null_comparison
  })  : assert(product != null),
        super(key: key);

  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    productController.Listofcolors.length;
    final List<ProductColor> Listofcolors = [];

    return Scaffold(
      bottomNavigationBar: Container(
        // color: Colors.white,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            Text(
              "\$${product.price.toString()}",
              style: const TextStyle(
                  // color: Colors.black54,
                  // fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'avenir'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => cart_page(
                //       // catalog: catalog,
                //       product: product,
                //     ),
                //   ),
                // );
                // Get.to(cart_page());
                Get.bottomSheet(
                  exitBottomSheetDuration: const Duration(seconds: 1),
                  Container(
                    height: 50,
                    child: Column(
                      children: const [
                        Text('Buying Not Supported Yet'),
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
                // backgroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(
                  const StadiumBorder(),
                ),
              ),
              child: const Text("Add To Cart"),
            ).wh(120, 50)
          ],
        ).p16(),
      ),
      appBar: AppBar(
        title: Text(
          product.brand ?? "",
          style: const TextStyle(
              // fontWeight: FontWeight.bold,
              // fontSize: 25,
              // color: Colors.black45,
              fontFamily: 'avenir'),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Get.to(brand_products_page(product: product));
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
      ),
      // backgroundColor: Colors.white70,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://media.istockphoto.com/photos/sunset-waterfall-picture-id483822568',
                      //  product.imageLink ?? "",
                      height: 300,
                      width: 300,
                      placeholder: (context, url) =>
                          Image.asset("assets/images/placeholderimage.jpg"),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Brand :-",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          // fontSize: 25,
                          // color: Colors.black45,
                          fontFamily: 'avenir'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            product.brand ?? "",
                            style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                // fontSize: 25,
                                // color: Colors.black45,
                                fontFamily: 'avenir'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        "Product Name :-",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            // fontSize: 25,
                            // color: Colors.black45,
                            fontFamily: 'avenir'),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? "",
                            style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                // fontSize: 25,
                                // color: Colors.black45,
                                fontFamily: 'avenir'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        "Description :-",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            // fontSize: 25,
                            // color: Colors.black45,
                            fontFamily: 'avenir'),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product.description ?? "",
                            style: const TextStyle(
                                // backgroundColor: Colors.white30,
                                // fontWeight: FontWeight.bold,
                                // fontSize: 20,
                                // color: Colors.black45,
                                fontFamily: 'avenir'),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        "Rating :-",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            // fontSize: 25,
                            // color: Colors.black45,
                            fontFamily: 'avenir'),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  (product.rating == null)
                                      ? ""
                                      : product.rating.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Color :- ",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            // fontSize: 25,
                            // color: Colors.black45,
                            fontFamily: 'avenir'),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // itemCount: _cart.items?.length,
                          itemCount: product.productColors?.length,
                          itemBuilder: (context, index) {
                            ProductColor color = product.productColors![index];
                            return Container(
                              decoration: BoxDecoration(
                                color: color.hexValue?.hexToColor(),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              margin: EdgeInsets.all(4),
                              width: 30,
                              height: 20,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
                // Flexible(
                //   child: SizedBox(
                //     height: 60,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       // itemCount: _cart.items?.length,
                //       itemCount: product.productColors?.length,
                //       itemBuilder: (context, index) {
                //         ProductColor color = product.productColors![index];
                //         return Container(
                //           width: 20,
                //           height: 20,
                //           color: color.hexValue?.hexToColor(),
                //         );
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension HexToColor on String {
  Color hexToColor() {
    return Color(
        int.parse(toLowerCase().substring(1, 7), radix: 16) + 0xFF000000);
  }
}
