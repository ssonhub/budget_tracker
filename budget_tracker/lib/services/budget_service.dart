import 'package:flutter/material.dart';

class BudgetService extends ChangeNotifier {
  /* A Budget in our app will be a simple double value.
  Let's initialize it, give it a setter and a getter the exact same as we did
  with dark/light mode */
  double _budget = 2000.0;
  double get budget => _budget;
  set budget(double value) {
    _budget = value;

    /* Don't forget to call notifyListeners on the setter to update the UI accordingly */
    notifyListeners();
  }
}
