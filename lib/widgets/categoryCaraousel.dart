import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/localData/lcategories.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/models/subcategories.dart';
import 'package:wplappgui/providers/carouselVisibilityState.dart';
import 'package:wplappgui/providers/categoryChangeProvider.dart';
import 'package:wplappgui/providers/subcategoryChangeProvider.dart';
import 'package:wplappgui/controllers/categoryCarouselController.dart';

class CategoryCarousel extends StatefulWidget {
  List<Category> categories;
  CategoryCarousel(this.categories);
  @override
  _CategoryCarouselState createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  List<Category> categories;

  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  final scaffoldHeight = screenHeight - kToolbarHeight;
  bool broad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = widget.categories;
  }

  bool broadchanged = false;
  bool hide = false;
  @override
  Widget build(BuildContext context) {
    var carouselVisibility =
        Provider.of<CarouselVisibilityState>(context, listen: false);
    var categoryTabProvider =
        Provider.of<CategoryChangeProvider>(context, listen: false);
    var subcategoryTabProvider =
        Provider.of<SubcategoryChangeProvider>(context, listen: false);
    return Positioned(
      top: _getPercentage(5, scaffoldHeight),
      left: 0,
      child: Container(
        width: screenWidth,
        child: Stack(children: [
          AnimatedOpacity(
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            opacity: hide ? 0.0 : 1.0,
            child: Stack(children: [
              Container(
                child: CarouselSlider(
                  carouselController: categoryCarouselController,
                  options: CarouselOptions(
                    height: broad
                        ? _getPercentage(20, scaffoldHeight)
                        : _getPercentage(10, scaffoldHeight),
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.5,
                    initialPage: getLCategories().indexWhere((element) =>
                        element.category ==
                        categoryTabProvider.getCategory.category),
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onScrolled: (_) async {
                      print("p");
                      carouselVisibility.setSignal();
                      await Future.delayed(Duration(seconds: 10));
                      var difference = carouselVisibility.getSignal
                          .difference(DateTime.now());
                      print(difference.inSeconds.abs());
                      if (difference.inSeconds.abs() >= 10) {
                        if (categoryTabProvider.getCategory.category != "plans")
                          setState(() {
                            hide = true;
                          });
                      }
                    },
                    // enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: categories.map((v) {
                    return GestureDetector(
                        // onTapCancel: () async {
                        //   print("c");
                        //   carouselVisibility.setSignal();
                        //   await Future.delayed(Duration(seconds: 10));
                        //   var difference = carouselVisibility.getSignal
                        //       .difference(DateTime.now());
                        //   print(difference.inSeconds.abs());
                        //   if (difference.inSeconds.abs() >= 10) {
                        //     setState(() {
                        //       hide = true;
                        //     });
                        //   }
                        // },
                        // onTapUp: (_) async {
                        //   print("u");
                        //   carouselVisibility.setSignal();
                        //   await Future.delayed(Duration(seconds: 10));
                        //   var difference = carouselVisibility.getSignal
                        //       .difference(DateTime.now());
                        //   print(difference.inSeconds.abs());
                        //   if (difference.inSeconds.abs() >= 10) {
                        //     setState(() {
                        //       hide = true;
                        //     });
                        //   }
                        // },
                        // onPanEnd: (_) async {
                        //   print("p");
                        //   carouselVisibility.setSignal();
                        //   await Future.delayed(Duration(seconds: 10));
                        //   var difference = carouselVisibility.getSignal
                        //       .difference(DateTime.now());
                        //   print(difference.inSeconds.abs());
                        //   if (difference.inSeconds.abs() >= 10) {
                        //     setState(() {
                        //       hide = true;
                        //     });
                        //   }
                        // },
                        onTap: () async {
                          if (categoryTabProvider.getCategory.category !=
                              v.category) {
                            categoryTabProvider.setCategory(v, true);
                            if (categoryTabProvider.getCategory.category ==
                                "plans") {
                              categoryCarouselController.animateToPage(
                                  categories.indexWhere((element) {
                                return (element.category == v.category);
                              }),
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInOut);
                              subcategoryTabProvider.setSubcategory(
                                  v.subcategories[0], false);
                              setState(() {
                                broadchanged = true;
                                broad = true;
                              });
                            } else {
                              categoryCarouselController.animateToPage(
                                  categories.indexWhere((element) {
                                return (element.category == v.category);
                              }),
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInOut);
                              subcategoryTabProvider.setSubcategory(
                                  v.subcategories[0], false);
                              setState(() {
                                broad = false;
                              });
                            }
                          }
                        },
                        child: AnimatedContainer(
                            duration: Duration(seconds: broadchanged ? 2 : 0),
                            onEnd: () {},
                            curve: Curves.easeOut,
                            width: _getPercentage(50, screenWidth),
                            decoration: BoxDecoration(
                              color:
                                  (categoryTabProvider.getCategory.category ==
                                          v.category)
                                      ? Colors.green[100].withOpacity(0.5)
                                      : broad
                                          ? Colors.brown[400]
                                          : Colors.brown[400].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(v.category),
                            )));
                  }).toList(),
                ),
              ),
              // Positioned(
              //     top: _getPercentage(1, scaffoldHeight),
              //     right: _getPercentage(2, screenWidth),
              //     child: FloatingActionButton(
              //       onPressed: () {},
              //       mini: true,
              //       child: Icon(Icons.add),
              //     ))
            ]),
          ),
          hide
              ? Positioned(
                  left: _getPercentage(25, screenWidth),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        hide = false;
                      });
                    },
                    child: Container(
                      width: _getPercentage(50, screenWidth),
                      height: broad
                          ? _getPercentage(20, scaffoldHeight)
                          : _getPercentage(10, scaffoldHeight),
                      decoration: BoxDecoration(
                        color: Colors.green[100].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child:
                              Text(categoryTabProvider.getCategory.category)),
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }
}
