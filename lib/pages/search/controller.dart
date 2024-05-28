import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/weather_controller.dart';
class SearchController extends GetxController {
  final c = Get.put(WeatherController());
  TextEditingController cityText = TextEditingController();

  handleSearchCity(BuildContext context) {
    c.fetchWeather(cityText.text);
    c.guessWeather(cityText.text);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}