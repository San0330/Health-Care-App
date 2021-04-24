import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/doctors/doctors.dart';

abstract class IDoctorsRemoteDatasource {
  Future<Doctors> fetchDoctors();
}

@LazySingleton(as: IDoctorsRemoteDatasource)
class DoctorsRemoteDatasourceImpl implements IDoctorsRemoteDatasource {
  final Dio dio;

  DoctorsRemoteDatasourceImpl(this.dio);

  @override
  Future<Doctors> fetchDoctors() async {
    Response response;

    try {
      response = await dio.get('/doctors');
      final data = response.data['data'] as Map<String, dynamic>;
      final Doctors doctors = Doctors.fromJson(data);
      return doctors;
    } catch (e) {
      rethrow;
    }
  }
}
