import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  CalendarProvider();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;

  set selectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  set focusedDay(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  bool isSameDay(DateTime firstDay, DateTime secondDay) {
    return firstDay == secondDay;
  }
}
