import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/home/home_model.dart';
import '../../utils/logger.dart';
import '../core/exceptions.dart';

abstract class IHomeRemoteDatasource {
  Future<HomeModel> getFeatureProductsWithAppointCount();
}

@LazySingleton(as: IHomeRemoteDatasource)
class HomeRemoteDatasource implements IHomeRemoteDatasource {
  final Dio dio;
  final logger = getLogger("HomeRemoteDatasource");

  HomeRemoteDatasource(this.dio);

  @override
  Future<HomeModel> getFeatureProductsWithAppointCount() async {
    Response response;
    logger.i("getFeatureProductsWithAppointCount() called");
    try {
      response = await dio.get(
        "/view/home",
      );

      final data = response.data['data'] as Map<String, dynamic>;
      final homeModel = HomeModel.fromJson(data);

      return homeModel;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
