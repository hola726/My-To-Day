import 'package:flutter/material.dart';
import 'package:my_to_day/provider/data_provider.dart';

import '../model/data/diary_data.dart';

class CalendarProvider extends ChangeNotifier {
  CalendarProvider({
    required BuildContext context,
    required DataProvider dataProvider,
  })  : _context = context,
        _dataProvider = dataProvider {
    _dataProvider.selectDateReversedData = _getSelectDateReversedData();
  }
  final BuildContext _context;
  final DataProvider _dataProvider;
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

  List<DiaryData> eventHandler(DateTime day) {
    List<DiaryData> event = [];
    for (DiaryData data in _dataProvider.allDiaryData) {
      if (data.time.year == day.year &&
          data.time.month == day.month &&
          data.time.day == day.day) {
        event.add(data);
      }
    }

    return event;
  }

  List<DiaryData?> _getSelectDateReversedData() {
    List<DiaryData?> result = [];
    for (DiaryData data in _dataProvider.allDiaryData) {
      if (data.time.year == DateTime.now().year &&
          data.time.month == DateTime.now().month &&
          data.time.day == DateTime.now().day) {
        result.add(data);
      }
    }
    return result.reversed.map((data) => data).toList();
  //   return _dataProvider.allDiaryData
  //       .map((diaryData) {
  //         if (diaryData.time.year == DateTime.now().year &&
  //             diaryData.time.month == DateTime.now().month &&
  //             diaryData.time.day == DateTime.now().day) {
  //           return diaryData;
  //         }
  //       })
  //       .toList()
  //       .reversed
  //       .map((data) => data)
  //       .toList();
  // }
}
