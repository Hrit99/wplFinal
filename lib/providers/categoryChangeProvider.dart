import 'package:flutter/material.dart';
import 'package:wplappgui/models/category.dart';

class CategoryChangeProvider with ChangeNotifier {
  Category _category;

  void setCategory(Category c, bool notify) {
    _category = c;
    if (notify) notifyListeners();
  }

  Category get getCategory {
    return _category;
  }
}
