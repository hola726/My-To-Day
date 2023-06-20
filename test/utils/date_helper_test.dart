import 'package:flutter_test/flutter_test.dart';
import 'package:my_to_day/utils/date_helper.dart';

void main() {
  group("convert date", () {
    test("should convert date", () {
      // when
      String convertDate =
          DateHelper.convertDate(DateTime(2023, 01, 01, 01, 01));

      // then
      expect(convertDate, "01/01 AM 01:01");
    });
    test("should convert date", () {
      // when
      String convertDate =
          DateHelper.convertDate(DateTime(2024, 02, 02, 02, 02));
      // then
      expect(convertDate, "02/02 AM 02:02");
    });
  });

  group("convert date am pm", () {
    test("should convert date am pm", () {
      // when
      String convertDate =
          DateHelper.convertDateAmPm(DateTime(2023, 01, 01, 01, 01));

      // then
      expect(convertDate, "AM 01:01");
    });

    test("should convert date am pm", () {
      // when
      String convertDate =
          DateHelper.convertDateAmPm(DateTime(2024, 02, 02, 02, 02));

      // then
      expect(convertDate, "AM 02:02");
    });
  });

  group("convert date Month", () {
    test("should convert date Month", () {
      // when
      String convertDate =
          DateHelper.convertDateMonth(DateTime(2023, 01, 01, 01, 01));

      // then
      expect(convertDate, "1 Jan, 2023");
    });
    test("should convert date Month", () {
      // when
      String convertDate =
          DateHelper.convertDateMonth(DateTime(2024, 02, 02, 02, 02));

      // then
      expect(convertDate, "2 Feb, 2024");
    });
  });
}
