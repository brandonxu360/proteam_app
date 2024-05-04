import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/const/meal_const.dart';
import 'package:proteam_app/core/services/main_injection_container.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/utils/form_validation_helpers.dart';
import 'package:proteam_app/core/widgets/snackbar_widget.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/log/presentation/cubit/food_log/food_log_cubit.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';

// Page to stage and log food entries
class LogFoodPage extends StatefulWidget {
  final FoodEntity food;

  const LogFoodPage({required this.food, super.key});

  @override
  State<LogFoodPage> createState() => _LogFoodPageState();
}

class _LogFoodPageState extends State<LogFoodPage> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  late TextEditingController _servingSizeController;
  late TextEditingController _quantityController;
  late TextEditingController _mealController;

  // Fields for staging the new food entry
  late double _actualCalories;
  late double _actualCarbs;
  late double _actualProtein;
  late double _actualFat;

  final String _initialMealValue = 'Select a Meal';

  @override
  void initState() {
    // Initialize the textfields to their initial values
    _servingSizeController =
        TextEditingController(text: '1 ${widget.food.servingSizeUnit}');
    _quantityController =
        TextEditingController(text: '${widget.food.servingSize}');
    _mealController = TextEditingController(text: _initialMealValue);

    // Initialize the food entry nutrition
    _actualCalories = widget.food.calories;
    _actualCarbs = widget.food.carbs;
    _actualProtein = widget.food.protein;
    _actualFat = widget.food.fat;

    super.initState();
  }

  @override
  void dispose() {
    _servingSizeController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodLogCubit(logFoodUseCase: sl.call()),
      child: Builder(builder: (context) {
        return Scaffold(
            // App bar
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Log Food', style: Styles.headline1),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: BlocConsumer<FoodLogCubit, FoodLogState>(
                    listener: (context, state) {
                      // If the food was logged successfully
                      if (state is FoodLogSuccess) {
                        // Navigate back to the home page
                        Navigator.popUntil(
                            context, (route) => route.isFirst);

                        // Inform the user that the food was logged
                        snackBar(context, 'Successfully logged food');
                      }

                      if (state is FoodLogFailure) {
                        snackBar(
                            context, 'Logging food failed, please try again');
                      }
                    },
                    builder: (context, state) {
                      if (state is FoodLogInProgress) {
                        return const CircularProgressIndicator();
                      }
                      return IconButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Get the user id if the user is logged in
                              final authState =
                                  BlocProvider.of<AuthCubit>(context).state;

                              if (authState is Authenticated) {
                                // Attempt to log the food
                                BlocProvider.of<FoodLogCubit>(context).logFood(
                                    widget.food,
                                    double.parse(_quantityController.text),
                                    _mealController.text,
                                    DateTime.now(),
                                    authState.uid);
                              }
                            }
                          },
                          icon: const Icon(Icons.check));
                    },
                  ),
                )
              ],
              backgroundColor: raisinBlackColor,
              surfaceTintColor: raisinBlackColor,
            ),
            body:

                // Main view of food
                ListView(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              children: [
                Text(widget.food.name, style: Styles.title1),
                (widget.food.brand != null)
                    ? Text(
                        widget.food.brand!,
                        style: Styles.subtitle1,
                      )
                    : const SizedBox(),
                const Divider(),

                // Form fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Serving Size'),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: TextFormField(
                                textAlign: TextAlign.end,
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: blackColor,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Wrap(children: [
                                            ListTile(
                                                title: const Text('1 g'),
                                                onTap: () {
                                                  // Close the bottom sheet and set the meal to breakfast
                                                  _servingSizeController.text =
                                                      '1 g';
                                                  MealConst.breakfast;
                                                  Navigator.pop(context);
                                                }),
                                          ]),
                                        );
                                      });
                                },
                                controller: _servingSizeController,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Number of Servings'),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: TextFormField(
                                validator: (value) {
                                  // Check if the value is empty
                                  if (!positiveDoubleCheck(value)) {
                                    return 'Invalid quantity, try again';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.end,
                                onChanged: (value) {
                                  // Update the staged attributes
                                  setState(() {
                                    _actualCalories = double.parse(((double.parse(
                                                _quantityController.text) /
                                            widget.food.servingSize) *
                                        widget.food.calories).toStringAsFixed(2));
                                    _actualProtein = double.parse(((double.parse(
                                                _quantityController.text) /
                                            widget.food.servingSize) *
                                        widget.food.protein).toStringAsFixed(2));
                                    _actualCarbs = double.parse(((double.parse(
                                                _quantityController.text) /
                                            widget.food.servingSize) *
                                        widget.food.carbs).toStringAsFixed(2));
                                    _actualFat = double.parse(((double.parse(
                                                _quantityController.text) /
                                            widget.food.servingSize) *
                                        widget.food.fat).toStringAsFixed(2));
                                  });
                                },
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Meal'),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: TextFormField(
                                validator: (value) {
                                  // Check that the user has selected a meal
                                  if (value == _initialMealValue) {
                                    return 'Please select a meal';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                textAlign: TextAlign.end,
                                onChanged: (value) {},
                                controller: _mealController,
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: blackColor,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Wrap(children: [
                                            ListTile(
                                                title: const Text(
                                                    MealConst.breakfast),
                                                onTap: () {
                                                  // Close the bottom sheet and set the meal to breakfast
                                                  _mealController.text =
                                                      MealConst.breakfast;
                                                  Navigator.pop(context);
                                                }),
                                            const Divider(height: 0),
                                            ListTile(
                                                title:
                                                    const Text(MealConst.lunch),
                                                onTap: () {
                                                  // Close the bottom sheet and set the meal to lunch
                                                  _mealController.text =
                                                      MealConst.lunch;
                                                  Navigator.pop(context);
                                                }),
                                            const Divider(height: 0),
                                            ListTile(
                                                title: const Text(
                                                    MealConst.dinner),
                                                onTap: () {
                                                  // Close the bottom sheet and set the meal to dinner
                                                  _mealController.text =
                                                      MealConst.dinner;
                                                  Navigator.pop(context);
                                                }),
                                          ]),
                                        );
                                      });
                                },
                              ))
                        ],
                      ),
                    ],
                  ),
                ),

                // Nutrition Statistics
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        children: [
                          Text('$_actualCalories g', style: Styles.bodyText1),
                          const Text('Cal'),
                          const Divider(color: Colors.red)
                        ],
                      ),
                    ),
                    const Flexible(flex: 1, child: SizedBox()),
                    Flexible(
                      flex: 4,
                      child: Column(
                        children: [
                          Text('$_actualCarbs g', style: Styles.bodyText1),
                          const Text('Carbs'),
                          const Divider(color: Colors.teal)
                        ],
                      ),
                    ),
                    const Flexible(flex: 1, child: SizedBox()),
                    Flexible(
                      flex: 4,
                      child: Column(
                        children: [
                          Text('$_actualProtein g', style: Styles.bodyText1),
                          const Text('Protein'),
                          const Divider(color: Colors.amber)
                        ],
                      ),
                    ),
                    const Flexible(flex: 1, child: SizedBox()),
                    Flexible(
                      flex: 4,
                      child: Column(
                        children: [
                          Text('$_actualFat g', style: Styles.bodyText1),
                          const Text('Fat'),
                          const Divider(color: Colors.purple)
                        ],
                      ),
                    )
                  ],
                ),

                // Nutrition chart
                AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(PieChartData(centerSpaceRadius: 0, sections: [
                    // Carbs
                    PieChartSectionData(
                      radius: 90,
                      title:
                          '${(_actualCarbs / (_actualProtein + _actualCarbs + _actualFat) * 100).toStringAsFixed(1)}%',
                      value: _actualCarbs,
                      color: Colors.teal,
                      titlePositionPercentageOffset: .6,
                      titleStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),

                    // Protein
                    PieChartSectionData(
                      radius: 90,
                      title:
                          '${(_actualProtein / (_actualProtein + _actualCarbs + _actualFat) * 100).toStringAsFixed(1)}%',
                      value: _actualProtein,
                      color: Colors.amber,
                      titlePositionPercentageOffset: .6,
                      titleStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),

                    // Fat
                    PieChartSectionData(
                      radius: 90,
                      title:
                          '${(_actualFat / (_actualProtein + _actualCarbs + _actualFat) * 100).toStringAsFixed(1)}%',
                      value: _actualFat,
                      color: Colors.purple,
                      titlePositionPercentageOffset: .6,
                      titleStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 8.0,
                            color: blackColor,
                          ),
                        ],
                      ),
                    )
                  ])),
                )
              ],
            ));
      }),
    );
  }
}
