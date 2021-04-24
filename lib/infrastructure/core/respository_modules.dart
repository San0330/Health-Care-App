import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_constants.dart';

@module
abstract class RepositoryModule {
  @lazySingleton
  DataConnectionChecker get dataConnectionChecker => DataConnectionChecker();

  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: 5000,
          receiveTimeout: 3000,
        ),
      );

  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
