import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/user.dart';
import '../../utils/logger.dart';
import '../core/exceptions.dart';

@LazySingleton(as: IAuthRemoteDataSource)
class AuthRemoteDatasourceImpl implements IAuthRemoteDataSource {
  final logger = getLogger("AuthRemoteDatasourceImpl");

  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<User> register({
    @required String email,
    @required String password,
    @required String name,
    @required String confirmPassword,
  }) async {
    logger.i(
        "register(email:$email,password:$password,name:$name,confirmPassword:$confirmPassword) called");

    Response response;

    try {
      response = await dio.post(
        "/auth/signup",
        data: {
          "email": email,
          "password": password,
          'password_confirm': confirmPassword,
          "name": name,
        },
      );

      final userData = response.data['data']['user'] as Map<String, dynamic>;
      userData['token'] = response.data['token'];

      final User user = User.fromJson(userData);
      return user;
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        switch (e.response.statusCode) {
          case 400:
            throw EmailAlreadyInUseException();
          case 401:
            throw InvalidEmailPasswordCombinationException();
          default:
            throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<User> signIn({
    @required String email,
    @required String password,
  }) async {
    logger.i("signIn() called");
    try {
      final response = await dio.post(
        "/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      final userData = response.data['data']['user'] as Map<String, dynamic>;
      userData['token'] = response.data['token'];

      final User user = User.fromJson(userData);

      return user;
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        switch (e.response.statusCode) {
          case 401:
            throw InvalidEmailPasswordCombinationException();
          default:
            throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}

abstract class IAuthRemoteDataSource {
  Future<User> register({
    @required String email,
    @required String password,
    @required String name,
    @required String confirmPassword,
  });
  Future<User> signIn({
    @required String email,
    @required String password,
  });
}
