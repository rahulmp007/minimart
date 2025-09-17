import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/domain/usecases/signup_user.dart';
import 'package:minimart/src/features/auth/presentation/bloc/signup/signup_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUser signupUser;

  SignupBloc({required this.signupUser}) : super(SignupState()) {
    on<SignupRequested>(onSignUp);

    on<TogglePasswordVisibility>(onTogglePasswordVisibility);
  }

  FutureOr<void> onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copywith(showPassword: !state.isPasswordVisible));
  }

  FutureOr<void> onSignUp(
    SignupRequested event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupState(isSubmitting: true));
    final result = await signupUser(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(SignupState(isSubmitting: false)),
      (user) => emit(SignupState(isSubmitting: false)),
    );
  }
}
