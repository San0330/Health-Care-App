import 'package:dartz/dartz.dart';

import 'conditions.dart';
import '../core/failures.dart';
import 'diagnosis.dart';

abstract class IDiagnosisRepo {
  Future<Either<Failure, Diagnosis>> getDiagnosis(
    String sex,
    int age,
    List<Condition> conditions,
  );
}
