import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import '../../../model/data/diary_data.dart';
import '../../../provider/data_provider.dart';

class CalendarPageModel extends ChangeNotifier {
  CalendarPageModel({
    required BuildContext context,
    required DataProvider dataProvider,
  })  : _context = context,
        _dataProvider = dataProvider {
    init();
  }

  final BuildContext _context;
  final DataProvider _dataProvider;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  BuildContext get context => _context;
  DataProvider get dataProvider => _dataProvider;

  void init() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        _dataProvider.selectDateReversedData = _getSelectDateReversedData());
  }

  bool isSameDay(DateTime day) {
    return selectedDay == day;
  }

  void onDaySelected(DateTime select, DateTime focused) {
    selectedDay = select;
    focusedDay = focused;
    dataProvider.handleSelectDateDataChanged(select);
    notifyListeners();
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
  }
}
