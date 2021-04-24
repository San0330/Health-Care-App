import 'package:json_annotation/json_annotation.dart';

import '../auth/user_location.dart';
import 'working_hours.dart';

part 'doctor.g.dart';

@JsonSerializable(explicitToJson: true)
class Doctor {
  final String id;
  final String name;
  final String contact;
  final String email;
  final String description;
  final String image;

  @JsonKey(nullable: true)
  final UserLocation location;

  @JsonKey(name: 'working_hours')
  final List<WorkingHours> workingHours;

  @JsonKey(name: 'working_weeks')
  final List<int> workingWeeks;

  final String field;

  Doctor(
    this.id,
    this.name,
    this.contact,
    this.email,
    this.image,
    this.description,
    this.workingHours,
    this.workingWeeks,
    this.field,
    this.location,
  );

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, image:$image contact: $contact, userLocation:$location, email: $email, description: $description, workingHours: $workingHours, workingWeeks: $workingWeeks, field: $field)';
  }
}
