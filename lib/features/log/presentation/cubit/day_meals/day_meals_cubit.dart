import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'day_meals_state.dart';

class DayMealsCubit extends Cubit<DayMealsState> {
  DayMealsCubit() : super(DayMealsInitial());
}
