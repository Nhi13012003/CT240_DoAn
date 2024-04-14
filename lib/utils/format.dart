import 'package:intl/intl.dart';

class FormatLayout {
  static String formatTimeToString(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime stringToDateTime(String dateString, String format) {
    return DateFormat(format).parse(dateString);
  }
}
