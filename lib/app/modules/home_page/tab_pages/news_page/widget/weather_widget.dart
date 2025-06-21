import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/city.dart';
import 'package:mirrordaily_app/app/data/models/weather_response.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(
      {super.key,
      this.city,
      this.weatherData,
      required this.onCitySelectEvent});

  final City? city;
  final WeatherData? weatherData;
  final Function(City?) onCitySelectEvent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6FB), // 背景色 #F6F6FB
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15), // 黑色陰影 15% 不透明度
              offset: Offset(0, 2), // x=0, y=2
              blurRadius: 2, // 模糊半徑
            ),
          ],
          borderRadius: BorderRadius.circular(8), // 如需圓角可加
        ),
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 6,
            ),
            Text(
              '今日天氣',
              style: Get.textTheme.titleLarge
                  ?.copyWith(fontSize: 16, color: const Color(0xFF7F8493)),
            ),
            const SizedBox(
              width: 20,
            ),
            DropdownButton<City>(
              value: city,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 32,
              ),
              style: Get.textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              onChanged: onCitySelectEvent,
              items: City.values.map<DropdownMenuItem<City>>((City value) {
                return DropdownMenuItem<City>(
                  value: value,
                  child: Text(value.chineseName),
                );
              }).toList(),
            ),
            const SizedBox(
              width: 12,
            ),
            weatherData?.weatherIconAsset != null
                ? SvgPicture.asset(
                    weatherData!.weatherIconAsset,
                    width: 18,
                    height: 18,
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 12,
            ),
            Text(
              '${weatherData?.maxTemp.toString() ?? StringDefault.nullString}º',
              style: Get.textTheme.titleLarge
                  ?.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
                '${weatherData?.minTemp.toString() ?? StringDefault.nullString}º',
                style: Get.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF7F8493),
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
