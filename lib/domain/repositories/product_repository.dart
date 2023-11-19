import 'package:dartz/dartz.dart';
import 'package:piiicks/domain/entities/product/product.dart';

import '../../core/error/failures.dart';
import '../../data/models/product/filter_params_model.dart';
import '../entities/product/product_response.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponse>> getProducts(FilterProductParams params);

/*  // Database methods
  Future < List < Product >> getBookmarks();

  Future < void > saveExercise(Product exercise);

  Future < void > removeExercise(Product exercise);*/
}