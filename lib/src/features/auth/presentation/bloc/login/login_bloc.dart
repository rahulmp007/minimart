import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/domain/usecases/login_user.dart';
import 'package:minimart/src/features/auth/domain/value_objects/email_address.dart';
import 'package:minimart/src/features/auth/domain/value_objects/password.dart';
import 'package:minimart/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc({required this.loginUser}) : super(LoginState()) {
    on<EmailChanged>(onEmailChanged);
    on<PasswordChanged>(onPasswordChanged);
    on<LoginRequested>(onLogin);
  }

  FutureOr<void> onLogin(LoginRequested event, emit) async {
    final prevState = state;
    log('prev state : $state');
    if (!state.isEmailValid || !state.isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Please make sure form is valid',
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null, user: null));

    final result = await loginUser(
      email: state.email?.value.getOrElse(() => "") ?? "",
      password: state.password?.value.getOrElse(() => "") ?? "",
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isSubmitting: false, errorMessage: failure.message),
      ),
      (user) {
        emit(state.copyWith(isSubmitting: false, user: user, clearError: true));
        emit(LoginState.initial());
      },
    );
    log(
      'prevState == state :  prev  $prevState   current $state ${prevState == state}',
    );
  }

  onPasswordChanged(PasswordChanged event, emit) {
    Password password = Password.create(input: event.password);
    final passwordChanged = state.copyWith(
      password: password,
      errorMessage: null,
    );
    log('passwordChanged : $passwordChanged');
    emit(passwordChanged);
  }

  FutureOr<void> onEmailChanged(EmailChanged event, emit) async {
    EmailAddress emailAddress = EmailAddress.create(input: event.email);
    final emailChanged = state.copyWith(
      email: emailAddress,
      errorMessage: null,
    );
    log('emailChanged : $emailChanged');
    emit(emailChanged);
  }
}
