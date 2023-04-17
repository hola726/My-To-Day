import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/data/diary_data.dart';
import '../../../utils/modal_helper.dart';
import '../../diary/page/diary_edit_page.dart';
import '../page/calendar_page.dart';

class CalendarPageModel extends ChangeNotifier {
  CalendarPageModel({
    required BuildContext context,
    required DiaryLocalService localService,
  })  : _context = context,
        _localService = localService {
    init();
  }

  final BuildContext _context;
  final DiaryLocalService _localService;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<DiaryData> _selectData = [];
  DateTime _selectDate = DateTime.now();
  late String _localPath;

  BuildContext get context => _context;
  List<DiaryData> get selectData => _selectData;
  DateTime get selectDate => _selectDate;
  String get localPath => _localPath;

  void init() async {
    _localPath = (await getApplicationDocumentsDirectory()).path;
    _selectData = _filterData(DateTime.now());
    notifyListeners();
  }

  bool isSameDay(DateTime day) {
    return selectedDay == day;
  }

  bool isSameDate(DiaryData data, DiaryData? previousData) {
    return data.time.year == previousData?.time.year &&
        data.time.month == previousData?.time.month &&
        data.time.day == previousData?.time.day;
  }

  void onDaySelected(DateTime select, DateTime focused) {
    selectedDay = select;
    focusedDay = focused;
    _handleSelectDate(select);
    notifyListeners();
  }

  void _handleSelectDate(DateTime date) {
    _selectDate = date;
    _selectData = _filterData(date);
    notifyListeners();
  }

  List<DiaryData> _filterData(DateTime date) {
    List<DiaryData> result = [];
    List<DiaryData> allDiaryData = _localService.getAllDiaryData();

    for (DiaryData diaryData in allDiaryData) {
      if (diaryData.time.year == date.year &&
          diaryData.time.month == date.month &&
          diaryData.time.day == date.day) {
        result.add(diaryData);
      }
    }
    result.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    return result.reversed.toList();
  }

  List<DiaryData> eventHandler(DateTime date) {
    return _filterData(date);
  }

  void _onEditPressed(DiaryData data) {
    context.go(CalendarPage.id + DiaryEditPage.id, extra: data);
    context.pop();
    notifyListeners();
  }

  void onItemTap(int index) async {
    DiaryData data = _selectData[index];
    await ModalHelper.openDiaryDetailModal(
      context: context,
      diaryData: data,
      localPath: _localPath,
      onEditPressed: () => _onEditPressed(data),
    );

    _selectData = _filterData(_selectDate);
    notifyListeners();
  }
}
