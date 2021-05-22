import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wplappgui/apis/loadCategories.dart';
import 'package:wplappgui/apis/loadLocation.dart';
import 'package:wplappgui/apis/loadSamplePhotos.dart';
import 'package:wplappgui/apis/loadUsername.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/homePage.dart';
import 'package:wplappgui/localData/lSampleItems.dart';
import 'package:wplappgui/localData/lcategories.dart';
import 'package:wplappgui/loginPage.dart';
import 'package:wplappgui/models/item.dart';
import 'package:wplappgui/providers/categoryChangeProvider.dart';
import 'package:wplappgui/providers/subcategoryChangeProvider.dart';
import 'package:wplappgui/providers/tabChangeProvider.dart';
import 'package:wplappgui/signupPage.dart';
import 'package:wplappgui/widgets/splashBufferRing.dart';
import 'package:wplappgui/widgets/subcategoryTabContainer.dart';

void main() {
  runApp(MyApp());
}

class SplashScreenWidget extends StatelessWidget {
  // Future<String> loadusrnameFromFuture() async {
  //   String signal;
  //   // <fetch data from server. ex. login>
  //   print("hello");
  //   await Future.delayed(Duration(seconds: 5));
  //   await loadUsername().then((usrname) async {
  //     // print("Kj$usrname");
  //     // signal.addEntries({MapEntry("username", usrname)});
  //     //   await loadLocation().then((location) async {
  //     //     print("ff$location");
  //     //     signal.addEntries({MapEntry("location", location)});
  //     //   });
  //     // }).whenComplete(() {
  //     //   print("usrnamecopm");
  //     print("aa$usrname");
  //     if (usrname == null)
  //       signal = " ";
  //     else
  //       signal = usrname;
  //   }).catchError(() {
  //     signal = " ";
  //   });
  //   print("jll$signal");
  //   // await Future.delayed(Duration(seconds: 10));
  //   return Future.value(signal);
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    loadUsername().then((value) {
      print("ddd$value");
      if (value == " ")
        Navigator.of(context).popAndPushNamed("/loginpage");
      else {
        loadCategories().then((lc) {
          saveLCategoryList(lc);
          print(getLCategories()[0].category);
          Navigator.of(context).popAndPushNamed("/homepage");
        }).catchError((_) {
          Navigator.of(context).popAndPushNamed("/loginpage");
        });
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SplashBufferRing(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryChangeProvider(),
      child: ChangeNotifierProvider(
        create: (_) => SubcategoryChangeProvider(),
        child: ChangeNotifierProvider(
          create: (_) => TabChangeProvider(),
          child: MaterialApp(
            title: 'Parinay',
            theme: ThemeData(
                primaryColor: Colors.white,
                accentColor: Colors.lightGreen[200],
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.green[300],
                  iconTheme: IconThemeData(color: Colors.brown[400], size: 1),
                )),
            routes: {
              "/homepage": (context) => HomePage(),
              "/loginpage": (context) => LoginPage(),
              "/signuppage": (context) => SignupPage(),
            },
            home: SplashScreenWidget(),
          ),
        ),
      ),
    );
  }
}
