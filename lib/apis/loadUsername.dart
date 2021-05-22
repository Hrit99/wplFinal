import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

Future<String> loadUsername() async {
  await Future.delayed(Duration(seconds: 5));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String usrname = prefs.getString('wplUsername');
  if (usrname == null)
    return Future.value(" ");
  else
    return Future.value(usrname);
}
