import 'dart:convert';
import 'dart:developer';

import 'models/models.dart';
import 'package:http/http.dart' as http;

class Repo {
  Future<List<ItemModel>> getList() async {
    Uri uri = Uri.parse(
        'http://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood');
    try {
      var response = await http.get(uri);
      var data = jsonDecode(response.body);
      List listOfMeals = data['meals'];
      List<ItemModel> listOfItems =
          listOfMeals.map((e) => ItemModel.fromJson(e)).toList();
      return listOfItems;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
