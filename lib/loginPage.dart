import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wplappgui/apis/checkUserValid.dart';
import 'package:wplappgui/apis/loadCategories.dart';
import 'package:wplappgui/apis/loadSamplePhotos.dart';
import 'package:wplappgui/constants.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:wplappgui/localData/lSampleItems.dart';
import 'package:wplappgui/localData/lcategories.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool loading = false;
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: _getPercentage(15, MediaQuery.of(context).size.height),
            left: _getPercentage(40, MediaQuery.of(context).size.width),
            child: Container(
              width: _getPercentage(20, MediaQuery.of(context).size.width),
              height: _getPercentage(20, MediaQuery.of(context).size.width),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Center(child: Image.asset("assets/icons/icon.png")),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _keyboardState
                ? _getPercentage(15, MediaQuery.of(context).size.height)
                : _getPercentage(40, MediaQuery.of(context).size.height),
            left: _getPercentage(5, MediaQuery.of(context).size.width),
            child: Container(
              width: _getPercentage(90, MediaQuery.of(context).size.width),
              height: _getPercentage(40, MediaQuery.of(context).size.height),
              color: Colors.white,
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: _getPercentage(
                                80, MediaQuery.of(context).size.width),
                            height: _getPercentage(
                                18, MediaQuery.of(context).size.width),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Colors.green[100], width: 2),
                            ),
                            child: Center(
                              child: Container(
                                width: _getPercentage(
                                    65, MediaQuery.of(context).size.width),
                                height: _getPercentage(
                                    15, MediaQuery.of(context).size.width),
                                child: TextField(
                                  controller: username,
                                  cursorColor: Colors.brown[400],
                                  cursorHeight: _getPercentage(
                                      10, MediaQuery.of(context).size.width),
                                  expands: false,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      disabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: _getPercentage(
                                80, MediaQuery.of(context).size.width),
                            height: _getPercentage(
                                18, MediaQuery.of(context).size.width),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Colors.green[100], width: 2),
                            ),
                            child: Center(
                              child: Container(
                                width: _getPercentage(
                                    65, MediaQuery.of(context).size.width),
                                height: _getPercentage(
                                    15, MediaQuery.of(context).size.width),
                                child: TextField(
                                  controller: password,
                                  cursorColor: Colors.brown[400],
                                  cursorHeight: _getPercentage(
                                      10, MediaQuery.of(context).size.width),
                                  expands: false,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      disabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            if (username.value.text == " " ||
                                password.value.text == " " ||
                                username.value.text == null ||
                                password.value.text == null) {
                              setState(() {
                                username.clear();
                                password.clear();
                              });
                            } else {
                              checkUserValid(
                                      username.value.text, password.value.text)
                                  .then((value) async {
                                if (value) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'wplUsername', username.value.text);
                                  print("found");
                                  loadCategories().then((lc) {
                                    saveLCategoryList(lc);
                                    print(getLCategories()[0].category);
                                    Navigator.of(context)
                                        .popAndPushNamed("/homepage");
                                  }).catchError((_) {
                                    Navigator.of(context)
                                        .popAndPushNamed("/loginpage");
                                  });
                                  // loadSamplePhotos("location", "jhansi")
                                  //     .then((lsi) {
                                  //   saveLSampleItemList(lsi);
                                  //   loadCategories().then((lc) {
                                  //     saveLCategoryList(lc);
                                  //     Navigator.of(context)
                                  //         .popAndPushNamed("/homepage");
                                  //   }).catchError((_) {
                                  //     Navigator.of(context)
                                  //         .popAndPushNamed("/homepage");
                                  //   });
                                  // }).catchError((_) {
                                  //   Navigator.of(context)
                                  //       .popAndPushNamed("/homepage");
                                  // });
                                  // Navigator.of(context)
                                  //     .popAndPushNamed("/homepage");
                                } else {
                                  print("not found");
                                  setState(() {
                                    username.clear();
                                    password.clear();
                                    loading = false;
                                  });
                                }
                              });
                              setState(() {
                                loading = true;
                              });
                            }
                          },
                          child: Text("login"),
                          backgroundColor: Colors.brown[400],
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed("/signuppage");
                            },
                            child: Text("Sign up",
                                style: TextStyle(color: Colors.green[400]))),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
