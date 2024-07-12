import 'package:intl/intl.dart';

extension DateConversion on String {
  String toFormattedYYYYMMDD() {
    try {
      // 解析时间字符串为 DateTime 对象
      DateTime dateTime = DateTime.parse(this);

      // 使用 DateFormat 格式化日期
      DateFormat dateFormat = DateFormat('yyyy/MM/dd HH:mm');
      return dateFormat.format(dateTime);
    } catch (e) {
      // 如果解析失败，返回原字符串或自定义错误消息
      return 'Invalid date';
    }
  }
}