import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/utils/date_helpers.dart';
import 'package:proteam_app/features/log/presentation/cubit/day_meals/day_log_cubit.dart';

class DayLogView extends StatefulWidget {
  const DayLogView({super.key});

  @override
  State<DayLogView> createState() => _DayLogViewState();
}

class _DayLogViewState extends State<DayLogView> {
  int _currentIndex = dayOfYear(DateTime.now());
  DateTime _selectedDate = DateTime.now(); // Store the selected date

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BlocBuilder<DayLogCubit, DayLogState>(
        builder: (context, state) {
          return CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: 365,
            itemBuilder: (context, index, realIndex) {
              return Text('$index');
            },
            options: CarouselOptions(
              initialPage: _currentIndex,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  // Update the date
                  final int difference = index - _currentIndex;

                  if (difference > 0) {
                    _selectedDate = _selectedDate.add(const Duration(days: 1));
                  } else if (difference < 0) {
                    _selectedDate =
                        _selectedDate.subtract(const Duration(days: 1));
                  }

                  // Update the index
                  _currentIndex = index;
                });
              },
            ),
          );
        },
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
