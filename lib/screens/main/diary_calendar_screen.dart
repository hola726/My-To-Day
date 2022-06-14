import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../app_theme.dart';
import '../../provider/calendar_provider.dart';

class DiaryCalendarScreen extends StatelessWidget {
  static const id = '/DiaryCalendarScreen';
  const DiaryCalendarScreen._({
    Key? key,
    required CalendarProvider calendarProvider,
  })  : _calendarProvider = calendarProvider,
        super(key: key);

  static Widget setProviderRoute() {
    return ChangeNotifierProvider<CalendarProvider>(
      create: (BuildContext context) => CalendarProvider(),
      child: Consumer<CalendarProvider>(
        builder: (_, calendarProvider, __) => DiaryCalendarScreen._(
          calendarProvider: calendarProvider,
        ),
      ),
    );
  }

  final CalendarProvider _calendarProvider;

  Widget _buildMain() {
    return Container(
      color: Colors.black,
      child: TableCalendar(
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
        selectedDayPredicate: (day) {
          return isSameDay(_calendarProvider.selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          _calendarProvider.selectedDay = selectedDay;
          _calendarProvider.focusedDay = focusedDay;
        },
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
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
