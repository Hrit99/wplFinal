import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/localData/lSampleItems.dart';
import 'package:wplappgui/localData/lcategories.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/models/subcategories.dart';

class ScrollPagePart1 extends StatelessWidget {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  final scaffoldHeight = screenHeight - kToolbarHeight;
  @override
  Widget build(BuildContext context) {
    List<Category> categories = List.from(getLCategories());
    Subcategory moments = categories
        .where((element) => element.category == "moments")
        .toList()[0]
        .subcategories
        .where((element) => element.subcategory == "moments")
        .toList()[0];
    return Container(
        height: scaffoldHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border(
                //     bottom: BorderSide(
                //         color: Colors.green,
                //         width: _getPercentage(5, scaffoldHeight),
                //         style: BorderStyle.solid)),
              ),
              height: _getPercentage(30, scaffoldHeight),
              width: screenWidth,
              child: CarouselSlider(
                  items: moments.items
                      .map((v) => Image.network(v.mediaUrl))
                      .toList(),
                  options: CarouselOptions(
                    height: _getPercentage(30, scaffoldHeight),
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            Positioned(
              top: _getPercentage(14, scaffoldHeight),
              left: -_getPercentage(5, screenWidth),
              child: Container(
                height: _getPercentage(90, scaffoldHeight),
                width: _getPercentage(110, screenWidth),
                // color: Colors.orange,
                child: Stack(children: [
                  Positioned(
                    top: _getPercentage(19, scaffoldHeight),
                    left: _getPercentage(28, screenWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: _getPercentage(45, scaffoldHeight),
                            width: _getPercentage(53, screenWidth),
                            color: Colors.white),
                      ],
                    ),
                  ),
                  Container(
                    height: _getPercentage(90, scaffoldHeight),
                    width: _getPercentage(110, screenWidth),
                    child: Image.asset(
                      'assets/icons/woodenFrame.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
