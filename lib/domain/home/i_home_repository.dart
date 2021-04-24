import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import 'home_model.dart';

abstract class IHomeRepository {
  Future<Either<Failure, HomeModel>> getFeatureProductsWithAppointCount();
}
