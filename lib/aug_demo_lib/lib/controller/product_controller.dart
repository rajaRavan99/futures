import 'package:aug_new_demo/controller/product.dart';
import 'package:get/get.dart';
import 'remote_serice.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var allProducts = <Product>[].obs;
  var Listofcolors = <ProductColor>[].obs;
  // final _itemids = <Product>[].obs;
  final List<int> itemids = [];

  var totalprice;

  set catalog(ProductController catalog) {}

  @override
  void onInit() {
    fetchProducts();

    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      // ignore: unnecessary_null_comparison
      if (products != null) {
        productList.value = products;
        allProducts.value = products;
      }
      var seen = Set<String>();

      if (productList.isNotEmpty) {
        List<Product> uniquelist =
            productList.where((p0) => seen.add(p0.brand ?? "")).toList();
// productList.where((product) => seen.add(product.brand!).toList();

        productList.value = uniquelist;
      }
    } finally {
      isLoading(false);
    }
  }

  var _Product = {}.obs;

  void addprouct(Product product) {
    if (_Product.containsKey(product)) {
      _Product[product] += 1;
    } else {
      _Product[_Product] = 1;
    }
    // _itemIds.add(item.id);
  }

  void removeProductFromCaart(int productID) {
    print(productList.value.length);
    productList.removeWhere((element) => element.id == productID);
    print(productList.value.length);
  }

  getbyId(id) {}

  // ignore: non_constant_identifier_names

  // void paginatetack() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels ==
  //         scrollController.position.maxScrollExtent) print('Reached end');
  //     page++;
  //     getmoreTask(page);
  //   });
  // }

  // showSnackbar(String s, String message, MaterialColor red) {}
  //   Get.snackbar(
  //     Title,Message,
  //   SnackPosition:SnackPosition.BOTTOM,

  //   );

  // void getmoreTask() {
  //   try{
  //       Taskprovider().getTask(page).then((Resp){
  //         if(Resp.length > 0){
  //           ismoredataavaible (true);

  //         }else{
  //             ismoredataavaible (false);
  //             showSnackbar ("Message", "No More Item Avalible ",Colors.lightBlue);

  //         }
  //         lastTask.addAll(Resp);

  //       },onEroor : (err) {
  //          ismoredataavaible (false);
  //             showSnackbar ("Eroor", err.toString(),Colors.red);

  //       }

  //       );

  //   }
  // }

}
