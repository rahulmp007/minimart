import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/domain/usecases/get_current_user.dart';
import 'package:minimart/src/features/auth/domain/usecases/logout_user.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;

  AuthBloc({required this.getCurrentUser, required this.logoutUser})
    : super(AuthInitial()) {
    on<LogoutRequested>(onLogout);
    on<CheckAuthStatus>(onCheckAuthStatus);
  }

  void onLogout(LogoutRequested event, emit) async {
    await logoutUser();
    emit(Unauthenticated());
  }

  void onCheckAuthStatus(CheckAuthStatus event, emit) async {
    emit(AuthLoading());

    final result = await getCurrentUser();

    result.fold((failure) => emit(Unauthenticated()), (user) {
      return user != null
          ? emit(Authenticated(user: user))
          : emit(Unauthenticated());
    });
  }
}
