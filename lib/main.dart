import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_to_day/constants/constants.dart';
import 'package:my_to_day/routes.dart';
import 'package:my_to_day/screens/main/init_screen.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';

void main() async {
  final LocalStorageHelper localStorageHelper = LocalStorageHelper();
  await Hive.initFlutter();
  localStorageHelper.registerAdapter();
  await localStorageHelper.openBox();
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
