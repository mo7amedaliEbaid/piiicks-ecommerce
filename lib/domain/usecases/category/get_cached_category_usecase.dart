import 'package:dartz/dartz.dart';


import '../../../shared/error/failures.dart';
import '../../../shared/usecases/usecase.dart';
import '../../entities/category/category.dart';
import '../../repositories/category_repository.dart';

class GetCachedCategoryUseCase implements UseCase<List<Category>, NoParams> {
  final CategoryRepository repository;
  GetCachedCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getCachedCategories();
  }
}
