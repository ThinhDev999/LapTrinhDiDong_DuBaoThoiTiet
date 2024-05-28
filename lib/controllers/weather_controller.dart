import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

import 'daily_two_day_model.dart';

class WeatherController extends GetxController {
  var weathers = WeatherModel().obs;
  var guess = Next7Days().obs;
  var cityValue = ''.obs;
  var result =''.obs;
  var day = DateFormat.d().format(DateTime.now());
  var month = DateFormat.LLLL().format(DateTime.now());
  final _weatherIconList = [
    'https://assets9.lottiefiles.com/temp/lf20_XkF78Y.json', //thunderstorm
    'https://assets9.lottiefiles.com/temp/lf20_rpC1Rd.json', //rain
    'https://assets9.lottiefiles.com/temp/lf20_BSVgyt.json', //snow
    'https://assets9.lottiefiles.com/temp/lf20_HflU56.json', //many circumstance
    'https://assets9.lottiefiles.com/temp/lf20_Stdaec.json', //clear
    'https://assets9.lottiefiles.com/temp/lf20_dgjK9i.json', //Cloudy
  ];
  var weatherIcon = ''.obs;

  var isLoading = true.obs;

  @override
  onInit() {
    super.onInit();
    getLocation();
    getConnect;
    Future.delayed(Duration(seconds: 8),(){
      guessWeather(cityValue.value);
      fetchWeather(cityValue.value);
    });
  }

  Future fetchWeather(String city) async {
    isLoading.value = true;
    try {
      var _weatherInfo =
      await WeatherService().fetchWeather(city);
      weathers.value = _weatherInfo;
      fetchWeatherIcon();
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
  Future guessWeather(String city) async {
    isLoading.value = true;
    try {
      var _sevenDaily =
      await WeatherService().guessWeather(city);
      guess.value= _sevenDaily;
    } catch (f) {
      print(f);
    }
    isLoading.value = false;
  }

  fetchWeatherIcon() async {
    var weatherId = weathers.value.id;
    if (weatherId! < 299) {
      weatherIcon.value = _weatherIconList[0];
    } else if (weatherId < 532) {
      weatherIcon.value = _weatherIconList[1];
    } else if (weatherId < 610) {
      weatherIcon.value = _weatherIconList[2];
    } else if (weatherId < 750) {
      weatherIcon.value = _weatherIconList[3];
    } else if (weatherId == 800) {
      weatherIcon.value = _weatherIconList[4];
    }else if (weatherId > 800) {
      weatherIcon.value = _weatherIconList[5];
    }
  }
  String address ='';
  getConnect() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(!result){
      return Future.error('No internet');
    }
  }
  getLocation() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Dịnh vụ định vị bị tắt');
    }
    LocationPermission position = await Geolocator.checkPermission();
    if (position == LocationPermission.denied) {
      position = await Geolocator.requestPermission();
      if (position == LocationPermission.denied) {
        return Future.error('Qyền vị trí bị từ chối');
      }
    }

    if (position == LocationPermission.deniedForever) {
      return Future.error(
          'Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền');
    }  else {
      Position currentLoc = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      getAddress(currentLoc.latitude,currentLoc.longitude);
    }
  }
  getAddress(double longitude, double latitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(longitude, latitude);
    Placemark newPlacemark = placemarks.first;
    cityValue.value=newPlacemark.administrativeArea!;
  }
}
