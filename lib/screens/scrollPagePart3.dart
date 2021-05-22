import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/localData/lSampleItems.dart';
import 'package:wplappgui/localData/lcategories.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/models/item.dart';
import 'package:wplappgui/models/subcategories.dart';
import 'package:wplappgui/providers/carouselVisibilityState.dart';
import 'package:wplappgui/providers/categoryChangeProvider.dart';
import 'package:wplappgui/providers/subcategoryChangeProvider.dart';
import 'package:wplappgui/widgets/categoryCaraousel.dart';
import 'package:wplappgui/widgets/coupleImageContainer.dart';
import 'package:wplappgui/widgets/itemContainerPart.dart';
import 'package:wplappgui/widgets/subcategoryTabContainer.dart';

class ScrollPagePart3 extends StatefulWidget {
  @override
  _ScrollPagePart3State createState() => _ScrollPagePart3State();
}

class _ScrollPagePart3State extends State<ScrollPagePart3> {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  List<Category> category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = List.from(getLCategories());
    var categoryTabProvider =
        Provider.of<CategoryChangeProvider>(context, listen: false);
    categoryTabProvider.setCategory(
        category[category
            .indexWhere((element) => element.category == "plans")
            .toInt()],
        false);
    var subCategoryProvider =
        Provider.of<SubcategoryChangeProvider>(context, listen: false);
    subCategoryProvider.setSubcategory(
        category[category
                .indexWhere((element) => element.category == "plans")
                .toInt()]
            .subcategories[0],
        false);
  }

  final scaffoldHeight = screenHeight - kToolbarHeight;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarouselVisibilityState(),
      child: Container(
        height: scaffoldHeight,
        width: screenWidth,
        child: Stack(children: [
          ItemContainerPart(),

          // Positioned(
          //     top: 0,
          //     left: _getPercentage(30, screenWidth),
          //     child: Container(
          //       height: _getPercentage(5, scaffoldHeight),
          //       width: _getPercentage(40, screenWidth),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(20), color: Colors.green),
          //     )),

          CategoryCarousel(category),

          Positioned(
            bottom: 0,
            left: -_getPercentage(15, screenWidth),
            child: CoupleImageContainer(),
          ),
          Positioned(
            bottom: _getPercentage(5, scaffoldHeight),
            left: 0,
            // child: Container(
            //   height: 10,
            //   width: screenWidth,
            //   color: Colors.black,
            // ),
            child: SubcategoryTabContainer(),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: -_getPercentage(5, screenWidth),
          //   child: Container(
          //     height: _getPercentage(30, scaffoldHeight),
          //     width: screenWidth + _getPercentage(5, screenWidth),
          //     // color: Colors.white,
          //     child: Image.asset(
          //       'assets/icons/coupleOntree.png',
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
