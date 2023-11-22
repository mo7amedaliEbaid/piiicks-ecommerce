// Feature: Cart
import '../application/cart_bloc/cart_bloc.dart';
import '../application/categories_bloc/category_bloc.dart';
import '../data/data_sources/local/cart_local_data_source.dart';
import '../data/data_sources/local/category_local_data_source.dart';
import '../data/data_sources/remote/cart_remote_data_source.dart';
import '../data/data_sources/remote/category_remote_data_source.dart';
import '../data/repositories/cart_repository_impl.dart';
import '../data/repositories/categories_repository_impl.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/repositories/category_repository.dart';
import '../domain/usecases/cart/add_cart_item_usecase.dart';
import '../domain/usecases/cart/clear_cart_usecase.dart';
import '../domain/usecases/cart/get_cached_cart_usecase.dart';
import '../domain/usecases/cart/sync_cart_usecase.dart';
import '../domain/usecases/category/filter_category_usecase.dart';
import '../domain/usecases/category/get_cached_category_usecase.dart';
import '../domain/usecases/category/get_remote_category_usecase.dart';
import 'di.dart';

void registerCartFeature() {
  // Cart BLoC and Use Cases
  sl.registerFactory(
        () => CartBloc(sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedCartUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));
  sl.registerLazySingleton(() => SyncCartUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<CartRemoteDataSource>(
        () => CartRemoteDataSourceSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
        () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

}