import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

class FoodListTile extends StatelessWidget {
  final FoodEntity food;

  const FoodListTile({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteConst.logFoodPage, arguments: food);
        },
        child: ListTile(
          tileColor: boneColor,
          textColor: blackColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(food.name),
            (food.brand != null)
                ? Text(
                    food.brand!,
                    style: const TextStyle(
                        fontSize: 12, fontStyle: FontStyle.italic),
                  )
                : const SizedBox(),
          ]),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${food.servingSize} ${food.servingSizeUnit}, '),
              Text('${food.calories} cals'),
            ],
          ),
          trailing: const Icon(FontAwesomeIcons.plus, color: raisinBlackColor),
        ),
      ),
    );
  }
}
