import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'controller.dart';
class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final s = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15),
          color: Colors.white,
        ),
        margin:const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Row(
          children: [
           const Icon(
              Icons.search_outlined,
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: TextFormField(
                controller: s.cityText,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  s.handleSearchCity(context);
                },
                style: TextStyle(color: Colors.black, fontSize: 24),
                decoration: InputDecoration(
                  hintText: 'Search City',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 24),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
