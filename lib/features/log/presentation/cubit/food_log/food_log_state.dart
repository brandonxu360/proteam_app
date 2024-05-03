part of 'foodlog_cubit.dart';

sealed class FoodlogState extends Equatable {
  const FoodlogState();

  @override
  List<Object> get props => [];
}

final class FoodlogInitial extends FoodlogState {}
