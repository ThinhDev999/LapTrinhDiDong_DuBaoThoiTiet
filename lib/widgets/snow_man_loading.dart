import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SnowManLoading extends StatelessWidget {
  const SnowManLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/snowman.json'),
    );
  }
}
