import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/diagnosis/conditions.dart';
import '../../domain/diagnosis/diagnosis.dart';
import '../../domain/diagnosis/i_diagnosis_repo.dart';
import '../core/api_constants.dart';
import '../core/connection_checker.dart';

@LazySingleton(as: IDiagnosisRepo)
class DiagnosisRepoImpl implements IDiagnosisRepo {
  final INetworkInfo networkInfoImpl;

  DiagnosisRepoImpl(this.networkInfoImpl);

  @override
  Future<Either<Failure, Diagnosis>> getDiagnosis(
    String sex,
    int age,
    List<Condition> conditions,
  ) async {
    final bool isConnected = await networkInfoImpl.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final res = await http.post(
        ApiConstants.diagnosisApiUrl,
        headers: {
          "Content-Type": "application/json",
          "App-Id": ApiConstants.diagnosisAppId,
          "App-Key": ApiConstants.diagnosisAppKey,
        },
        body: json.encode({
          "sex": sex,
          "age": age,
          "evidence": conditions.map((e) => e.toMap()).toList(),
          "extras": {"disable_groups": true}
        }),
      );

      final diagnosis =
          Diagnosis.fromJson(json.decode(res.body) as Map<String, dynamic>);
      return right(diagnosis);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
