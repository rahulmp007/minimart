import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:minimart/src/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/app/bloc_observer.dart';
import 'package:minimart/src/app/startup/bloc/app_startup_bloc.dart';
import 'package:minimart/src/app/startup/bloc/app_startup_event.dart';
import 'package:minimart/src/core/network/connectivity/bloc/network_bloc.dart';
import 'package:minimart/src/core/service/hive_service.dart';
import 'package:minimart/src/features/auth/domain/usecases/get_current_user.dart';
import 'package:minimart/src/features/auth/domain/usecases/logout_user.dart';
import 'package:minimart/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:minimart/src/injection/service_locator.dart';

Future initializer() async {
  Bloc.observer = AppBlocObserver();
  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppStartupBloc>(
          create: (context) =>
              AppStartupBloc(hiveService: sl<HiveService>())
                ..add(InitializeApp()),
        ),
        BlocProvider(create: (context) => sl<NetworkBloc>()),
        BlocProvider(
          create: (context) => AuthBloc(
            getCurrentUser: sl<GetCurrentUser>(),
            logoutUser: sl<LogoutUser>(),
          ),
        ),
      ],
      child: MiniMart(),
    ),
  );
}
