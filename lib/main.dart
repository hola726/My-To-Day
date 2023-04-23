import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_to_day/constants/constants.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/service/local_service.dart';
import 'package:provider/provider.dart';

import 'routes/router.dart';

void main() async {
  final LocalService localStorageHelper = LocalService();
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
          localService: DiaryLocalService(localService: LocalService()),
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
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      ),
    );
  }
}
