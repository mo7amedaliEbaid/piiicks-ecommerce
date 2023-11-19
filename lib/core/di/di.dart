import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:piiicks/application/favourites_cubit/favourites_cubit.dart';
import 'package:piiicks/data/repositories/favourite_products_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/categories_bloc/category_bloc.dart';
import '../../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../application/products_bloc/product_bloc.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../data/data_sources/local/category_local_data_source.dart';
import '../../data/data_sources/local/delivery_info_local_data_source.dart';
import '../../data/data_sources/local/product_local_data_source.dart';
import '../../data/data_sources/local/user_local_data_source.dart';
import '../../data/data_sources/remote/category_remote_data_source.dart';
import '../../data/data_sources/remote/delivery_info_remote_data_source.dart';
import '../../data/data_sources/remote/product_remote_data_source.dart';
import '../../data/data_sources/remote/user_remote_data_source.dart';
import '../../data/repositories/categories_repository_impl.dart';

import '../../data/repositories/delivery_info_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/delivery_info_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/category/filter_category_usecase.dart';
import '../../domain/usecases/category/get_cached_category_usecase.dart';
import '../../domain/usecases/category/get_remote_category_usecase.dart';

import '../../domain/usecases/delivery_info/add_dilivey_info_usecase.dart';
import '../../domain/usecases/delivery_info/clear_local_delivery_info_usecase.dart';
import '../../domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import '../../domain/usecases/delivery_info/get_cached_delivery_info_usecase.dart';
import '../../domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';
import '../../domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import '../../domain/usecases/delivery_info/select_delivery_info_usecase.dart';
import '../../domain/usecases/product/get_product_usecase.dart';
import '../../domain/usecases/user/get_cached_user_usecase.dart';
import '../../domain/usecases/user/sign_in_usecase.dart';
import '../../domain/usecases/user/sign_out_usecase.dart';
import '../../domain/usecases/user/sign_up_usecase.dart';
import '../networkchecker/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
 /* sl.registerLazySingleton<FavouriteProductRepository>(
    () => FavouriteProductRepository(),
  );*/
  /*sl.registerFactory(
    () => FavouritesCubit(sl()),
  );*/
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

  sl.registerFactory(
    () => UserBloc(sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  sl.registerFactory(
    () => DeliveryInfoActionCubit(sl(), sl(), sl()),
  );
  sl.registerFactory(
    () => DeliveryInfoFetchCubit(sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetRemoteDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => AddDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => EditDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => SelectDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetSelectedDeliveryInfoInfoUseCase(sl()));
  sl.registerLazySingleton(() => ClearLocalDeliveryInfoUseCase(sl()));
  // Repository
  sl.registerLazySingleton<DeliveryInfoRepository>(
    () => DeliveryInfoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<DeliveryInfoRemoteDataSource>(
    () => DeliveryInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DeliveryInfoLocalDataSource>(
    () => DeliveryInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
