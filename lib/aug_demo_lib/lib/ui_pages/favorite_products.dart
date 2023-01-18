// import 'package:aug_new_demo/controller/product.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class CartPageNew extends StatelessWidget {
//   CartPageNew({Key? key, required this.product}) : super(key: key);

//   // var shoppingController = Get.put(Shopping_controller());
//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: const Text(
//           "Cart Page",
//         ),
//       ),
//       body: Obx(
//         () {
//           return
//               //  (shoppingController.isLoading.value == true)
//               //     ? const Center(
//               //         child: CircularProgressIndicator(),
//               //       )
//               //     :
//               ListView.builder(
//             // itemCount: shoppingController.products.length,
//             itemBuilder: (context, index) {
//               // var product = shoppingController.products[index];
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: ListTile(
//                       leading: SizedBox(
//                         height: 80,
//                         width: 50,
//                         child: Image.network(
//                           product.imageLink ?? "",
//                           fit: BoxFit.fitHeight,
//                         ),
//                       ),

//                       // trailing: IconButton(
//                       //     icon: const Icon(Icons.remove_circle_outline),
//                       //     onPressed: () {
//                       //       shoppingController
//                       //           .removeProductFromCaart(product.id ?? 0);
//                       //     }),
//                       title: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product.name ?? "",
//                             textAlign: TextAlign.left,
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             product.description ?? "",
//                             textAlign: TextAlign.left,
//                           ),
//                         ],
//                       ),
//                       subtitle: Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Text(product.price.toString()),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
