import 'package:flutter/material.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/screens/main/diary_screen.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:provider/provider.dart';

class DiaryPage extends StatelessWidget {
  static const id = '/DiaryPage';
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaryProvider>(
      create: (_) => DiaryProvider(
        localStorageHelper: LocalStorageHelper(),
        context: context,
      ),
      child: DiaryScreen(),
    );
  }
}
