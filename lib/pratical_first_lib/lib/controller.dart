import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pratical_tushar/model_class.dart';
import 'package:pratical_tushar/services.dart';

class dataController extends GetxController with StateMixin<dynamic> {
  var isLoading = true.obs;
  var productList = <Datum>[].obs;
  static var listofdata = <Datum>[];

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await services.fetchProducts();

      if (products != null) {
        services.listofdata = products.data;
        productList.value = services.listofdata;
      }
      var seen = Set<String>();
    } finally {
      isLoading(false);
    }
  }

//Update Data :-
  Future<void> updateAlbum(String title) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

// parsing JSOn or throwing an exception
    if (response.statusCode == 200) {
      // return res.fromJson(json.decode(response.body));
      print(response.body);
    } else {
      throw Exception('Failed to update album.');
    }
  }

  void updateList(List<Datum> list) {
    // productList.value = list;
    print("newproductlistis ${productList.value[0].email}");
    print("newproductlistis ${productList.value[0].firstName}");
  }
}
