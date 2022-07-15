import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  CalendarProvider({
    required BuildContext context,
  }) : _context = context;
  final BuildContext _context;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  BuildContext get context => _context;

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
