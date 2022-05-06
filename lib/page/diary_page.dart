import 'package:flutter/material.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/screens/main/diary_screen.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:provider/provider.dart';

class DiaryPage extends StatelessWidget {
  static const id = '/DiaryPage';
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiaryProvider(
        localStorageHelper: LocalStorageHelper(),
      ),
      child: DiaryScreen(),
    );
  }
}
