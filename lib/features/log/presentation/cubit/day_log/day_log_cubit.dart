import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';
import 'package:proteam_app/features/log/domain/use_cases/get_day_food_usecase.dart';

part 'day_log_state.dart';

class DayLogCubit extends Cubit<DayLogState> {
  final GetMealsInDayUseCase getMealsInDayUseCase;

  DayLogCubit({required this.getMealsInDayUseCase}) : super(DayLogInitial());

  Future<void> getMealsInDay(String date, String uid) async {
    emit(DayLogGetMealsInProgress());

    final result = await getMealsInDayUseCase.call(date, uid);

    result.fold((l) => emit(DayLogGetMealsFailure()),
        (r) => emit(DayLogGetMealsSuccess(meals: r)));
  }
}
