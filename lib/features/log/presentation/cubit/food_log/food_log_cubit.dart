import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'foodlog_state.dart';

class FoodlogCubit extends Cubit<FoodlogState> {
  FoodlogCubit() : super(FoodlogInitial());
}
