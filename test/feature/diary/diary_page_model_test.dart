import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_to_day/feature/diary/page_model/diary_page_model.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../mock/diary_local_service.mocks.dart';
import '../../mock/mock.mocks.dart';

const String kApplicationDocumentsPath = 'applicationDocumentsPath';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }
}

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

  test("should edit diary data", () {
    // given
    when(mockDiaryLocalService.editDiaryData(diaryData: anyNamed("diaryData")))
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
}
