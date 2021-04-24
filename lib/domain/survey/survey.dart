import 'package:json_annotation/json_annotation.dart';

import 'questions.dart';

part 'survey.g.dart';

@JsonSerializable(explicitToJson: true)
class Survey {
  String id;
  String title;
  List<Question> questions;

  Survey({
    this.title,
    this.questions,
  });

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);

  @override
  String toString() => 'Survey(id: $id, title: $title, questions: $questions)';
}
