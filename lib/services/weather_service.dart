import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/controllers/daily_two_day_model.dart';
import 'package:weather_app/controllers/weather_model.dart';

class WeatherService {
  var cityLat ='';
  var cityLong ='';
  String appiId = '5834c11c9ba20a29be78f99dbb24a314';
  Future<WeatherModel> fetchWeather(String city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appiId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      WeatherModel weatherInfo = WeatherModel.fromJson(result);
      return weatherInfo;
    } else {
      throw 'Error';
    }
  }
  Future<Next7Days> guessWeather(String city) async {
    List<Location> locations = await locationFromAddress('${city}');
    Location newLocation = locations.first;
    cityLat =newLocation.latitude.toString();
    cityLong = newLocation.longitude.toString();
    var daily =Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${cityLat}&lon=${cityLong}&exclude=hourly,dailyt&appid=${appiId}');
    var feedback = await http.get(daily);
    if (feedback.statusCode == 200) {
      var resul = jsonDecode(feedback.body);
      Next7Days model = Next7Days.fromJson(resul);
      return model;
    } else {
      throw 'Error';
    }
  }
}
