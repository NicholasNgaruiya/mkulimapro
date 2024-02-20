import 'package:flutter/material.dart';

class CheckoutProductTotalsController extends ChangeNotifier {

  void requestUIUpdate() {
    notifyListeners();
  }
}