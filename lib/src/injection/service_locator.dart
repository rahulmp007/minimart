import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:minimart/src/core/network/api_client.dart';
import 'package:minimart/src/core/network/connectivity/bloc/network_bloc.dart';
import 'package:minimart/src/core/network/connectivity/connectivity_service.dart';
import 'package:minimart/src/core/service/hive_service.dart';
import 'package:minimart/src/core/service/local_storage.dart';
import 'package:minimart/src/features/auth/data/data_sources/auth_api_source.dart';
import 'package:minimart/src/features/auth/data/data_sources/auth_local_source.dart';
import 'package:minimart/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:minimart/src/features/auth/domain/repository/auth_repository.dart';
import 'package:minimart/src/features/auth/domain/usecases/get_current_user.dart';
import 'package:minimart/src/features/auth/domain/usecases/login_user.dart';
import 'package:minimart/src/features/auth/domain/usecases/logout_user.dart';
import 'package:minimart/src/features/auth/domain/usecases/signup_user.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(
      checker: sl<InternetConnectionChecker>(),
      connectivity: sl<Connectivity>(),
    ),
  );
  sl.registerFactory(
    () => NetworkBloc(connectivityService: sl<ConnectivityService>()),
  );

  /// api client
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  /// local storage
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());

  /// hive services
  sl.registerLazySingleton<HiveService>(() => HiveService());

  /// sources
  sl.registerLazySingleton<AuthApiService>(
    () => AuthApiService(client: sl<ApiClient>(), baseUrl: ''),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(localStorage: sl<LocalStorageService>()),
  );

  /// repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      api: sl<AuthApiService>(),
      local: sl<AuthLocalDataSource>(),
    ),
  );

  /// usecases
  sl.registerLazySingleton<LoginUser>(
    () => LoginUser(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignupUser>(
    () => SignupUser(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUser>(
    () => LogoutUser(repository: sl<AuthRepository>()),
  );
}
