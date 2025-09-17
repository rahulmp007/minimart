
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/signup/signup_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/signup/signup_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            // Notify AuthBloc to update global state
            context.read<AuthBloc>().add(CheckAuthStatus());
            Navigator.pop(context); // go back to login page or home
          } else if (state is SignupFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordCtrl,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  if (state is SignupLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<SignupBloc>().add(
                        SignupRequested(
                          name: nameCtrl.text,
                          email: emailCtrl.text,
                          password: passwordCtrl.text,
                        ),
                      );
                    },
                    child: const Text("Sign Up"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
