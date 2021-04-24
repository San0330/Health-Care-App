import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/auth/user.dart';
import '../../utils/utils.dart';
import '../core/exceptions.dart';

const String cacheUserString = 'cacheUserString';

@LazySingleton(as: IAuthLocalDataSource)
class AuthLocalDatasource implements IAuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final logger = getLogger("AuthLocalDatasource");

  AuthLocalDatasource(this.sharedPreferences);

  @override
  Future<void> cacheSignedInUser(User user) async {
    logger.i("cacheSignedInUser() called");
    final String userJson = json.encode(user.toJson());
    try {
      await sharedPreferences.setString(
        cacheUserString,
        userJson,
      );
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }

  @override
  Future<Option<User>> getSignedInUser() async {
    logger.i("getSignedInUser() called");
    try {
      final String cachedUser = sharedPreferences.getString(cacheUserString);

      if (cachedUser == null) {
        logger.i("no cached user");
        return Future.value(none());
      }

      final User user = User.fromJson(
        json.decode(cachedUser) as Map<String, dynamic>,
      );

      return Future.value(some(user));
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }

  @override
  Future<void> signout() async {
    logger.i("signout() called");
    await sharedPreferences.remove(cacheUserString);
  }
}

abstract class IAuthLocalDataSource {
  Future<void> cacheSignedInUser(User user);
  Future<Option<User>> getSignedInUser();
  Future<void> signout();
}
