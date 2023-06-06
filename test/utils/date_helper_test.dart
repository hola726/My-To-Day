import 'package:flutter_test/flutter_test.dart';
import 'package:my_to_day/utils/date_helper.dart';

void main() {
  test("should convert date", () {
    String convertDate = DateHelper.convertDate(DateTime(2023, 01, 01, 01, 01));
    expect(convertDate, "01/01 AM 01:01");
  });
  test("should convert date am pm", () {
    String convertDate =
        DateHelper.convertDateAmPm(DateTime(2023, 01, 01, 01, 01));
    expect(convertDate, "AM 01:01");
  });
  test("should convert date Month", () {
    String convertDate =
        DateHelper.convertDateMonth(DateTime(2023, 01, 01, 01, 01));
    expect(convertDate, "1 Jan, 2023");
  });
}
