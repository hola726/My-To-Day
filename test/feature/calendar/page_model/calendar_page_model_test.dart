import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_to_day/feature/calendar/page_model/calendar_page_model.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../../mock/diary_local_service.mocks.dart';
import '../../../mock/mock.mocks.dart';

const String kApplicationDocumentsPath = 'applicationDocumentsPath';
List<DiaryData> mockDiaryDataList = [
  DiaryData(
      contents: "contents1", time: DateTime.now().add(Duration(hours: 1))),
  DiaryData(
      contents: "contents2", time: DateTime.now().add(Duration(hours: 2))),
  DiaryData(
      contents: "contents3", time: DateTime.now().add(Duration(hours: 3))),
  DiaryData(contents: "contents4", time: DateTime(2024, 02, 02)),
  DiaryData(contents: "contents5", time: DateTime(2024, 03, 03)),
];

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }
}

void main() {
  late CalendarPageModel calendarPageModel;
  late MockBuildContext mockBuildContext;
  late MockDiaryLocalService mockDiaryLocalService;

  group("CalendarPageModel", () {
    setUp(() {
      PathProviderPlatform.instance = FakePathProviderPlatform();
      mockBuildContext = MockBuildContext();
      mockDiaryLocalService = MockDiaryLocalService();

      when(mockDiaryLocalService.getAllDiaryData())
          .thenReturn(mockDiaryDataList);

      calendarPageModel = CalendarPageModel(
        context: mockBuildContext,
        localService: mockDiaryLocalService,
      );
    });

    group("init", () {
      test("should get local path", () {
        // then
        expect(calendarPageModel.localPath, kApplicationDocumentsPath);
      });

      test("should get select data", () {
        // given
        List<DiaryData> handleData = [];
        final date = DateTime.now();
        for (DiaryData diaryData in mockDiaryDataList) {
          if (diaryData.time.year == date.year &&
              diaryData.time.month == date.month &&
              diaryData.time.day == date.day) {
            handleData.add(diaryData);
          }
        }
        handleData.sort((a, b) {
          return a.time.compareTo(b.time);
        });

        final result = handleData.reversed.toList();
        //test
        // then
        verify(mockDiaryLocalService.getAllDiaryData()).called(1);
        expect(calendarPageModel.selectData.length, 3);
        expect(calendarPageModel.selectData[0], result[0]);
        expect(calendarPageModel.selectData[1], result[1]);
        expect(calendarPageModel.selectData[2], result[2]);
      });
    });
  });
}
