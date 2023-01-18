// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: prefer_typing_uninitialized_variables, recursive_getters, camel_case_types

import 'package:aug_new_demo/controller/product.dart';
import 'package:aug_new_demo/controller/product_controller.dart';
import 'package:get/get.dart';

class CartModel {
//singletone class
  static final cartmodel = CartModel._internal();
  CartModel._internal();
  factory CartModel() => cartmodel;
//singletone class end

  late ProductController _catalog;

  //getter
  ProductController get catalog => _catalog;

  // item id collection :-
  final List<int> itemIds = [];

  set catalog(ProductController newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

// original method for get total price
// num get totalprice =>
//     product.fold(0, (total, current) => total + current.price);

  void add(Product item) {
    _itemIds.add(item.id);
  }

  void remove(Product item) {
    _itemIds.remove(item.id);
  }

  List<Product> get items =>
      _itemIds.map((id) => _catalog.getbyId(id)).tolist();
}

List<Product> get items => _itemIds.map((id) => _catalog.getbyId(id)).tolist();

// num get totalprice => items.fold(0, (total, current) => total + current.price);

class _catalog {
  static getbyId(id) =>
      items.firstWhere((element) => element.id = id, orElse: null);

  // static Product getbyId(int id) =>
  //     product.firstWhere((element) => element.id = id, orElse: null);
}

//add item

var _Product = {}.obs;

// void addprouct(Product product) {
//   if (_Product.containsKey(product)) {
//     _Product[product] += 1;
//   } else {
//     _Product[_Product] = 1;
//   }
//   // _itemIds.add(item.id);
// }

//remove item

class _itemIds {
  static map(Function(dynamic id) param0) {}

  static void add(int? id) {
    var item;
    _itemIds.add(item.id);
  }

  static void remove(int? id) {}
}
