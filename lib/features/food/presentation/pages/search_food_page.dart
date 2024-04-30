import 'package:flutter/material.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';

class SearchFoodPage extends StatefulWidget {
  const SearchFoodPage({super.key});

  @override
  State<SearchFoodPage> createState() => _SearchFoodPageState();
}

class _SearchFoodPageState extends State<SearchFoodPage> {
  String textFieldValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: raisinBlackColor,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.transparent.withOpacity(0.1),
          elevation: 0,
          title: const Text('Log Food', style: Styles.headline1),
          backgroundColor: raisinBlackColor,
        ),
        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchBar(
                
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 14)),
                hintText: 'Search for a food',
                autoFocus: true,
                elevation: MaterialStatePropertyAll(0),
                leading: Icon(Icons.search_rounded),
                backgroundColor: MaterialStatePropertyAll(blackColor),
              ),
            )
          ],
        ));
  }
}
