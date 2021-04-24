import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import '../core/failures.dart';
import 'user.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Unit>> register({
    @required String name,
    @required String email,
    @required String password,
    @required String confirmPassword,
  });

  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  Future<Option<User>> getSignedInUser();
  Future<void> signOut();
}
