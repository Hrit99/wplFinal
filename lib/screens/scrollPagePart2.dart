import 'package:flutter/material.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/localData/lcategories.dart';
import 'package:wplappgui/models/category.dart';

class ScrollPagePart2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _getPercentage(p, v) {
      return ((p * v) / 100);
    }

    List<Category> categories = List.from(getLCategories());
    Category location = categories
        .where((element) => element.category == "location")
        .toList()[0];

    final scaffoldHeight = screenHeight - kToolbarHeight;
    return Container(
      height: scaffoldHeight,
      width: screenWidth,
      color: Colors.green[50],
      child: Stack(
        children: [
          Positioned(
            top: _getPercentage(10, scaffoldHeight),
            left: _getPercentage(5, screenWidth),
            child: Container(
              height: _getPercentage(80, scaffoldHeight),
              width: _getPercentage(90, screenWidth),
              decoration: BoxDecoration(
                color: Colors.brown[300],
              ),
              child: SingleChildScrollView(
                child: Column(
                    children: location.subcategories.map((sc) {
                  return Column(
                    children: [
                      SizedBox(
                        height: _getPercentage(5, scaffoldHeight),
                        width: _getPercentage(80, screenWidth),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(_getPercentage(3, screenWidth),
                                    _getPercentage(3, screenWidth)),
                                blurRadius: _getPercentage(10, screenWidth),
                                color: Colors.black,
                                spreadRadius: _getPercentage(1, screenWidth)),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: _getPercentage(25, scaffoldHeight),
                        width: _getPercentage(70, screenWidth),
                        child: Center(child: Text(sc.subcategory)),
                      ),
                      SizedBox(
                        height: _getPercentage(5, scaffoldHeight),
                        width: _getPercentage(80, screenWidth),
                      )
                    ],
                  );
                }).toList()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
