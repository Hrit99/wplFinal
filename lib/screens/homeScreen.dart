import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/controllers/homeScreenController.dart';
import 'package:wplappgui/localData/lSampleItems.dart';
import 'package:wplappgui/providers/tabChangeProvider.dart';
import 'package:wplappgui/screens/scrollPagePart1.dart';
import 'package:wplappgui/screens/scrollPagePart2.dart';
import 'package:wplappgui/screens/scrollPagePart3.dart';

class HomeScreen extends StatelessWidget {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  @override
  Widget build(BuildContext context) {
    var tabProvider = Provider.of<TabChangeProvider>(context, listen: false);
    tabProvider.setSelectedTab("About us", false);
    return CarouselSlider(
      carouselController: homeScreenCarouselController,
      items: [
        // SizedBox(
        //   height: _getPercentage(1, screenHeight),
        // ),
        // Container(
        //   color: Colors.black,
        //   height: _getPercentage(30, screenHeight),
        //   child: Carousel(
        //     images:
        //         getLSampleItems().map((v) => NetworkImage(v.mediaUrl)).toList(),
        //     dotSize: 4.0,
        //     dotSpacing: 15.0,
        //     dotColor: Colors.white,
        //     showIndicator: true,
        //     dotBgColor: Colors.transparent,
        //     overlayShadow: true,
        //     overlayShadowSize: 0.5,
        //     overlayShadowColors: Colors.green[50],
        //     boxFit: BoxFit.contain,
        //   ),
        // ),
        ScrollPagePart1(),
        ScrollPagePart2(),
        ScrollPagePart3(),
        Scaffold(
          body: Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.blue,
          ),
        )
      ],
      options: CarouselOptions(
        height: screenHeight - kToolbarHeight,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

//  CarouselSlider(
//             carouselController: buttonCarouselController,
//             items: getLSampleItems()
//                 .map((v) => Image.network(v.mediaUrl))
//                 .toList(),
// options: CarouselOptions(
//   height: 100,
//   aspectRatio: 16 / 9,
//   viewportFraction: 0.8,
//   initialPage: 0,
//   enableInfiniteScroll: false,
//   reverse: false,
//   autoPlay: false,
//   autoPlayInterval: Duration(seconds: 3),
//   autoPlayAnimationDuration: Duration(milliseconds: 800),
//   autoPlayCurve: Curves.fastOutSlowIn,
//   enlargeCenterPage: true,
//   scrollDirection: Axis.vertical,
// )),
//         FloatingActionButton(
//           onPressed: () {
//             Duration d = Duration(seconds: 2);
//             Curve c = Curves.easeOut;
//             buttonCarouselController.animateToPage(2, duration: d, curve: c);
//           },
//         )
