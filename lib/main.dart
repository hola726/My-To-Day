import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_to_day/constants/constants.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/routes.dart';
import 'package:my_to_day/screens/main/diary_screen.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:provider/provider.dart';

void main() async {
  final LocalStorageHelper localStorageHelper = LocalStorageHelper();
  await Hive.initFlutter();
  localStorageHelper.registerAdapter();
  await localStorageHelper.openBox();
  runApp(
    setProviders(
      const MyApp(),
    ),
  );
}

Widget setProviders(Widget app) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<DataProvider>(
        create: (_) => DataProvider(
          localStorageHelper: LocalStorageHelper(),
        ),
      ),
    ],
    child: app,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(kRatioBaseWith, kRatioBaseHeight),
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: DiaryScreen.id,
        routes: routes,
      ),
    );
  }
}
