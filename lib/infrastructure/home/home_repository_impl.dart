import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/core/failures.dart';
import '../../domain/home/home_model.dart';
import '../../domain/home/i_home_repository.dart';
import '../../utils/logger.dart';
import '../core/connection_checker.dart';
import 'home_remote_datasource.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final logger = getLogger("HomeRepository");
  final IHomeRemoteDatasource homeRemoteDatasource;
  final INetworkInfo networkInfo;

  HomeRepository({
    @required this.homeRemoteDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, HomeModel>>
      getFeatureProductsWithAppointCount() async {
    logger.i("getFeatureProductsWithAppointCount() called");
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      logger.i("isConnected -> false");
      return left(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final homeModel =
          await homeRemoteDatasource.getFeatureProductsWithAppointCount();
      return right(homeModel);
    } catch (e) {
      logger.e(e);
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
