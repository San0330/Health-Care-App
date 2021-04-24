import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/prescription/i_prescription_repo.dart';
import '../core/connection_checker.dart';
import '../services/media_service.dart';

@LazySingleton(as: IPrescriptionRepo)
class PrescriptionRepoImpl implements IPrescriptionRepo {
  final INetworkInfo networkInfo;
  final IMediaService mediaService;
  final Dio dio;

  PrescriptionRepoImpl(this.networkInfo,this.mediaService, this.dio);

  @override
  Future<Option<Failure>> uploadPrescriptions({bool fromGallery = true}) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final imageFile = await mediaService.getImage(fromGallery: fromGallery);
      final image = imageFile.path;

      final ext = image.split('.').last;

      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image,
          contentType: MediaType("image", ext),
        ),
      });

      await dio.post("/user/upload-prescription", data: formData);
            
      return none();
    } catch (e) {
      return some(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
