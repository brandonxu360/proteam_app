import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

class LogFoodPage extends StatelessWidget {
  final FoodEntity food;

  const LogFoodPage({required this.food, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // App bar
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: const Text('Log Food', style: Styles.headline1),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
            )
          ],
          backgroundColor: raisinBlackColor,
          surfaceTintColor: raisinBlackColor,
        ),
        body: Center(child: Text(food.name)));
  }
}
