import 'package:intl/intl.dart';

class DateHelper {
  static String convertDate(DateTime dateTime) {
    return DateFormat("MM/dd 'PM' hh:mm").format(dateTime);
  }
}
