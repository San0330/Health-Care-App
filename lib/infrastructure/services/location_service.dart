import 'package:injectable/injectable.dart';
// import 'package:location/location.dart';

abstract class ILocationService {
  Future<List<double>> getLocation();
}

@LazySingleton(as: ILocationService)
class LocationService implements ILocationService {
  // final Location location;

  // LocationService(
  //   this.location,
  // );

  @override
  Future<List<double>> getLocation() async {
    bool _serviceEnabled;
    // PermissionStatus _permissionGranted;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     throw Exception();
    //   }
    // }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     throw Exception();
    //   }
    // }

    // final locationData = await location.getLocation();

    // return [locationData.longitude, locationData.latitude];
    return [100, 200];
  }
}
