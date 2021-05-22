import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wplappgui/controllers/subcategoryTabController.dart';
import 'package:wplappgui/models/category.dart';
import 'package:wplappgui/models/subcategories.dart';

class SubcategoryChangeProvider with ChangeNotifier {
  Subcategory _subcategory;

  void setSubcategory(Subcategory c, bool notify) {
    _subcategory = c;
    print(c.subcategory);
    if (notify) {
      notifyListeners();
      print("here");
    }
  }

  Subcategory get getSubcategory {
    return _subcategory;
  }
}
