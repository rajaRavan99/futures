// import 'package:flutter/material.dart';

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({Key? key}) : super(key: key);

//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }

// class _MyDrawerState extends State<MyDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Drawer(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 180,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 40.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.transparent,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Expanded(
//                           child: Image.network(
//                             'https://cdn.dribbble.com/users/230053/screenshots/2449663/expense_app_icon_1x.jpg',
//                             fit: BoxFit.cover,
//                             height: MediaQuery.of(context).size.height / 2,
//                             width: MediaQuery.of(context).size.width / 2,
//                           ),
//                         ),
//                         // Icon(Icons.account_circle, color: AppColors.black, size: 60),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const AddTransaction(),
//                   ),
//                 );
//               },
//               leading: const Icon(
//                 Icons.bar_chart,
//                 color: AppColors.primaryColor,
//               ),
//               title: Text('Add Transaction',
//                   style: FontStyle.textHeader.copyWith(fontSize: 15)),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const TransactionList(),
//                   ),
//                 );
//               },
//               leading: const Icon(
//                 Icons.list,
//                 color: AppColors.primaryColor,
//               ),
//               title: Text(
//                 'Transaction List',
//                 style: FontStyle.textHeader.copyWith(fontSize: 15),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const MonthlyIncome(),
//                   ),
//                 );
//               },
//               leading: const Icon(
//                 Icons.monetization_on,
//                 color: AppColors.primaryColor,
//               ),
//               title: Text(
//                 'Monthly Income',
//                 style: FontStyle.textHeader.copyWith(fontSize: 15),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const MonthlyExpense(),
//                   ),
//                 );
//               },
//               leading: const Icon(
//                 Icons.outbond,
//                 color: AppColors.primaryColor,
//               ),
//               title: Text(
//                 'Monthly Expense',
//                 style: FontStyle.textHeader.copyWith(fontSize: 15),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const CategoryPage(),
//                   ),
//                 );
//               },
//               leading: const Icon(
//                 Icons.category_outlined,
//                 color: AppColors.primaryColor,
//               ),
//               title: Text(
//                 'Category Page',
//                 style: FontStyle.textHeader.copyWith(fontSize: 15),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const Contactpage(),
//                   ),
//                 );
//               },
//               leading: const Icon(
//                 Icons.contact_page_outlined,
//                 color: AppColors.primaryColor,
//               ),
//               title: Text(
//                 'Contact Page',
//                 style: FontStyle.textHeader.copyWith(fontSize: 15),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (context) => LoginPage(),
//                   ),
//                 );
//               },
//               leading: const Icon(
//                 Icons.logout,
//                 color: AppColors.primaryColor,
//               ),
//               title: Text(
//                 'LogOut',
//                 style: FontStyle.textHeader.copyWith(fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
