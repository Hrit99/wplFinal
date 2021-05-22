import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/localData/lcategories.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/models/tabTiles.dart';
import 'package:wplappgui/widgets/categoryTile.dart';

class CustomSidebarDrawer extends StatelessWidget {
  final drawerClose;
  CustomSidebarDrawer({@required this.drawerClose});

  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  @override
  Widget build(BuildContext context) {
    // List<Category> categories = getLCategories();

    return Container(
      color: Theme.of(context).primaryColor,
      width: screenWidth * 0.60,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: _getPercentage(30, screenHeight),
              color: Theme.of(context).primaryColor,
              child: Stack(children: [
                Image.asset('assets/icons/bambooTile.png'),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/icons/icon.png",
                        width: _getPercentage(30, screenWidth),
                        height: _getPercentage(30, screenWidth),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("User"),
                    ],
                  ),
                ),
              ])),
          SingleChildScrollView(
            child: Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                height: _getPercentage(50, screenHeight),
                child: Column(
                  children: tabtiles.map((e) => CategoryTile(e)).toList(),
                )),
          ),
          FloatingActionButton(onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("wplUsername");
            Navigator.of(context).popAndPushNamed("/loginpage");
          })
          // SingleChildScrollView(
          //   child: Container(
          //     child: ListView.separated(
          //         itemBuilder: (context, index) {
          //           if (categories.length != 0) {
          //             return CategoryTile(categories[index]);
          //           } else {
          //             return Container();
          //           }
          //         },
          //         separatorBuilder: (context, index) {
          //           return Container(
          //               height: _getPercentage(0.2, screenHeight),
          //               color: Colors.green);
          //         },
          //         itemCount: categories.length),
          //   ),
          // )
        ],
      ),
    );
  }
}
