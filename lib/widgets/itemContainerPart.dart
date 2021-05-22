import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/controllers/subcategoryTabController.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/models/subcategories.dart';
import 'package:wplappgui/providers/categoryChangeProvider.dart';
import 'package:wplappgui/providers/subcategoryChangeProvider.dart';
import 'package:wplappgui/widgets/itemTile.dart';

class ItemContainerPart extends StatefulWidget {
  @override
  _ItemContainerPartState createState() => _ItemContainerPartState();
}

class _ItemContainerPartState extends State<ItemContainerPart> {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  final scaffoldHeight = screenHeight - kToolbarHeight;
  @override
  Widget build(BuildContext context) {
    var categoryTabProvider = Provider.of<CategoryChangeProvider>(context);
    var subcategorTabProvider =
        Provider.of<SubcategoryChangeProvider>(context, listen: false);
    Category category = categoryTabProvider.getCategory;
    // Subcategory subcategory = subcategorTabProvider.getSubcategory;
    return CarouselSlider.builder(
      // carouselController: subcategoryCarouselController,
      options: CarouselOptions(
        height: _getPercentage(100, scaffoldHeight),
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: category.subcategories.indexWhere((element) =>
            element.subcategory ==
            subcategorTabProvider.getSubcategory.subcategory),
        enableInfiniteScroll: false,
        reverse: true,
        autoPlay: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          print("sa");
          subcategorTabProvider.setSubcategory(
              category.subcategories[index], true);
          print("ds");
          subcategoryCarouselController.animateToPage(
              category.subcategories.indexWhere((element) =>
                  element.subcategory ==
                  subcategorTabProvider.getSubcategory.subcategory),
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut);
        },
        // enlargeStrategy: CenterPageEnlargeStrategy.scale,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: category.subcategories.length,
      itemBuilder: (ctx, i, realIndex) {
        return Container(
            height: _getPercentage(100, scaffoldHeight),
            width: screenWidth,
            color: Theme.of(context).primaryColor,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ItemTile(category.subcategories[i].items[index]);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: _getPercentage(1, scaffoldHeight),
                    width: screenWidth,
                    color: Colors.white,
                  );
                },
                itemCount: category.subcategories[i].items.length));
      },
    );
  }
}
