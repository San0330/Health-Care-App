import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class IMediaService {
  Future<File> getImage({bool fromGallery});
}

@LazySingleton(as: IMediaService)
class MediaService implements IMediaService {
  final ImagePicker picker;

  MediaService(this.picker);

  @override
  Future<File> getImage({bool fromGallery}) async {
    final pickerFile = await picker.getImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 400,
    );
    final image = File(pickerFile.path);
    return image;
  }
}
