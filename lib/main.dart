import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/constants/constants.dart';
import 'package:my_to_day/routes.dart';
import 'package:my_to_day/screens/main/init_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(kRatioBaseWith, kRatioBaseHeight),
      builder: (BuildContext context) => MaterialApp(
        title: 'MyToDay',
        debugShowCheckedModeBanner: false,
        initialRoute: InitScreen.id,
        routes: routes,
        theme: ThemeData.light(),
      ),
    );
  }
}
