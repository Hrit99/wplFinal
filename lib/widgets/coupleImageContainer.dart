import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/providers/categoryChangeProvider.dart';

class CoupleImageContainer extends StatelessWidget {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  final scaffoldHeight = screenHeight - kToolbarHeight;
  @override
  Widget build(BuildContext context) {
    var categoryTabController = Provider.of<CategoryChangeProvider>(context);
    Category c = categoryTabController.getCategory;
    return AnimatedOpacity(
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
      opacity: (c.category == "plans") ? 1.0 : 0.0,
      child: Container(
        height: _getPercentage(30, scaffoldHeight),
        width: screenWidth + _getPercentage(5, screenWidth),
        // color: Colors.amber,
        child: Image.asset(
          'assets/icons/coupleOntree.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
