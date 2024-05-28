import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/common/bar.dart';
import 'package:weather_app/common/label.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/pages/guess/guess.dart';
import 'package:weather_app/pages/search/search.dart';
import 'package:weather_app/pages/weathericon/weathericon.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({Key? key}) : super(key: key);
  final c = Get.put(WeatherController());

  @override
  // void initState() {
  //   _getConnect();
  //   super.initState();
  // }
  //
  // _getConnect() async {
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   if(!result){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('No internet')
  //     ));
  //   }
  // }
  //
  // @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(0, 29, 177, 1.0),
                    Color.fromRGBO(133, 216, 236, 1.0),
                  ],
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 60),
                  WeatherIcon(),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
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
                              Text(
                                'Today: ${c.day} ${c.month}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${(c.weathers.value.main!.temp - 273.15).toStringAsFixed(0)}\u00B0',
                                style: const TextStyle(
                                  fontSize: 90,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${c.weathers.value.weather!.first.description}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                          icon: Icons.flag_outlined,
                                          title: 'Country'),
                                      const SizedBox(height: 15),
                                      Label(
                                          icon: Icons.location_on_outlined,
                                          title: 'City'),
                                      const SizedBox(height: 15),
                                      Label(icon: Icons.air, title: 'Wind'),
                                      const SizedBox(height: 15),
                                      Label(
                                          icon: Icons.water_damage_outlined,
                                          title: 'Humidity'),
                                      const SizedBox(height: 15),
                                      Label(
                                          icon: Icons.arrow_upward_rounded,
                                          title: 'Pressure'),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Bar(),
                                      const SizedBox(height: 13),
                                      Bar(),
                                      const SizedBox(height: 13),
                                      Bar(),
                                      const SizedBox(height: 13),
                                      Bar(),
                                      const SizedBox(height: 13),
                                      Bar(),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${c.weathers.value.sys?.country}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 17),
                                      Text(
                                        '${c.weathers.value.name}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 17),
                                      Text(
                                        '${c.weathers.value.wind?.speed} m/s',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 17),
                                      Text(
                                        '${c.weathers.value.main!.humidity} %',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 17),
                                      Text(
                                        '${c.weathers.value.main!.pressure} PA',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 20),
                  GuessPage(),
                ],
              ),
            ),
            SafeArea(child: SearchPage()),
          ],
        ),
      ),
    );
  }
}
