import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/service/local_service.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';
import '../screens/main/diary_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) {
        return DiaryScreen.setProviderRoute();
      },
    ),
  ],
);

Widget diaryScreen(_, __) {
  return ChangeNotifierProvider(
    create: (context) => DiaryProvider(
      context: context,
      dataProvider: context.read<DataProvider>(),
      diaryTextFormController: TextEditingController(),
      searchTextFormController: TextEditingController(),
      localStorageHelper: LocalService(),
      diaryTextFormFocusNode: FocusNode(),
    ),
    child: DiaryScreen(
        dataProvider: context.read<DataProvider>(),
        diaryProvider: context.read<DiaryProvider>()),
  );
}
