// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse();

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{};

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      json['date'] as String,
      (json['max_temp'] as num).toInt(),
      (json['min_temp'] as num).toInt(),
      json['weather_desc'] as String,
      json['weather_code'] as String,
      json['weather'] as String,
      json['fetch_time'] as String,
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'max_temp': instance.maxTemp,
      'min_temp': instance.minTemp,
      'weather_desc': instance.weatherDesc,
      'weather_code': instance.weatherCode,
      'weather': instance.weather,
      'fetch_time': instance.fetchTime,
    };
