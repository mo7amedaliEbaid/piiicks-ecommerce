import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

import '../../../data/models/delivery/delivery_info_model.dart';
import '../../entities/delivery/delivery_info.dart';
import '../../repositories/delivery_info_repository.dart';

class EditDeliveryInfoUseCase implements UseCase<DeliveryInfo, DeliveryInfoModel> {
  final DeliveryInfoRepository repository;
  EditDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfoModel params) async {
    return await repository.editDeliveryInfo(params);
  }
}
