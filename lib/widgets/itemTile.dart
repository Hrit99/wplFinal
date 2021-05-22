import 'package:flutter/material.dart';
import 'package:wplappgui/constants.dart';
import 'package:wplappgui/models/item.dart';

class ItemTile extends StatefulWidget {
  final Item item;
  ItemTile(this.item);
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  final scaffoldHeight = screenHeight - kToolbarHeight;
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _getPercentage(40, scaffoldHeight) + 1,
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.brown[400], width: 1))),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.brown[400], width: 2)),
            height: _getPercentage(5, scaffoldHeight),
            width: screenWidth,
            child: Center(
              child: Text(widget.item.name),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                showDetails = !showDetails;
              });
            },
            child: showDetails
                ? Container(
                    height: _getPercentage(35, scaffoldHeight),
                    width: screenWidth,
                    child: Center(
                      child: Text(widget.item.details),
                    ))
                : Container(
                    height: _getPercentage(35, scaffoldHeight),
                    width: screenWidth,
                    child: Image.network(
                      widget.item.mediaUrl,
                      fit: BoxFit.fill,
                    )),
          ),
        ],
      ),
    );
  }
}
