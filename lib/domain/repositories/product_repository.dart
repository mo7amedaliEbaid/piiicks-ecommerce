import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/product/filter_params_model.dart';
import '../entities/product/product_response.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponse>> getProducts(FilterProductParams params);
}