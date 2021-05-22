import 'package:flutter/material.dart';
import 'package:wplappgui/models/item.dart';

class Subcategory {
  String subcategoryId;
  String subcategory;
  List<Item> items;

  Subcategory(
      {@required this.items,
      @required this.subcategory,
      @required this.subcategoryId});
}
