import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pratical_tushar/controller.dart';
import 'package:pratical_tushar/profile_screen.dart';
import 'package:pratical_tushar/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String email = "";

  late SharedPreferences prefs;

  TextEditingController firstnamecontroller = TextEditingController(text: "");
  TextEditingController lastnamecontroller = TextEditingController(text: "");
  TextEditingController emailcontroller = TextEditingController(text: "");

  Future<void> pullrefresh() async {
    services.fetchProducts();
  }

  @override
  void initState() {
    // _showSavedValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => dataController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {},
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: pullrefresh,
        child: GetX<dataController>(
          builder: (controller) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.productList.length,
              itemBuilder: (BuildContext context, int i) {
                var data = controller.productList[i];

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilepage(
                          data: data,
                        ),
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5.0,
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            data.avatar ?? "",
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              data.firstName ?? "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              data.lastName ?? "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          data.email ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              controller.productList.removeAt(i);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
