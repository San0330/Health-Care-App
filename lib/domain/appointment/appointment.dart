import 'package:json_annotation/json_annotation.dart';

import '../auth/user.dart';
import '../doctors/doctor.dart';
import '../doctors/working_hours.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointment {
  final String id;
  final Doctor doctor;
  final User user;
  final String problem;
  final String contact;
  final String date;
  final String time;
  final List<WorkingHours> timerange;

  Appointment(
    this.id,
    this.doctor,
    this.user,
    this.problem,
    this.contact,
    this.date,
    this.time,
    this.timerange,
  );

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
