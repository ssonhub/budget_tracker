import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  // this will hold if we are on the dark theme or not
  bool _darkTheme = true;

  // Let's create a getter now and a setter for it
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    /* we want to notify widgets and change the app state when we set
    the dark theme. ChangeNotifier provides us with a notifyListeners()
    method that does that */
    notifyListeners();
  }
}
