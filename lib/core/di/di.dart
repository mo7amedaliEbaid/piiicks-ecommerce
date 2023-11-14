import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/categories_bloc/category_bloc.dart';
import '../../application/products_bloc/product_bloc.dart';
import '../../data/data_sources/local/category_local_data_source.dart';
import '../../data/data_sources/local/product_local_data_source.dart';
import '../../data/data_sources/remote/category_remote_data_source.dart';
import '../../data/data_sources/remote/product_remote_data_source.dart';
import '../../data/repositories/categories_repository_impl.dart';

import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/category/filter_category_usecase.dart';
import '../../domain/usecases/category/get_cached_category_usecase.dart';
import '../../domain/usecases/category/get_remote_category_usecase.dart';

import '../../domain/usecases/product/get_product_usecase.dart';
import '../networkchecker/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => CategoryBloc(sl(), sl(), sl()),
  );
  sl.registerLazySingleton(() => GetRemoteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterCategoryUseCase(sl()));
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerFactory(
    () => ProductBloc(sl()),
  );
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
