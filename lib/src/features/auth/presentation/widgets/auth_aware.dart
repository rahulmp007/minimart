import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:minimart/src/features/auth/presentation/pages/login.dart';
import 'package:minimart/src/features/home/presentation/pages/home.dart';

class AuthAwareWidget extends StatelessWidget {
  final Widget? loadingWidget;
  final Widget? unauthenticatedWidget;
  final Widget? errorWidget;

  const AuthAwareWidget({
    super.key,
    this.loadingWidget,
    this.unauthenticatedWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _authListener,
      builder: (context, state) {
        return _buildContentBasedOnState(state);
      },
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is Authenticated) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => HomePage()));
    } else if (state is Unauthenticated) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Widget _buildContentBasedOnState(AuthState state) {
    return switch (state) {
      AuthLoading() => loadingWidget ?? _defaultLoadingWidget(),
      Authenticated() => const HomePage(),
      Unauthenticated() => unauthenticatedWidget ?? const Login(),
      AuthError() => errorWidget ?? _defaultErrorWidget(state.message),
      _ => _defaultUnknownStateWidget(),
    };
  }

  Widget _defaultLoadingWidget() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _defaultErrorWidget(String message) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Authentication Error',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Optionally add a retry mechanism
                // context.read<AuthBloc>().add(CheckAuthStatus());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultUnknownStateWidget() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.help_outline, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Unknown Authentication State',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
