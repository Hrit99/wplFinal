import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

Future<bool> reloadCheck(String username) async {
  bool reload;
  var url = Uri.parse(
      'https://safe-springs-56633.herokuapp.com/api/userid/reloadCheck');
  await http
      .post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{"userId": username}))
      .then((response) {
    var resp = jsonDecode(response.body);
    reload = resp["reload"];
  });
  if (reload == null) reload = false;
  return Future.value(reload);
}
