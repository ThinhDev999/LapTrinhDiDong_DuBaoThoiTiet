import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:weather_app/controllers/weather_controller.dart';

class WeatherIcon extends StatelessWidget {
  WeatherIcon({Key? key}) : super(key: key);
  final c = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        height: 150,
        child: SimpleShadow(
          opacity: 0.20,
          color: Colors.black,
          offset: Offset(3, 10),
          sigma: 30,
          child: c.isLoading.value
              ? Center(
                  child:const SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : (c.weatherIcon.value != ''
                  ? LottieBuilder.network(
                      c.weatherIcon.value,
                      fit: BoxFit.cover,
                      width: 200,
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }
}
