import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wplappgui/apis/reloadCheck.dart';
import 'package:wplappgui/models/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Item>> loadItems(String category, String subcategory) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String usrname = prefs.getString("wplUsername");
  String resp =
      prefs.getString('wplItems#${usrname}#${category}#${subcategory}');
  await reloadCheck(usrname).then((value) {
    if (value) resp = null;
  });
  if (resp == null) {
    var url = Uri.parse('https://safe-springs-56633.herokuapp.com/api/item');
    await http
        .post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'category': category,
        'subcategory': subcategory,
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        resp = response.body.toString();
        prefs.setString('wplItems#${usrname}#${category}#${subcategory}', resp);
      } else {
        resp = null;
      }
    });
  }

  var response = jsonDecode(resp);

  List<Item> itemList = new List<Item>();

  if (resp != null) {
    for (var item in response['response']) {
      itemList.add(Item(
          itemId: item['_id'],
          name: item['name'],
          mediaUrl: item['mediaUrl'],
          details: item['details']));
    }
  }
  return itemList;
}
