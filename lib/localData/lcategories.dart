import 'package:wplappgui/models/category.dart';

List<Category> _lCategories = new List<Category>();

void addlCategory(Category category) {
  _lCategories.add(category);
}

void deleteLCategory(Category category) {
  _lCategories.remove(category);
}

List<Category> getLCategories() {
  return _lCategories;
}

void saveLCategoryList(List<Category> newlist) {
  _lCategories = List.from(newlist);
}
