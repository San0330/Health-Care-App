import 'package:dartz/dartz.dart';
import 'package:pharma_app2/domain/core/failures.dart';

import 'doctors.dart';

abstract class IDoctorsRepository {
  Future<Either<Failure, Doctors>> fetchDoctors();
}
