import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/enums/city.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(ignore: true)
  late final Map<City, WeatherData> cityWeatherMap;

  WeatherResponse();

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final result = WeatherResponse();
    result.cityWeatherMap = {};

    for (final entry in json.entries) {
      final city = CityExtension.fromChinese(entry.key);
      if (city != null) {
        result.cityWeatherMap[city] = WeatherData.fromJson(entry.value);
      }
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    for (final entry in cityWeatherMap.entries) {
      json[entry.key.chineseName] = entry.value.toJson();
    }
    return json;
  }
}

@JsonSerializable()
class WeatherData {
  final String date;

  @JsonKey(name: 'max_temp')
  final int maxTemp;

  @JsonKey(name: 'min_temp')
  final int minTemp;

  @JsonKey(name: 'weather_desc')
  final String weatherDesc;

  @JsonKey(name: 'weather_code')
  final String weatherCode;

  final String weather;

  @JsonKey(name: 'fetch_time')
  final String fetchTime;

  WeatherData(
    this.date,
    this.maxTemp,
    this.minTemp,
    this.weatherDesc,
    this.weatherCode,
    this.weather,
    this.fetchTime,
  );

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);

  String get weatherIconAsset {
    switch (weather) {
      case '晴':
        return 'assets/image_svg/ic_weather_type_1.svg';
      case '多雲':
        return 'assets/image_svg/ic_weather_type_2.svg';
      case '陰':
        return 'assets/image_svg/ic_weather_type_3.svg';
      case '陣雨':
        return 'assets/image_svg/ic_weather_type_4.svg';
      case '雷陣雨':
        return 'assets/image_svg/ic_weather_type_5.svg';
      case '雨':
        return 'assets/image_svg/ic_weather_type_6.svg';
      case '大雨':
        return 'assets/image_svg/ic_weather_type_7.svg';
      case '暴雨':
        return 'assets/image_svg/ic_weather_type_8.svg';
      case '雪':
        return 'assets/image_svg/ic_weather_type_9.svg';
      default:
        return 'assets/image_svg/ic_weather_type_10.svg';
    }
  }
}
