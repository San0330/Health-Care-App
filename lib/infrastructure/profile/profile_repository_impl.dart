import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/profile/i_profile_repo.dart';
import '../auth/auth_local_datasource.dart';
import '../core/connection_checker.dart';
import '../services/location_service.dart';
import '../services/media_service.dart';
import 'profile_remote_datasource.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final IProfileRemoteDatasource remoteDatasource;
  final IAuthLocalDataSource localDataSource;
  final IMediaService mediaService;
  // final ILocationService locationService;
  final INetworkInfo networkInfo;

  ProfileRepository(
    this.remoteDatasource,
    this.localDataSource,
    this.mediaService,
    // this.locationService,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Unit>> updateImage({bool fromGallery = true}) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final imageFile = await mediaService.getImage(fromGallery: fromGallery);
      final image = imageFile.path;
      final user = await remoteDatasource.updateImage(image: image);

      await localDataSource.cacheSignedInUser(user);

      return right(unit);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLocation() async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    return left(const Failure(message: "Location service disabled"));

    // final longlat = await locationService.getLocation();
    // try {
    //   final user =
    //       await remoteDatasource.updateLocation(longlat[0], longlat[1]);

    //   await localDataSource.cacheSignedInUser(user);

    //   return right(unit);
    // } catch (e) {
    //   return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    // }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({
    String name,
    String email,
    String gender,
    String contact,
    String citizenId,
    String dob,
  }) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final user = await remoteDatasource.updateProfile(
        name: name,
        email: email,
        gender: gender,
        contact: contact,
        citizenId: citizenId,
        dob: dob,
      );

      await localDataSource.cacheSignedInUser(user);

      return right(unit);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
