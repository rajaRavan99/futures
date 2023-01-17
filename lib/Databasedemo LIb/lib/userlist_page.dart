import 'package:database_demo/db_helper.dart';
import 'package:flutter/material.dart';

import 'forupdate_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Map<String, dynamic>> arrUsers = [];

  @override
  void initState() {
    getUserListFromDB();
    super.initState();
  }

  void getUserListFromDB() async {
    arrUsers = await DBHelper.getData();
    print(arrUsers.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: arrUsers.length,
                itemBuilder: (context, index) {
                  // ignore: non_constant_identifier_names
                  Map<String, dynamic> User = arrUsers[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ForUpdatePage(user: User),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            User["username"],
                          ),
                          subtitle: Text(
                            User["email"],
                          ),
                          trailing: Text(
                            User["age"].toString(),
                          ),
                          leading: ClipOval(
                            child: IconButton(
                              onPressed: () {
                                DBHelper.delete(User["email"].toString());
                              },
                              icon: const Icon(
                                size: 25,
                                Icons.delete,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
