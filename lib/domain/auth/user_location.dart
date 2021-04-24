import 'package:json_annotation/json_annotation.dart';

part 'user_location.g.dart';

@JsonSerializable()
class UserLocation {
  @JsonKey(required: true)
  final List<double> coordinates;

  @JsonKey(nullable: true)
  final String address;

  UserLocation({
    this.coordinates,
    this.address,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);

  @override
  String toString() =>
      'UserLocation(coordinates: $coordinates, address: $address)';
}
