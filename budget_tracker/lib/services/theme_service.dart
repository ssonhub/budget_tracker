import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  /* Let's work on modifying ThemeService to save and load our preference
  from local storage
  
  Let's first add a constructor to initialize a shared preferences variable
  inside the service */
  final SharedPreferences sharedPreferences;
  ThemeService(this.sharedPreferences);

  /* Now let's create a const key that we will use to access the location of
  where the preference is set. Good practice to use a defined key like that
  so we don't make typing erros. */

  static const darkThemeKey = "dark_theme";

  /* Now let's what we want to save is just a boolean that indicates if dark
  mode is on or off. So, every time we set darkMode, we want to set our preferences.
  Let's use setBool to save that using the key we defined the value coming
  from our set */

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreferences.setBool(
        darkThemeKey, value); // using defined key, and the value coming in
    notifyListeners();
  }

  /* Let's modify the getter now to get our saved preferences from local storage instead */
  bool get darkTheme {
    return sharedPreferences.getBool(darkThemeKey) ?? _darkTheme;
  }

  /* Here we just call .getBool with our defined key to attempt to get our saved
  preference. If we have never called setBool before it will return null, and
  if it does, we will assign our local variable _darkTheme to it which is
  the default value */

  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  // set darkTheme(bool value) {
  //   _darkTheme = value;

  //   notifyListeners();
  // }
}
