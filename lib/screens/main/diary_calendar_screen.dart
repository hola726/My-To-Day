import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/utils/modal_helper.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../app_theme.dart';
import '../../model/data/diary_data.dart';
import '../../provider/calendar_provider.dart';
import '../../widgets/common/diary_item.dart';
import 'diary_screen.dart';

class DiaryCalendarScreen extends StatelessWidget {
  static const id = '/DiaryCalendarScreen';
  const DiaryCalendarScreen._({
    Key? key,
    required CalendarProvider calendarProvider,
    required DataProvider dataProvider,
  })  : _calendarProvider = calendarProvider,
        _dataProvider = dataProvider,
        super(key: key);

  static Widget setProviderRoute() {
    return ChangeNotifierProvider<CalendarProvider>(
      create: (BuildContext context) => CalendarProvider(
        context: context,
      ),
      child: Consumer2<CalendarProvider, DataProvider>(
        builder: (_, calendarProvider, dataProvider, __) =>
            DiaryCalendarScreen._(
          calendarProvider: calendarProvider,
          dataProvider: dataProvider,
        ),
      ),
    );
  }

  final CalendarProvider _calendarProvider;
  final DataProvider _dataProvider;

  Widget _buildMain() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TableCalendar(
            calendarBuilders: CalendarBuilders(),
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(
                color: Colors.white,
              ),
              weekendTextStyle: TextStyle(
                color: Colors.white,
              ),
              outsideTextStyle: TextStyle(
                color: AppTheme.grey600,
              ),
              disabledTextStyle: TextStyle(
                color: AppTheme.secondaryColor,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_calendarProvider.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              _calendarProvider.selectedDay = selectedDay;
              _calendarProvider.focusedDay = focusedDay;
              _dataProvider.handleSelectDateDataChanged(selectedDay);
            },
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _calendarProvider.focusedDay,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _dataProvider.selectDateReversedData.length,
              itemBuilder: (context, index) {
                DiaryData? data = _dataProvider.selectDateReversedData[index];
                DiaryData? previousData = 0 <= index - 1
                    ? _dataProvider.selectDateReversedData[index - 1]
                    : null;

                return data == null
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_dataProvider.isSameDay(data, previousData) ==
                              false)
                            SubTitleData(data: data),
                          DiaryItem(
                            data: data,
                            dataProvider: _dataProvider,
                            onTap: () async {
                              _dataProvider.targetDataIndex = index;
                              _dataProvider.diaryData = data;
                              await ModalHelper.openDiaryDetailModal(
                                context: context,
                                dataProvider: _dataProvider,
                              );
                              _dataProvider.getSelectDateData();
                            },
                          ),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Calendar',
        // rightTopWidget: ,
        bottomShadow: true,
        titleColor: AppTheme.primaryContrastColor,
        backgroundColors: AppTheme.textPrimaryColor,
      ),
      body: _buildMain(),
    );
  }
}

class Message {}
