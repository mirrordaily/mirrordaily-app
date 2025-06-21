import 'package:mirrordaily_app/app/data/helper/api_base_helper.dart';
import 'package:mirrordaily_app/app/data/models/weather_response.dart';
import 'package:mirrordaily_app/configs/environment.dart';

class WeatherApiProvider {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<WeatherResponse?> getWeatherData() async {
    final result = await apiBaseHelper.get(
      url: Environment().config.weatherApiPath,
    );
    if (result == null) return null;
    return WeatherResponse.fromJson(result);
  }
}
