import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/domain/usecases/signup_user.dart';
import 'package:minimart/src/features/auth/presentation/bloc/signup/signup_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUser signupUser;

  SignupBloc({required this.signupUser}) : super(SignupInitial()) {
    on<SignupRequested>((event, emit) async {
      emit(SignupLoading());
      final result = await signupUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) => emit(SignupFailure(message: failure.message)),
        (user) => emit(SignupSuccess(user: user)),
      );
    });
  }
}
