import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String location = prefs.getString('wplLocation');
  return location;
}
