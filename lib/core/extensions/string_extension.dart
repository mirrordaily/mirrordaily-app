
import 'package:intl/intl.dart';


extension DateConversion on String {
  String toFormattedYYYYMMDD() {
    try {
      // 解析成 UTC 時間，然後轉為 local
      DateTime dateTime = DateTime.parse(this).toLocal();

      DateFormat dateFormat = DateFormat('yyyy/MM/dd HH:mm');
      return dateFormat.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
  String toFormattedYYYYMMDDHHMMSS() {
    try {
      DateTime parsedDate = DateTime.parse(this);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
    } catch (e) {
      return this; // 解析失敗則返回原字串
    }
  }
}