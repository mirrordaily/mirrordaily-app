enum WeatherType {
  sunny,
  partlyCloudy,
  cloudy,
  shower,
  thunderShower,
  rain,
  heavyRain,
  storm,
  snow,
  other,
}

extension WeatherTypeDisplayText on WeatherType {
  String get displayText {
    switch (this) {
      case WeatherType.sunny:
        return '晴';
      case WeatherType.partlyCloudy:
        return '多雲';
      case WeatherType.cloudy:
        return '陰';
      case WeatherType.shower:
        return '陣雨';
      case WeatherType.thunderShower:
        return '雷陣雨';
      case WeatherType.rain:
        return '雨';
      case WeatherType.heavyRain:
        return '大雨';
      case WeatherType.storm:
        return '暴雨';
      case WeatherType.snow:
        return '雪';
      case WeatherType.other:
        return '其他';
    }
  }
}