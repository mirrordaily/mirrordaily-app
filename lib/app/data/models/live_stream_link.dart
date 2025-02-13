import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/core/utils/date_time_convert.dart';

part 'live_stream_link.g.dart';

@JsonSerializable()
class LiveStreamLink extends Object {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'startDate')
  @DateTimeConverter()
  DateTime? startDate;

  @JsonKey(name: 'endDate')
  @DateTimeConverter()
  DateTime? endDate;

  @JsonKey(name: 'link')
  String? link;

  LiveStreamLink({this.name, this.startDate, this.endDate, this.link});

  factory LiveStreamLink.fromJson(Map<String, dynamic> srcJson) =>
      _$LiveStreamLinkFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LiveStreamLinkToJson(this);

  bool isWithinTimeRange() {
    if (startDate == null || endDate == null) return false;

    final now = DateTime.now();
    final startWindow = startDate!.subtract(const Duration(minutes: 5));
    final endWindow = endDate!.add(const Duration(minutes: 5));
    return now.isAfter(startWindow) && now.isBefore(endWindow);
  }
}
