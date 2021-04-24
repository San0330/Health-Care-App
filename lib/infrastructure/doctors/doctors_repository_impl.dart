import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/doctors/doctors.dart';
import '../../domain/doctors/i_doctors_repo.dart';
import '../core/connection_checker.dart';
import 'doctors_remote_datasource.dart';

@LazySingleton(as: IDoctorsRepository)
class DoctorsRepositoryImpl implements IDoctorsRepository {
  final INetworkInfo networkInfo;
  final IDoctorsRemoteDatasource remoteDatasource;

  DoctorsRepositoryImpl(
    this.networkInfo,
    this.remoteDatasource,
  );

  @override
  Future<Either<Failure, Doctors>> fetchDoctors() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final doctors = await remoteDatasource.fetchDoctors();
      return right(doctors);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
