// Feature: DeliveryInfo
import '../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../data/data_sources/local/delivery_info_local_data_source.dart';
import '../data/data_sources/remote/delivery_info_remote_data_source.dart';
import '../data/repositories/delivery_info_impl.dart';
import '../domain/repositories/delivery_info_repository.dart';
import '../domain/usecases/delivery_info/add_dilivey_info_usecase.dart';
import '../domain/usecases/delivery_info/clear_local_delivery_info_usecase.dart';
import '../domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import '../domain/usecases/delivery_info/get_cached_delivery_info_usecase.dart';
import '../domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';
import '../domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import '../domain/usecases/delivery_info/select_delivery_info_usecase.dart';
import 'di.dart';

void registerDeliveryInfoFeature() {
  // DeliveryInfo BLoC and Use Cases
  sl.registerFactory(() => DeliveryInfoActionCubit(sl(), sl(), sl()));
  sl.registerFactory(() => DeliveryInfoFetchCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetRemoteDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => AddDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => EditDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => SelectDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetSelectedDeliveryInfoInfoUseCase(sl()));
  sl.registerLazySingleton(() => ClearLocalDeliveryInfoUseCase(sl()));

  // DeliveryInfo Repository and Data Sources
  sl.registerLazySingleton<DeliveryInfoRepository>(
        () => DeliveryInfoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<DeliveryInfoRemoteDataSource>(
        () => DeliveryInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DeliveryInfoLocalDataSource>(
        () => DeliveryInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );
}