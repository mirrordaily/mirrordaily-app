import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedYYYYMMDDHHMMSS() {
    return DateFormat('yyyy/MM/dd HH:mm').format(this);
  }

}