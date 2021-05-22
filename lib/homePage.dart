import 'package:flutter/material.dart';
import 'package:wplappgui/constants.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:wplappgui/screens/homeScreen.dart';
import 'package:wplappgui/widgets/customSidebarDrawer.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  FSBStatus _fsbStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fsbStatus = FSBStatus.FSB_CLOSE;
  }

  @override
  Widget build(BuildContext context) {
    print(_fsbStatus);
    setScreenHeight = MediaQuery.of(context).size.height;
    setScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Container(
            padding: EdgeInsets.symmetric(
                horizontal: _getPercentage(1, screenWidth),
                vertical: _getPercentage(0.5, screenHeight)),
            width: screenWidth,
            height: kToolbarHeight,
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: _getPercentage(0.5, screenHeight),
                        horizontal: _getPercentage(1, screenWidth)),
                    width: _getPercentage(15, screenWidth),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print("s$_fsbStatus");
                            _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN
                                ? FSBStatus.FSB_CLOSE
                                : FSBStatus.FSB_OPEN;
                            print("e$_fsbStatus");
                          });
                        },
                        child: Image.asset("assets/icons/icon.png")),
                  ),
                  Container(
                    width: _getPercentage(83, screenWidth),
                    padding:
                        EdgeInsets.only(right: _getPercentage(15, screenWidth)),
                    child: Center(child: Text("PARINAY")),
                  )
                ],
              ),
            )),
      ),
      body: FoldableSidebarBuilder(
        drawerBackgroundColor: Colors.brown[400],
        drawer: CustomSidebarDrawer(
          drawerClose: () {
            setState(() {
              _fsbStatus = FSBStatus.FSB_CLOSE;
            });
          },
        ),
        screenContents: welcomeScreen(),
        status: _fsbStatus,
      ),
    );
  }

  Widget welcomeScreen() {
    return Container(
      color: Colors.green[50],
      child: Center(
        child: HomeScreen(),
      ),
    );
  }
}
