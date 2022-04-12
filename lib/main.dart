import 'package:flutter/material.dart';
import 'package:my_to_day/routes.dart';
import 'package:my_to_day/screens/main/init_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyToDay',
      debugShowCheckedModeBanner: false,
      initialRoute: InitScreen.id,
      routes: routes,
      theme: ThemeData.light(),
    );
  }
}
