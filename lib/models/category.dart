import 'package:flutter/material.dart';
import 'package:wplappgui/models/subcategories.dart';

class Category {
  String categoryId;
  String category;
  List<Subcategory> subcategories;

  Category(
      {@required this.categoryId,
      @required this.category,
      @required this.subcategories});
}
