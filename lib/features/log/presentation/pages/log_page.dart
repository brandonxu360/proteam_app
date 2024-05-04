import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/const/meal_const.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/utils/date_helpers.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';
import 'package:proteam_app/features/log/presentation/cubit/day_log/day_log_cubit.dart';

// Main page to display the overview of the food logs
class LogPage extends StatefulWidget {
  final String uid;
  const LogPage({super.key, required this.uid});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  int _currentIndex = dayOfYear(DateTime.now());
  DateTime _selectedDate = DateTime.now(); // Store the selected date

  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: 365,
        itemBuilder: (context, index, realIndex) {
          return FutureBuilder(
            future: BlocProvider.of<DayLogCubit>(context)
                .getMealsInDay(formatDateMDY(_selectedDate), widget.uid),
            builder: (context, snapshot) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 150, left: 20, right: 20, bottom: 50),
                  child: BlocBuilder<DayLogCubit, DayLogState>(
                    builder: (context, state) {
                      if (state is DayLogGetMealsInProgress) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is DayLogGetMealsSuccess) {
                        final breakfast = state.meals.firstWhere(
                            (meal) => meal.mealType == MealConst.breakfast,
                            orElse: () => MealEntryEntity(
                                foodEntries: [],
                                mealType: MealConst.breakfast));
                        final lunch = state.meals.firstWhere(
                            (meal) => meal.mealType == MealConst.lunch,
                            orElse: () => MealEntryEntity(
                                foodEntries: [], mealType: MealConst.lunch));
                        final dinner = state.meals.firstWhere(
                            (meal) => meal.mealType == MealConst.dinner,
                            orElse: () => MealEntryEntity(
                                foodEntries: [], mealType: MealConst.dinner));
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Breakfast', style: Styles.title2),
                                  (breakfast.foodEntries.isEmpty)
                                      ? const Text('No foods')
                                      : Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                breakfast.foodEntries.length,
                                            itemBuilder: (context, index) {
                                              return Text(breakfast
                                                  .foodEntries[index].name);
                                            },
                                          ),
                                        )
                                ],
                              ),
                            ),
                            // Content for breakfast
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Lunch', style: Styles.title2),
                                  (lunch.foodEntries.isEmpty)
                                      ? const Text('No foods')
                                      : Expanded(
                                          child: ListView.builder(
                                            itemCount: lunch.foodEntries.length,
                                            itemBuilder: (context, index) {
                                              return Text(lunch
                                                  .foodEntries[index].name);
                                            },
                                          ),
                                        )
                                ],
                              ),
                            ),
                            // Content for lunch
                            const Text('Dinner', style: Styles.title2),
                            (breakfast.foodEntries.isEmpty)
                                ? const Text('No foods')
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: dinner.foodEntries.length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                            dinner.foodEntries[index].name);
                                      },
                                    ),
                                  )
                            // Content for dinner
                          ],
                        );
                      } else {
                        return const Expanded(
                          child: Column(
                            children: [
                              Text('Failure'),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
        options: CarouselOptions(
          initialPage: _currentIndex,
          height: MediaQuery.of(context).size.height,
          enlargeCenterPage: true,
          autoPlay: false,
          onPageChanged: (index, reason) {
            setState(() {
              // Update the date
              final int difference = index - _currentIndex;

              if (difference > 0) {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
              } else if (difference < 0) {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              }

              // Update the index
              _currentIndex = index;
            });
          },
        ),
      ),
      Positioned(
        top: 60,
        left: MediaQuery.of(context).size.width * 0.25,
        right: MediaQuery.of(context).size.width * 0.25,
        child: Container(
          height: 50,
          color: Colors.white.withOpacity(0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: blackColor),
                onPressed: () {
                  _carouselController.previousPage();
                },
              ),
              Text(formatDateMDY(_selectedDate),
                  style: const TextStyle(color: blackColor)),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: blackColor),
                onPressed: () {
                  _carouselController.nextPage();
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
