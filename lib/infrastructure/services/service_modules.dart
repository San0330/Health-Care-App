import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@module
abstract class ServiceModule {
  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  Location get location => Location();
}
