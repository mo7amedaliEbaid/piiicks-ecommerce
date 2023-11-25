//Features - Order

import '../application/order_add_cubit/order_add_cubit.dart';
import '../application/order_fetch_cubit/order_fetch_cubit.dart';
import '../data/data_sources/local/order_local_data_source.dart';
import '../data/data_sources/remote/order_remote_data_source.dart';
import '../data/repositories/order_repository_impl.dart';
import '../domain/repositories/order_repository.dart';
import '../domain/usecases/order/add_order_usecase.dart';
import '../domain/usecases/order/clear_local_order_usecase.dart';
import '../domain/usecases/order/get_cached_orders_usecase.dart';
import '../domain/usecases/order/get_remote_orders_usecase.dart';
import 'di.dart';

void registerOrderFeature() {
  // Bloc
  sl.registerFactory(
        () => OrderAddCubit(sl()),
  );
  sl.registerFactory(
        () => OrderFetchCubit(sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => AddOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetRemoteOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedOrdersUseCase(sl()));
  sl.registerLazySingleton(() => ClearLocalOrdersUseCase(sl()));
  // Repository
  sl.registerLazySingleton<OrderRepository>(
        () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSourceSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
        () => OrderLocalDataSourceImpl(sharedPreferences: sl()),
  );

}