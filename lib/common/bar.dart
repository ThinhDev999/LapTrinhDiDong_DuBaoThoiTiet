import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  const Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        '|',
        style: const TextStyle(
          fontSize: 21,
          color: Colors.white,
        ),
      ),
    );
  }
}
