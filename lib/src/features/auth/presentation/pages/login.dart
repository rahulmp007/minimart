import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/auth/application/validators/auth_validators.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:minimart/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:minimart/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:minimart/src/features/auth/presentation/pages/signup.dart';
import 'package:minimart/src/features/home/presentation/pages/home.dart';
import 'package:minimart/src/injection/service_locator.dart';

import '../../domain/usecases/login_user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)], // Purple → Blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: BlocProvider(
                      create: (context) =>
                          LoginBloc(loginUser: sl<LoginUser>()),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Welcome Back 👋",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Email field
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return TextField(
                                onChanged: (value) {
                                  context.read<LoginBloc>().add(
                                    EmailChanged(email: value),
                                  );
                                },
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  errorText: mapEmailError(state.email),
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          // Password field
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return TextField(
                                onChanged: (value) {
                                  context.read<LoginBloc>().add(
                                    PasswordChanged(password: value),
                                  );
                                },
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  errorText: mapPasswordError(state.password),
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                obscureText: true,
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          // Login button
                          const SizedBox(height: 16),

                          BlocListener<LoginBloc, LoginState>(
                            listenWhen: (previous, current) =>
                                previous.user != current.user,
                            listener: (context, state) {
                              if (state.user != null) {
                                context.read<AuthBloc>().add(CheckAuthStatus());

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } else if (state.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${state.errorMessage}'),
                                  ),
                                );
                              }
                            },
                            child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: state.canSubmit
                                      ? () {
                                          FocusScope.of(context).unfocus();
                                          context.read<LoginBloc>().add(
                                            LoginRequested(
                                              email:
                                                  state.email?.value.getOrElse(
                                                    () => "",
                                                  ) ??
                                                  "",
                                              password:
                                                  state.password?.value
                                                      .getOrElse(() => "") ??
                                                  "",
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Container(
                                    width: constraints.maxWidth,

                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: state.isSubmitting
                                          ? Transform.scale(
                                              scale: 0.5,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'Login',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: Text("Don't have an account? "),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
