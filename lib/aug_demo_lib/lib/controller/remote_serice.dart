import 'package:aug_new_demo/controller/product.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>> fetchProducts() async {
    var response = await client
        .get(Uri.parse('http://makeup-api.herokuapp.com/api/v1/products.json'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }
}
