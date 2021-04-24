import 'package:json_annotation/json_annotation.dart';

part 'questions.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  String question;
  List<String> options;

  Question({
    this.question,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  String toString() => 'Question(question: $question, options: $options)';
}
