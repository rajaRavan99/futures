// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';

// class FirebaseUserlist extends StatefulWidget {
//   const FirebaseUserlist({super.key});

//   @override
//   State<FirebaseUserlist> createState() => _UserListPageState();
// }

// class _UserListPageState extends State<FirebaseUserlist> {
//   List<Item> userName = [];

//   @override
//   void initState() {
//     FirebaseFirestore.instance
//         .collection('user_name')
//         .snapshots()
//         .listen((records) {
//       maprecords(records);
//     });
//     fetchrecords();
//     super.initState();
//   }

//   void fetchrecords() async {
//     var records =
//         await FirebaseFirestore.instance.collection('user_name').get();
//     maprecords(records);
//   }

//   maprecords(QuerySnapshot<Map<String, dynamic>> records) {
//     var _list = records.docs
//         .map(
//           (item) => Item(
//             id: item.id,
//             name: item['user'],
//             password: item['password'],
//           ),
//         )
//         .toList();

//     setState(() {
//       userName = _list;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Users"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showitemdialog();
//             },
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: userName.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       userName[index].name,
//                     ),
//                     subtitle: Text(
//                       userName[index].password ?? '',
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   showitemdialog() {
//     var userNamecontroller = TextEditingController();
//     var passwordcontroller = TextEditingController();

//     showBottomSheet(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           child: Column(
//             children: [
//               TextField(
//                 controller: userNamecontroller,
//               ),
//               TextField(
//                 controller: passwordcontroller,
//               ),
//               TextButton(
//                   onPressed: () {
//                     var name = userNamecontroller.text.trim();
//                     var password = userNamecontroller.text.trim();
//                   },
//                   child: const Text('Add Data'))
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
