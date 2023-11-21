// Feature: Category
import '../../application/categories_bloc/category_bloc.dart';
import '../../data/data_sources/local/category_local_data_source.dart';
import '../../data/data_sources/remote/category_remote_data_source.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/category/filter_category_usecase.dart';
import '../../domain/usecases/category/get_cached_category_usecase.dart';
import '../../domain/usecases/category/get_remote_category_usecase.dart';
import 'di.dart';

void registerCategoryFeature() {
  // Category BLoC and Use Cases
  sl.registerFactory(() => CategoryBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetRemoteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterCategoryUseCase(sl()));

  // Category Repository and Data Sources
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
}