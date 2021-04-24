import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/appointment/appointments.dart';
import '../../domain/appointment/i_appointment_repo.dart';
import '../../domain/core/failures.dart';
import '../core/connection_checker.dart';
import 'appointment_remote_datasource.dart';

@LazySingleton(as: IAppointmentRepository)
class AppointmentRepository implements IAppointmentRepository {
  final INetworkInfo networkInfo;
  final IAppointmentRemoteDatasource remoteDatasource;

  AppointmentRepository(
    this.networkInfo,
    this.remoteDatasource,
  );

  @override
  Future<Option<Failure>> createAppointment(
    String doctorid,
    String problem,
    String contact,
    String date,
    String timeRangeStart,
    String timeRangeEnd,
  ) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      await remoteDatasource.createAppointment(
        doctorid,
        problem,
        contact,
        date,
        timeRangeStart,
        timeRangeEnd,
      );
      return none();
    } catch (e) {
      return some(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, Appointments>> getAppointments() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final appointments = await remoteDatasource.fetchAppointments();
      return right(appointments);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, Appointments>> getDocAppointments() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final appointments = await remoteDatasource.fetchDocAppointments();
      return right(appointments);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Option<Failure>> deleteAppointment(String id) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      await remoteDatasource.deleteAppointment(id);
      return none();
    } catch (e) {
      return some(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
