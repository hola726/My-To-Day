import 'package:flutter/material.dart';
import 'package:my_to_day/feature/calendar/page_model/calendar_page_model.dart';
import 'package:my_to_day/utils/modal_helper.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app_theme.dart';
import '../../../constants/constant_strings.dart';
import '../../../model/data/diary_data.dart';
import '../../../widgets/common/diary_item.dart';
import '../../../widgets/common/subtitle_date.dart';

class CalendarPage extends StatelessWidget {
  static const id = '/calendarPage';
  const CalendarPage({Key? key}) : super(key: key);

  Widget _buildMain(CalendarPageModel model) {
    return Container(
      color: Colors.black,
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
              markerDecoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            selectedDayPredicate: model.isSameDay,
            onDaySelected: model.onDaySelected,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            eventLoader: model.eventHandler,
            focusedDay: model.focusedDay,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.dataProvider.selectDateReversedData.length,
              itemBuilder: (context, index) {
                DiaryData? data =
                    model.dataProvider.selectDateReversedData[index];
                DiaryData? previousData = 0 <= index - 1
                    ? model.dataProvider.selectDateReversedData[index - 1]
                    : null;

                return data == null
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (model.dataProvider
                                  .isSameDay(data, previousData) ==
                              false)
                            SubTitleDate(data: data),
                          DiaryItem(
                            data: data,
                            dataProvider: model.dataProvider,
                            onTap: () async {
                              model.dataProvider.targetDataIndex = index;
                              model.dataProvider.diaryData = data;
                              await ModalHelper.openDiaryDetailModal(
                                context: context,
                                dataProvider: model.dataProvider,
                              );
                              model.dataProvider.getSelectDateData();
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
    final CalendarPageModel model = context.watch<CalendarPageModel>();

    return Scaffold(
      appBar: MainAppBar(
        title: CALENDAR,
        bottomShadow: true,
        titleColor: AppTheme.primaryContrastColor,
        backgroundColors: AppTheme.textPrimaryColor,
      ),
      body: _buildMain(model),
    );
  }
}
