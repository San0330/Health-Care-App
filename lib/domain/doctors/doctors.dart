import 'package:json_annotation/json_annotation.dart';

import 'doctor.dart';

part 'doctors.g.dart';

@JsonSerializable(explicitToJson: true)
class Doctors {
  final List<Doctor> doctors;

  Doctors(this.doctors);

  factory Doctors.fromJson(Map<String, dynamic> json) =>
      _$DoctorsFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsToJson(this);

  @override
  String toString() => 'Doctors(doctors: $doctors)';
}
