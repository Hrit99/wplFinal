import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wplappgui/apis/loadItems.dart';
import 'package:wplappgui/apis/reloadCheck.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/models/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wplappgui/models/subcategories.dart';

Future<List<Category>> loadCategories() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String usrname = prefs.getString("wplUsername");

  String resp = prefs.getString('wplCategories#$usrname');
  await reloadCheck(usrname).then((value) {
    if (value) resp = null;
  });
  if (resp == null) {
    var url =
        Uri.parse('https://safe-springs-56633.herokuapp.com/api/category');
    await http.get(url).then((response) {
      if (response.statusCode == 200) {
        resp = response.body.toString();
        prefs.setString('wplCategories#$usrname', resp);
      } else {
        resp = null;
      }
    });
  }

  var response = jsonDecode(resp);

  List<Category> categoryList = new List<Category>();

  if (resp != null) {
    for (var category in response['response']) {
      List<Subcategory> subcategories = new List<Subcategory>();

      for (var subcategory in category['subcategories']) {
        List<Item> items;
        await loadItems(category['category'], subcategory['subcategory'])
            .then((value) {
          if (value.length > 0)
            items = List.from(value);
          else
            items = new List<Item>();
        });
        // if (items.length > 0) print(items[0].name);
        subcategories.add(Subcategory(
            items: items,
            subcategory: subcategory['subcategory'],
            subcategoryId: subcategory['_id']));
      }
      categoryList.add(Category(
          categoryId: category['_id'],
          category: category['category'],
          subcategories: subcategories));
    }
  }
  return categoryList;
}
