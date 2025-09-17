// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginEvent {}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password});
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email});
}
