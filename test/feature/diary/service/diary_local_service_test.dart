import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_to_day/model/data/diary_data.dart';

import '../../../mock/diary_local_service.mocks.dart';

List<DiaryData> mockDiaryData = [
  DiaryData(
    contents: "contents1",
    time: DateTime(2023, 1, 1),
  ),
  DiaryData(
    contents: "contents2",
    time: DateTime(2024, 2, 2),
  ),
];

void main() {
  late MockDiaryLocalService mockDiaryLocalService;

  setUp(() {
    mockDiaryLocalService = MockDiaryLocalService();
  });

  group("Diary Local Service", () {
    group("get all diary data", () {
      test("should get all diary data", () {
        // given
        when(mockDiaryLocalService.getAllDiaryData()).thenReturn(mockDiaryData);
        // when
        final List<DiaryData> diaryDataList =
            mockDiaryLocalService.getAllDiaryData();

        // then
        expect(diaryDataList, mockDiaryData);
      });

      test("should get all diary data verify", () {
        // given
        when(mockDiaryLocalService.getAllDiaryData()).thenReturn(mockDiaryData);
        // when
        final List<DiaryData> diaryDataList =
            mockDiaryLocalService.getAllDiaryData();

        // then
        verify(mockDiaryLocalService.getAllDiaryData()).called(1);
      });
    });

    test("should set diary data", () {
      // given
      when(mockDiaryLocalService.setDiaryData(diaryData: anyNamed("diaryData")))
          .thenAnswer((_) async => {});

      // when
      mockDiaryLocalService.setDiaryData(diaryData: mockDiaryData[0]);

      // then
      verify(mockDiaryLocalService.setDiaryData(
              diaryData: anyNamed("diaryData")))
          .called(1);
    });

    test("should edit diary data", () {
      // given
      when(mockDiaryLocalService.editDiaryData(
              diaryData: anyNamed("diaryData")))
          .thenAnswer((_) async => {});

      // when
      mockDiaryLocalService.editDiaryData(diaryData: mockDiaryData[0]);

      // then
      verify(mockDiaryLocalService.editDiaryData(
              diaryData: anyNamed("diaryData")))
          .called(1);
    });

    test("should delete diary data", () {
      // given
      when(mockDiaryLocalService.deleteDiaryData(key: anyNamed("key")))
          .thenAnswer((_) async => {});

      // when
      mockDiaryLocalService.deleteDiaryData(key: 0);

      // then
      verify(mockDiaryLocalService.deleteDiaryData(key: anyNamed("key")))
          .called(1);
    });
  });
}
