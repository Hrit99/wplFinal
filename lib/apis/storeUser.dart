import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

Future<bool> storeUser(
    String username, String password, String phone, String email) async {
  bool stored;
  var url =
      Uri.parse('https://safe-springs-56633.herokuapp.com/api/user/store');
  await http
      .post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": username,
            "password": password,
            "phone": phone,
            "email": email
          }))
      .then((response) {
    var resp = jsonDecode(response.body);
    stored = resp["stored"];
  });
  if (stored == null) stored = false;
  return Future.value(stored);
}
