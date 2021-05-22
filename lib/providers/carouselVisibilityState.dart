import 'package:flutter/material.dart';

class CarouselVisibilityState with ChangeNotifier {
  DateTime _signal;

  void setSignal() {
    _signal = DateTime.now();
  }

  DateTime get getSignal {
    return _signal;
  }
}
