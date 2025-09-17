import 'package:equatable/equatable.dart';
import 'package:minimart/src/features/auth/domain/value_objects/email_address.dart';
import 'package:minimart/src/features/auth/domain/value_objects/password.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';

class LoginState extends Equatable {
  final EmailAddress? email;
  final Password? password;
  final bool isSubmitting;
  final User? user;
  final String? errorMessage;

  const LoginState({
    this.email,
    this.password,
    this.isSubmitting = false,
    this.user,
    this.errorMessage,
  });

  bool get isEmailValid => email?.isValid ?? false;
  bool get isPasswordValid => password?.isValid ?? false;
  bool get canSubmit => isEmailValid && isPasswordValid && !isSubmitting;

  LoginState copyWith({
    EmailAddress? email,
    Password? password,
    bool? isSubmitting,
    User? user,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      user: user ?? this.user,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  factory LoginState.initial() {
    return LoginState(
      email: null,
      password: null,
      isSubmitting: false,
      user: null,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isSubmitting,
    user,
    errorMessage,
  ];

  @override
  bool get stringify => true;
}
