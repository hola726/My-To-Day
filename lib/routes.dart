import 'package:flutter/material.dart';
import 'package:my_to_day/screens/main/diary_edit_screen.dart';
import 'package:my_to_day/screens/main/diary_screen.dart';

final Map<String, WidgetBuilder> routes = {
  DiaryScreen.id: (context) => DiaryScreen.setProviderRoute(),
  DiaryEditScreen.id: (context) => DiaryEditScreen.setProviderRoute(),
};

MaterialPageRoute routeWithFullScreenDialog(
  String routeName, {
  dynamic arguments,
}) {
  return MaterialPageRoute(
    builder: (context) => routes[routeName]!(context),
    fullscreenDialog: true,
    settings: RouteSettings(
      arguments: arguments,
    ),
  );
}
