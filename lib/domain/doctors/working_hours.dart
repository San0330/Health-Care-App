import 'package:json_annotation/json_annotation.dart';

part 'working_hours.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkingHours {
  final String start;
  final String end;

  WorkingHours({
    this.start,
    this.end,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHoursToJson(this);

  @override
  String toString() => 'WorkingHours(start: $start, end: $end)';
}
