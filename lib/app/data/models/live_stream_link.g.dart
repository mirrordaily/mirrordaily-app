// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStreamLink _$LiveStreamLinkFromJson(Map<String, dynamic> json) =>
    LiveStreamLink(
      name: json['name'] as String?,
      startDate: _$JsonConverterFromJson<String, DateTime>(
          json['startDate'], const DateTimeConverter().fromJson),
      endDate: _$JsonConverterFromJson<String, DateTime>(
          json['endDate'], const DateTimeConverter().fromJson),
      link: json['link'] as String?,
    );

Map<String, dynamic> _$LiveStreamLinkToJson(LiveStreamLink instance) =>
    <String, dynamic>{
      'name': instance.name,
      'startDate': _$JsonConverterToJson<String, DateTime>(
          instance.startDate, const DateTimeConverter().toJson),
      'endDate': _$JsonConverterToJson<String, DateTime>(
          instance.endDate, const DateTimeConverter().toJson),
      'link': instance.link,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
