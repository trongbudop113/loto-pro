import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeProvider with ChangeNotifier {

  final box = GetStorage();
  bool get isDark => box.read('darkmode') ?? false;

  ThemeMode _mode;
  ThemeMode get mode => _mode = isDark ? ThemeMode.dark : ThemeMode.light;
  ThemeProvider({
    ThemeMode mode = ThemeMode.light,
  }) : _mode = mode;

  void toggleMode(bool mode) {
    if(mode == true){
      _mode = ThemeMode.dark;
    }else{
      _mode = ThemeMode.light;
    }
    box.write('darkmode', mode);
    //_mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}