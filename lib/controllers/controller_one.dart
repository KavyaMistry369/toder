import 'package:flutter/material.dart';

class ControllerOne extends ChangeNotifier{

  bool isVisible = false;
  bool isGrid = false;
  bool isDark = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();

  String? time;
  String? date;

  DateTime mydate = DateTime.now();
  TimeOfDay timeMy = TimeOfDay.fromDateTime(DateTime.now());
  DateTime mytime = DateTime.now();

  void changeDate({required DateTime date}) {
    mydate = date;
    notifyListeners();
  }

  void changeTheme(){
    isDark=!isDark;
    notifyListeners();
  }

  void changeLayout(){
    isGrid=!isGrid;
    notifyListeners();
  }

  changeMytime({required DateTime time}) {
    mytime = TimeOfDay.fromDateTime(time) as DateTime;
    notifyListeners();
  }

  changeTime({required DateTime time}) {
    timeMy = TimeOfDay.fromDateTime(time);
    notifyListeners();
  }

  void changeVisible(){
    isVisible=!isVisible;
    notifyListeners();
  }

}