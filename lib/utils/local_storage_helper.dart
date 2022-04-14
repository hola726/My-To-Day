import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

enum HiveKey {
  diaryData,
}

class LocalStorageHelper {
  static final LocalStorageHelper _singleton = LocalStorageHelper._internal();
  factory LocalStorageHelper() => _singleton;

  LocalStorageHelper._internal();

  Future<Box<T>> handleOpenBox<T>(HiveKey key) async {
    return await Hive.openBox<T>(
      describeEnum(
        key,
      ),
    );
  }

  Box<T> handleBox<T>(HiveKey key) {
    return Hive.box<T>(
      describeEnum(
        key,
      ),
    );
  }

  void registerAdapter() {
    // Hive.registerAdapter(BlockTaskAdapter());
  }

  Future<void> openBox() async {
    // await handleOpenBox<String>(HiveKey.USER_ID);
  }
}
