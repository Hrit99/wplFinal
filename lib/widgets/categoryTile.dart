import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/providers/tabChangeProvider.dart';

class CategoryTile extends StatefulWidget {
  String name;
  CategoryTile(this.name);

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool isselectedCategory;
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var tabProvider = Provider.of<TabChangeProvider>(context, listen: false);
    // isselectedCategory = (widget.name == "About us") ? true : false;
    // if (isselectedCategory) {
    //   tabProvider.setSelectedTab = "About us";
    // }
  }

  @override
  Widget build(BuildContext context) {
    var tabProvider = Provider.of<TabChangeProvider>(context, listen: false);
    isselectedCategory = (widget.name == tabProvider.getSelectedTab);
    Color tabColor = Colors.green[100];
    if (isselectedCategory) {
      tabProvider = Provider.of<TabChangeProvider>(context);
    }
    // if (isselectedCategory) {
    //   tabProvider = Provider.of<TabChangeProvider>(context);
    // }
    return Column(
      children: [
        SizedBox(
          height: _getPercentage(0.2, screenHeight),
        ),
        Container(
          height: _getPercentage(7, screenHeight),
          // child: Row(
          //   children: [
          //     Container(
          //       width: _getPercentage(10, screenWidth),
          //       color: Colors.red,
          //       child: FittedBox(
          //           fit: BoxFit.contain,
          //           child: Image.asset('assets/icons/woodtrunk.png')),
          //     ),
          //     Container(
          //       width: _getPercentage(50, screenWidth),
          //       color: Colors.blue,
          //     )
          //   ],
          // ),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: tabColor,
                  ),
                  width: _getPercentage(10, screenWidth),
                  height: _getPercentage(8, screenHeight),
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset('assets/icons/sideTreeTrunkTile.png')),
                ),
                GestureDetector(
                  onTap: () {
                    if (!isselectedCategory) {
                      setState(() {
                        tabProvider.setSelectedTab(widget.name, true);
                        isselectedCategory = true;
                      });
                    }
                  },
                  child: Container(
                    width: _getPercentage(50, screenWidth),
                    padding: EdgeInsets.only(
                      right: _getPercentage(10, screenWidth),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(0), right: Radius.circular(20)),
                      color: tabColor,
                    ),
                    child: Row(
                      children: [
                        isselectedCategory
                            ? FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assets/icons/sideTreeTrunkTile.png'))
                            : Container(),
                        Center(
                          child: Text(widget.name),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: _getPercentage(0.2, screenHeight),
        ),
      ],
    );
  }
}
