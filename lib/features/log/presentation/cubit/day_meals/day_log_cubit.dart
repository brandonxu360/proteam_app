import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/log/domain/use_cases/get_day_food_usecase.dart';

part 'day_log_state.dart';

class DayLogCubit extends Cubit<DayLogState> {
  final GetMealsInDayUseCase getDayFoodUseCase;

  DayLogCubit({required this.getDayFoodUseCase}) : super(DayLogInitial());
}
