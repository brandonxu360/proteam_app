part of 'day_log_cubit.dart';

sealed class DayLogState extends Equatable {
  const DayLogState();

  @override
  List<Object> get props => [];
}

final class DayLogInitial extends DayLogState {}
