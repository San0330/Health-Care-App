import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import '../core/failures.dart';

abstract class IProfileRepository {
  Future<Either<Failure, Unit>> updateProfile({
    @required String name,
    @required String email,
    @required String gender,
    @required String contact,
    @required String citizenId,
    @required String dob,
  });

  Future<Either<Failure, Unit>> updateImage({
    bool fromGallery = true,
  });

  Future<Either<Failure, Unit>> updateLocation();
}
