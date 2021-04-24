import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/user.dart';

abstract class IProfileRemoteDatasource {
  Future<User> updateImage({
    @required String image,
  });

  Future<User> updateLocation(double longitude, double latitude);

  Future<User> updateProfile({
    @required String name,
    @required String email,
    @required String gender,
    @required String contact,
    @required String citizenId,
    @required String dob,
  });
}

@LazySingleton(as: IProfileRemoteDatasource)
class ProfileRemoteDatasource implements IProfileRemoteDatasource {
  final Dio dio;

  ProfileRemoteDatasource(this.dio);

  @override
  Future<User> updateImage({String image}) async {
    try {
      final ext = image.split('.').last;

      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image,
          contentType: MediaType("image", ext),
        ),
      });

      final response = await dio.patch("/user/update", data: formData);

      final userData = response.data['data']['user'] as Map<String, dynamic>;
      userData['token'] = response.data['token'];

      final User user = User.fromJson(userData);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> updateLocation(double longitude, double latitude) async {
    try {
      final Map<String, dynamic> locationMap = {
        'location': {
          'coordinates': [longitude, latitude],
          'address': "Butwal",
        },
      };

      final encodedLocation = json.encode(locationMap);
      final response = await dio.patch("/user/update", data: encodedLocation);

      final userData = response.data['data']['user'] as Map<String, dynamic>;
      userData['token'] = response.data['token'];

      final User user = User.fromJson(userData);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> updateProfile({
    String name,
    String email,
    String gender,
    String contact,
    String citizenId,
    String dob,
  }) async {
    try {
      final response = await dio.patch("/user/update", data: {
        "name": name,
        "email": email,
        "gender": gender,
        "contact": contact,
        "citizen_id": citizenId,
        "dob": dob,
      });

      final userData = response.data['data']['user'] as Map<String, dynamic>;
      userData['token'] = response.data['token'];

      final User user = User.fromJson(userData);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
