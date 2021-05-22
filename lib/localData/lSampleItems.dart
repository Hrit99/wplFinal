import 'package:wplappgui/models/item.dart';

List<Item> _lSampleItems = new List<Item>();

void addLSampleItem(Item item) {
  _lSampleItems.add(item);
}

void deleteLSampleItem(Item item) {
  _lSampleItems.remove(item);
}

List<Item> getLSampleItems() {
  return _lSampleItems;
}

void saveLSampleItemList(List<Item> newlist) {
  _lSampleItems = List.from(newlist);
}
