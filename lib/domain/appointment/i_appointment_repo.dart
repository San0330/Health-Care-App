import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import 'appointments.dart';

abstract class IAppointmentRepository {
  Future<Either<Failure, Appointments>> getAppointments();
  Future<Option<Failure>> createAppointment(
    String doctorid,
    String problem,
    String contact,
    String date,
    String timeRangeStart,
    String timeRangeEnd,
  );
  Future<Either<Failure, Appointments>> getDocAppointments();
  Future<Option<Failure>> deleteAppointment(String id);
}
