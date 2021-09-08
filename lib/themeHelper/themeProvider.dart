import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_api_project/themeHelper/themeHelper.dart';
enum MyThemeMode { light, dark, kids }
class ThemeProvider extends ChangeNotifier{
  ThemeData selectedTheme = ThemeHelper.themeHelper.lightThemeData;
  selectAnotherTheme(MyThemeMode mode) {
    if (mode == MyThemeMode.dark) {
      selectedTheme = ThemeHelper.themeHelper.darkThemeData;
    } else if (mode == MyThemeMode.light) {
      selectedTheme = ThemeHelper.themeHelper.lightThemeData;
    } else {
      selectedTheme = ThemeHelper.themeHelper.kidsThemeData;
    }
    notifyListeners();
  }
  void handleClick(String value) {
    switch (value) {
      case 'Light':
        selectAnotherTheme(MyThemeMode.light);
        break;
      case 'Dark':
        selectAnotherTheme(MyThemeMode.dark);
        break;
      case 'Kids':
        selectAnotherTheme(MyThemeMode.kids);
        break;
    }
  }
}