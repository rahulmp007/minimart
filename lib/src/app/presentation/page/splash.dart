
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/app/startup/bloc/app_startup_bloc.dart';
import 'package:minimart/src/app/startup/bloc/app_startup_state.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:minimart/src/features/auth/presentation/widgets/auth_aware.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppStartupBloc, AppStartupState>(
        listener: (context, state) {
          if (state is AppStartupSuccess) {
            context.read<AuthBloc>().add(CheckAuthStatus());

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AuthAwareWidget()),
            );
          } else if (state is AppStartupFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Startup failed')));
          }
        },
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
