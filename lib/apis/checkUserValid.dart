import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

Future<bool> checkUserValid(String username, String password) async {
  bool validity;
  var url =
      Uri.parse('https://safe-springs-56633.herokuapp.com/api/user/validate');
  await http
      .post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"username": username, "password": password}))
      .then((response) {
    var resp = jsonDecode(response.body);
    validity = resp["validity"];
  });
  if (validity == null) validity = false;
  return Future.value(validity);
}
