import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_to_day/feature/diary/page_model/diary_edit_page_model.dart';
import 'package:my_to_day/model/data/diary_data.dart';

import '../../../mock/diary_local_service.mocks.dart';
import '../../../mock/mock.mocks.dart';

const mockImagesFileName = ["fileName1", "fileName2", "fileName3"];

DiaryData mockDiaryData = DiaryData(
  key: "key",
  contents: "contents",
  time: DateTime(2023, 01, 01),
);
void main() {
  late DiaryEditPageModel diaryEditPageModel;
  MockBuildContext mockBuildContext = MockBuildContext();
  MockFocusNode mockFocusNode = MockFocusNode();
  MockDiaryLocalService mockDiaryLocalService = MockDiaryLocalService();
  MockTextEditingController mockTextEditingController =
      MockTextEditingController();

  group("DiaryEditPageModel", () {
    setUp(() {
      diaryEditPageModel = DiaryEditPageModel(
        context: mockBuildContext,
        diaryData: mockDiaryData,
        diaryTextFormFocusNode: mockFocusNode,
        diaryLocalService: mockDiaryLocalService,
        diaryTextFormController: mockTextEditingController,
      );
    });

    group("init", () {
      test("should init", () {
        // then
        verify(mockFocusNode.requestFocus()).called(1);
      });
    });
    group("onCameraPressed", () {
      test("should get diary data when on camera pressed", () {
        // when
        diaryEditPageModel.onCameraPressed(mockImagesFileName.first);

        // then
        expect(diaryEditPageModel.diaryData!.cameraImage,
            mockImagesFileName.first);
        expect(diaryEditPageModel.diaryData!.key, mockDiaryData.key);
        expect(diaryEditPageModel.diaryData!.time, mockDiaryData.time);
        expect(diaryEditPageModel.diaryData!.contents, mockDiaryData.contents);
      });
    });
    group("onImagePressed", () {
      test("should get diary data when on image pressed", () {
        // when
        diaryEditPageModel.onImagesPressed(mockImagesFileName);

        // then
        expect(diaryEditPageModel.diaryData!.pickerImages, mockImagesFileName);
        expect(diaryEditPageModel.diaryData!.key, mockDiaryData.key);
        expect(diaryEditPageModel.diaryData!.contents, mockDiaryData.contents);
        expect(diaryEditPageModel.diaryData!.time, mockDiaryData.time);
      });
    });
  });
}
