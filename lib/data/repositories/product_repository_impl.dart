import 'package:dartz/dartz.dart';

import '../../domain/entities/product/product_response.dart';
import '../../domain/repositories/product_repository.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/networkchecker/network_info.dart';
import '../data_sources/local/product_local_data_source.dart';
import '../data_sources/remote/product_remote_data_source.dart';
import '../models/product/filter_params_model.dart';
import '../models/product/product_response_model.dart';

typedef _ConcreteOrProductChooser = Future<ProductResponse> Function();

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductResponse>> getProducts(
      FilterProductParams params) async {
    return await _getProduct(() {
      return remoteDataSource.getProducts(params);
    });
  }

  Future<Either<Failure, ProductResponse>> _getProduct(
    _ConcreteOrProductChooser getConcreteOrProducts,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await getConcreteOrProducts();
        localDataSource.saveProducts(remoteProducts as ProductResponseModel);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
