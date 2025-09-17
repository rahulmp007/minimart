// lib/features/home/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: Colors.pink,
        child: Center(
          child: BlocSelector<AuthBloc, AuthState, User?>(
            selector: (state) {
              return state is Authenticated ? state.user : null;
            },
            builder: (context, user) {
              return Text(
                "Welcome ${user?.name}, you're logged in!",
                style: const TextStyle(fontSize: 20, color: Colors.black),
              );
            },
          ),
        ),
      ),
    );
  }
}
