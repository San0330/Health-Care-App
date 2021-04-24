import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_location.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(required: true)
  final String id;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final String role;

  @JsonKey(nullable: true)
  final String contact;
  
  final String token;

  @JsonKey(required: true)
  final String email;

  @JsonKey(name: 'citizen_id', nullable: true)
  String citizenId;

  @JsonKey(nullable: true)
  String image;

  @JsonKey(nullable: true)
  String dob;

  @JsonKey(nullable: true)
  String gender;

  @JsonKey(nullable: true)
  UserLocation location;

  User({
    @required this.id,
    @required this.name,
    @required this.role,
    @required this.contact,
    @required this.email,
    @required this.token,
    this.image,
    this.citizenId,
    this.dob,
    this.gender,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(id: $id, name: $name, role: $role, contact: $contact, email: $email, citizenId: $citizenId, image: $image, dob: $dob, gender: $gender, location: $location, token:$token)';
  }
}
