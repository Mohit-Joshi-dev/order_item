import 'dart:convert';

import 'package:order_me/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBService {
  /// Saves list of items in the DB
  Future<void> save({required List<ItemModel> items}) async {
    final pref = await SharedPreferences.getInstance();
    final encodedList = items.map((e) => jsonEncode(e.toJson())).toList();
    pref.setStringList('homeData', encodedList);
  }

  /// Gets list of items from the DB
  Future<List<ItemModel>> getItems() async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList('homeData');
    if (list != null) {
      final decodedList = list.map((item) {
        final json = jsonDecode(item);
        return ItemModel.fromJson(json);
      }).toList();
      return decodedList;
    }
    return [];
  }

  /// Adds item to cart in the DB
  Future<void> addItemToCart({required ItemModel item}) async {
    final pref = await SharedPreferences.getInstance();
    final items = await getCartItems();
    items.add(item);
    final encodedList = items.map((e) => jsonEncode(e.toJson())).toList();
    pref.setStringList('cartData', encodedList);
  }

  /// Removes item from the cart
  Future<void> removeItemToCart({required ItemModel item}) async {
    final pref = await SharedPreferences.getInstance();
    final cartItems = await getCartItems();
    final items = cartItems.where((e) => e.idMeal != item.idMeal);
    final encodedList = items.map((e) => jsonEncode(e.toJson())).toList();
    pref.setStringList('cartData', encodedList);
  }

  /// Gets all the items in the Cart
  Future<List<ItemModel>> getCartItems() async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList('cartData');
    if (list != null) {
      final decodedList = list.map((item) {
        final json = jsonDecode(item);
        return ItemModel.fromJson(json);
      }).toList();
      return decodedList;
    }
    return [];
  }

  /// Delete all items from the cart
  Future<void> emptyCart() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('cartData');
  }
}
