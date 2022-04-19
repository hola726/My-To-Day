import 'package:intl/intl.dart';

class DateHelper {
  static String convertDate(DateTime dateTime) {
    return DateFormat("MM/dd a hh:mm").format(dateTime);
  }

  static String convertDateAmPm(DateTime dateTime) {
    return DateFormat("a hh:mm").format(dateTime);
  }

  static String convertDateMonth(DateTime dateTime) {
    return DateFormat("d MMM, y").format(dateTime);
  }
}
