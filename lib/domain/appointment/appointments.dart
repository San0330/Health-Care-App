import 'package:json_annotation/json_annotation.dart';

import 'appointment.dart';

part 'appointments.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointments {
  final List<Appointment> appointments;

  Appointments(this.appointments);

  factory Appointments.fromJson(Map<String, dynamic> json) =>
      _$AppointmentsFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentsToJson(this);

  @override
  String toString() => 'Appointments(appointments: $appointments)';
}
