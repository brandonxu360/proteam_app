import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

// Cubit to primary handle user data (profile data, etc)
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
}
