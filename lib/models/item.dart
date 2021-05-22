import 'package:flutter/material.dart';

class Item {
  String itemId;
  String mediaUrl;
  String name;
  String details;

  Item(
      {@required this.itemId,
      @required this.name,
      @required this.mediaUrl,
      @required this.details});
}
