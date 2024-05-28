import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/weather_controller.dart';

class GuessPage extends StatelessWidget {
  GuessPage({Key? key}) : super(key: key);
  final c = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xffB2C9DD),
            width: 2,
          ),
          color: const Color(0xffFFFFFF).withOpacity(0.30),
        ),
        child: c.isLoading.value
            ? Center(
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                children: [
                  const Text(
                    '7 day forecast',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    if(c.guess.value.daily != null && c.guess.value.daily!.length != 0) {
                      return
                        Column(
                        children: c.guess.value.daily!.map<Widget>((e) => InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(height: 17),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(e.dt * 1000, isUtc: true))}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${(e.humidity).toStringAsFixed(0)} %',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 2,
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         '${DateFormat('Hm').format(DateTime.fromMillisecondsSinceEpoch((e.sunrise+25200)*1000, isUtc: true))}/',
                              //         style: const TextStyle(
                              //           fontSize: 18,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //       Text(
                              //         '${DateFormat('Hm').format(DateTime.fromMillisecondsSinceEpoch((e.sunset+25200)*1000, isUtc: true))}',
                              //         style: const TextStyle(
                              //           fontSize: 18,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                  child: Image.network('http://openweathermap.org/img/wn/${e.weather!.first.icon}@2x.png', width: 25)),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Text(
                                      '${(e.temp!.min - 273.15).toStringAsFixed(0)}\u00B0/',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${(e.temp!.max - 273.15).toStringAsFixed(0)}\u00B0',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      );
                    }
                    return SizedBox();
                  }),
                ],
              ));
  }
}
