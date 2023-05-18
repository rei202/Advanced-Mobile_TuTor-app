import 'package:flutter/material.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toogleTheme(bool value){
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
class MyTheme{
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    // colorScheme: ColorScheme.dark(),
    colorSchemeSeed:  myPurple,
    useMaterial3: true,
  );
  static final lightTheme = ThemeData(
      brightness: Brightness.light
  );
}