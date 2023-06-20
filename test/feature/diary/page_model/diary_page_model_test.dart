import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_to_day/feature/diary/page_model/diary_page_model.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../../mock/diary_local_service.mocks.dart';
import '../../../mock/mock.mocks.dart';

const String kApplicationDocumentsPath = 'applicationDocumentsPath';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }
}

final List<DiaryData> mockDiaryDataList = [
  DiaryData(
    contents: "contents",
    time: DateTime(2023, 01, 01),
  ),
  DiaryData(
    contents: "value",
    time: DateTime(2024, 02, 02),
  ),
  DiaryData(
    contents: "value",
    time: DateTime(2025, 03, 03),
  ),
];

const List<String> mockFileNames = ["fileName1", "fileName2", "fileName3"];

void main() {
  late DiaryPageModel diaryPageModel;
  MockDiaryLocalService mockDiaryLocalService = MockDiaryLocalService();
  MockBuildContext mockBuildContext = MockBuildContext();
  MockTextEditingController mockTextEditingController =
      MockTextEditingController();
  MockFocusNode mockFocusNode = MockFocusNode();

  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    diaryPageModel = DiaryPageModel(
      context: mockBuildContext,
      diaryTextFormFocusNode: mockFocusNode,
      localService: mockDiaryLocalService,
      diaryTextFormController: mockTextEditingController,
      searchTextFormController: mockTextEditingController,
    );
  });

  group("diary page model", () {
    test("should edit diary data", () {
      // given
      when(mockDiaryLocalService.editDiaryData(
              diaryData: anyNamed("diaryData")))
          .thenAnswer((realInvocation) async {});

      // when
      diaryPageModel.editDiaryData(
        contents: "contents",
        date: DateTime(2023, 01, 01),
      );

      // then
      verify(mockDiaryLocalService.editDiaryData(
              diaryData: anyNamed("diaryData")))
          .called(1);
    });

    test("should handle search text form changed", () {
      // given
      when(mockTextEditingController.value)
          .thenReturn(TextEditingValue(text: "text"));

      // when
      diaryPageModel.handleSearchedDataChanged("value");

      // then
      expect(mockTextEditingController.value.text, "text");
    });

    group("get all diary data", () {
      test("should get all diary data check diary data list", () {
        // given
        clearInteractions(mockDiaryLocalService);
        when(mockDiaryLocalService.getAllDiaryData())
            .thenReturn(mockDiaryDataList);
        List<DiaryData> handleDiaryDataList = mockDiaryDataList;
        handleDiaryDataList.sort((a, b) {
          return a.time.compareTo(b.time);
        });
        handleDiaryDataList = handleDiaryDataList.reversed.toList();

        // when
        diaryPageModel.getAllDiaryData();

        // then
        verify(mockDiaryLocalService.getAllDiaryData()).called(1);

        expect(mockDiaryLocalService.getAllDiaryData(), mockDiaryDataList);
        expect(diaryPageModel.diaryDataList, handleDiaryDataList);
      });

      test("should get all diary data check searched data", () {
        // when
        diaryPageModel.getAllDiaryData();

        // then
        expect(diaryPageModel.searchedData, []);
      });
    });

    group("handle searched data changed", () {
      test("should searched data changed", () {
        //given
        when(mockDiaryLocalService.getAllDiaryData())
            .thenReturn(mockDiaryDataList);

        //when
        diaryPageModel.getAllDiaryData();
        diaryPageModel.handleSearchedDataChanged("value");

        // then
        expect(diaryPageModel.searchedData.length, 2);
        expect(diaryPageModel.searchedData[0].time, mockDiaryDataList[2].time);
        expect(diaryPageModel.searchedData[1].time, mockDiaryDataList[1].time);
      });

      test("should searched data empty", () {
        //given
        when(mockDiaryLocalService.getAllDiaryData())
            .thenReturn(mockDiaryDataList);

        //when
        diaryPageModel.getAllDiaryData();
        diaryPageModel.handleSearchedDataChanged("");

        // then
        expect(diaryPageModel.searchedData.length, 0);
        expect(diaryPageModel.searchedData.isEmpty, true);
      });
    });

    test("should on camera pressed", () {
      // when
      diaryPageModel.onCameraPressed(mockFileNames.first);

      // then
      expect(diaryPageModel.diaryData!.cameraImage, mockFileNames.first);
    });

    test("should on images pressed", () {
      // when
      diaryPageModel.onImagesPressed(mockFileNames);

      // then
      expect(diaryPageModel.diaryData!.pickerImages, mockFileNames);
    });

    test("should on save pressed", () {
      // when
      diaryPageModel.onSavePressed();

      // then
      expect(diaryPageModel.diaryData, null);
      verifyNever(
          mockDiaryLocalService.setDiaryData(diaryData: anyNamed("diaryData")));
      verifyNever(mockTextEditingController.clear());
    });
  });
}
