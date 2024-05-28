import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({Key? key, this.title, required this.icon}) : super(key: key);
  final String? title ;
  final IconData icon ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            title?? '',
            style:const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
