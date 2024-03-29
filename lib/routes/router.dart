import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_to_day/feature/calendar/page/calendar_page.dart';
import 'package:my_to_day/feature/calendar/page_model/calendar_page_model.dart';
import 'package:my_to_day/feature/diary/page/diary_edit_page.dart';
import 'package:my_to_day/feature/diary/page/diary_page.dart';
import 'package:my_to_day/feature/diary/page_model/diary_edit_page_model.dart';
import 'package:my_to_day/feature/diary/page_model/diary_page_model.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/service/local_service.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: diaryPage,
      routes: [
        GoRoute(
          path: 'diaryEditPage',
          builder: diaryEditPage,
        ),
        GoRoute(
          path: 'calendarPage',
          builder: calendarPage,
          routes: [
            GoRoute(
              path: 'diaryEditPage',
              builder: diaryEditPage,
            ),
          ],
        ),
      ],
    ),
  ],
);

Widget diaryPage(_, __) {
  return ChangeNotifierProvider(
    create: (context) => DiaryPageModel(
      context: context,
      diaryTextFormController: TextEditingController(),
      searchTextFormController: TextEditingController(),
      diaryTextFormFocusNode: FocusNode(),
      localService: DiaryLocalService(localService: LocalService()),
    ),
    child: DiaryPage(),
  );
}

Widget diaryEditPage(_, GoRouterState state) {
  return ChangeNotifierProvider(
    create: (context) => DiaryEditPageModel(
      context: context,
      diaryData: state.extra as DiaryData,
      diaryTextFormController: TextEditingController(),
      diaryTextFormFocusNode: FocusNode(),
      diaryLocalService: DiaryLocalService(localService: LocalService()),
    ),
    child: DiaryEditPage(),
  );
}

Widget calendarPage(_, __) {
  return ChangeNotifierProvider(
    create: (context) => CalendarPageModel(
      context: context,
      localService: DiaryLocalService(localService: LocalService()),
    ),
    child: CalendarPage(),
  );
}
