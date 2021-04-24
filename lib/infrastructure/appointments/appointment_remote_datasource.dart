import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/appointment/appointments.dart';

abstract class IAppointmentRemoteDatasource {
  Future<Appointments> fetchAppointments();
  Future<void> createAppointment(
    String doctorid,
    String problem,
    String contact,
    String date,
    String timeRangeStart,
    String timeRangeEnd,
  );
  Future<Appointments> fetchDocAppointments();
  Future deleteAppointment(String id);
}

@LazySingleton(as: IAppointmentRemoteDatasource)
class AppointmentRemoteDatasourceImpl implements IAppointmentRemoteDatasource {
  final Dio dio;

  AppointmentRemoteDatasourceImpl(this.dio);

  @override
  Future<Appointments> fetchAppointments() async {
    Response response;
    try {
      response = await dio.get('/appointment');
      final data = response.data['data'] as Map<String, dynamic>;

      final appointments = Appointments.fromJson(data);
      return appointments;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createAppointment(
    String doctorid,
    String problem,
    String contact,
    String date,
    String timeRangeStart,
    String timeRangeEnd,
  ) async {
    try {
      await dio.post(
        '/appointment',
        data: {
          "doctor": doctorid,
          "problem": problem,
          "contacts": contact,
          "date": date,
          "timerange": [
            {
              "start": timeRangeStart,
              "end": timeRangeEnd,
            }
          ]
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Appointments> fetchDocAppointments() async {
    try {
      final Response response = await dio.get('/appointment/doc-appointments');
      final data = response.data['data'] as Map<String, dynamic>;

      final appointments = Appointments.fromJson(data);

      return appointments;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteAppointment(String id) async {
    try {
      await dio.delete('/appointment/$id');
    } catch (e) {
      rethrow;
    }
  }
}
