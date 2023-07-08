import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThimProvider with ChangeNotifier {
  ThemeMode  thememMode = ThemeMode.light;
  bool act=true ;

  void changingMode(bool mode) async{
    mode ? thememMode = ThemeMode.light : thememMode = ThemeMode.dark;
    act=mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('check', act);


  }
getThemeMode()async{
  final prefs = await SharedPreferences.getInstance();
  act=await prefs.getBool('check')??true;
  act ? thememMode = ThemeMode.light : thememMode = ThemeMode.dark;
  notifyListeners();

}


}
