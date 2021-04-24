import 'package:json_annotation/json_annotation.dart';

import 'answer_count.dart';

part 'survey_results.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyResult {

  @JsonKey(name: '_id')
  final String question;

  @JsonKey(name: 'answers')
  final List<AnswerCount> answerCounts;

  SurveyResult(this.question, this.answerCounts);

  factory SurveyResult.fromJson(Map<String, dynamic> json) => _$SurveyResultFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResultToJson(this);

  @override
  String toString() =>
      'SurveyResult(question: $question, answerCounts: $answerCounts)';
}
