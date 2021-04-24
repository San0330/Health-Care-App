import 'package:json_annotation/json_annotation.dart';

part 'answer_count.g.dart';

@JsonSerializable()
class AnswerCount {
  final String answer;
  final int count;

  AnswerCount(this.answer, this.count);

  factory AnswerCount.fromJson(Map<String, dynamic> json) =>
      _$AnswerCountFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerCountToJson(this);

  @override
  String toString() => 'AnswerCount(answer: $answer, count: $count)';
}
