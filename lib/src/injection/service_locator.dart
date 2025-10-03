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
import 'package:minimart/src/features/categories/data/data_sources/category_api_source.dart';
import 'package:minimart/src/features/categories/data/data_sources/category_local_source.dart';
import 'package:minimart/src/features/categories/data/repository/category_repository_impl.dart';
import 'package:minimart/src/features/categories/domain/repository/category_repository.dart';
import 'package:minimart/src/features/categories/domain/usecases/get_categories.dart';
import 'package:minimart/src/features/products/data/data_sources/product_api_source.dart';
import 'package:minimart/src/features/products/data/repository/product_repository_impl.dart';
import 'package:minimart/src/features/products/domain/repository/product_repository.dart';
import 'package:minimart/src/features/products/domain/usecases/fetch_products.dart';

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
  sl.registerLazySingleton(
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

  /// usecases : auth
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

  /// usecases : products
  sl.registerLazySingleton<FetchProducts>(
    () => FetchProducts(productRepo: sl<ProductRepository>()),
  );

  /// repository : products
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(api: sl<ProductApiSource>()),
  );

  /// remote data source : products
  sl.registerLazySingleton<ProductApiSource>(
    () => ProductApiSource(client: sl<ApiClient>()),
  );

  /// usecases : categories
  sl.registerLazySingleton<GetCategories>(
    () => GetCategories(categoryRepository: sl<CategoryRepository>()),
  );

  /// repository : categories
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      api: sl<CategoryApiSource>(),
      localSource: sl<CategoryLocalSource>(),
    ),
  );

  /// remote data source : categories
  sl.registerLazySingleton<CategoryApiSource>(
    () => CategoryApiSource(client: sl<ApiClient>()),
  );

  /// local data source : categories
  sl.registerLazySingleton<CategoryLocalSource>(
    () => CategoryLocalSourceImpl(localStorage: sl<LocalStorageService>()),
  );
}
