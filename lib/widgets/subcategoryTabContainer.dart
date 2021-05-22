import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/controllers/subcategoryTabController.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/providers/carouselVisibilityState.dart';
import 'package:wplappgui/providers/categoryChangeProvider.dart';
import 'package:wplappgui/providers/subcategoryChangeProvider.dart';
import 'package:wplappgui/controllers/subcategoryTabController.dart';

class SubcategoryTabContainer extends StatefulWidget {
  @override
  _SubcategoryTabContainerState createState() =>
      _SubcategoryTabContainerState();
}

class _SubcategoryTabContainerState extends State<SubcategoryTabContainer> {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  final scaffoldHeight = screenHeight - kToolbarHeight;

  bool hide = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var categoryTabController =
        Provider.of<CategoryChangeProvider>(context, listen: false);
    Category c = categoryTabController.getCategory;
    var subcategoryTabProvider =
        Provider.of<SubcategoryChangeProvider>(context, listen: false);
    subcategoryTabProvider.setSubcategory(c.subcategories[0], false);
  }

  @override
  Widget build(BuildContext context) {
    var subcategoryTabProvider =
        Provider.of<SubcategoryChangeProvider>(context);
    var categoryTabController = Provider.of<CategoryChangeProvider>(context);
    Category c = categoryTabController.getCategory;
    hide = (c.category == "plans") ? true : false;
    print(c.category);
    // subcategoryCarouselController.animateToPage(
    //     c.subcategories.indexWhere((element) {
    //   return (element.subcategory ==
    //       subcategoryTabProvider.getSubcategory.subcategory);
    // }), duration: Duration(seconds: 1), curve: Curves.easeInOut);
    return Container(
      height: _getPercentage(5, scaffoldHeight),
      width: screenWidth,
      child: AnimatedOpacity(
          opacity: hide ? 0.0 : 1.0,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Stack(children: [
            Container(
              child: CarouselSlider(
                carouselController: subcategoryCarouselController,
                options: CarouselOptions(
                  height: _getPercentage(5, scaffoldHeight),
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.2,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: true,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  // enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  scrollDirection: Axis.horizontal,
                ),
                items: c.subcategories.map((v) {
                  return GestureDetector(
                      onTap: () {
                        print("j");
                        print(
                            subcategoryTabProvider.getSubcategory.subcategory);
                        print(v.subcategory);
                        if (subcategoryTabProvider.getSubcategory.subcategory !=
                            v.subcategory) {
                          subcategoryCarouselController.animateToPage(
                              c.subcategories.indexWhere((element) {
                            return (element.subcategory == v.subcategory);
                          }),
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          subcategoryTabProvider.setSubcategory(v, true);
                        }
                      },
                      child: Container(
                          width: _getPercentage(50, screenWidth),
                          decoration: BoxDecoration(
                            color: (subcategoryTabProvider
                                        .getSubcategory.subcategory ==
                                    v.subcategory)
                                ? Colors.green[100].withOpacity(0.8)
                                : Colors.brown[400].withOpacity(0.8),
                            // color: Colors.brown[400].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(v.subcategory),
                          )));
                }).toList(),
              ),
            ),
            // Positioned(
            //     top: _getPercentage(0, scaffoldHeight),
            //     right: _getPercentage(2, screenWidth),
            //     child: FloatingActionButton(
            //       onPressed: () {},
            //       mini: true,
            //       child: Icon(Icons.add),
            //     )),
          ])),
    );
  }
}
