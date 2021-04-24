import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/auth/user.dart';
import '../../domain/core/failures.dart';
import '../../utils/logger.dart';
import '../core/connection_checker.dart';
import '../core/exceptions.dart';
import 'auth_local_datasource.dart';
import 'auth_remote_datasource.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final logger = getLogger("AuthRepository");

  final IAuthLocalDataSource localDataSource;
  final IAuthRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  AuthRepository({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> register({
    @required String name,
    @required String email,
    @required String password,
    @required String confirmPassword,
  }) async {
    logger.i("register() called");

    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      logger.i("isConnected -> false");
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }
    try {
      final user = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      await localDataSource.cacheSignedInUser(user);

      return right(unit);
    } on CacheException catch (_) {
      return left(AuthFailure(message: AuthFailure.CACHE_FAILURE_MSG));
    } on EmailAlreadyInUseException catch (_) {
      return left(AuthFailure(message: AuthFailure.EMAIL_ALREADY_USED_MSG));
    } catch (_) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    logger.i("signInWithEmailAndPassword() called");
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      logger.i("isConnected -> false");
      return left(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final user = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      await localDataSource.cacheSignedInUser(user);

      return right(unit);
    } on CacheException catch (_) {
      return left(AuthFailure(message: AuthFailure.CACHE_FAILURE_MSG));
    } on EmailAlreadyInUseException catch (_) {
      return left(AuthFailure(message: AuthFailure.EMAIL_ALREADY_USED_MSG));
    } on InvalidEmailPasswordCombinationException catch (_) {
      return left(AuthFailure(message: AuthFailure.EMAIL_PWD_FAILURE_MSG));
    } catch (_) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Option<User>> getSignedInUser() => localDataSource.getSignedInUser();

  @override
  Future<void> signOut() => localDataSource.signout();
}
