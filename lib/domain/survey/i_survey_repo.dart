import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import 'survey.dart';
import 'survey_results.dart';

abstract class ISurveyRepo {
  Future<Option<Failure>> createSurvey(Map<String, dynamic> survey);
  Future<Option<Failure>> submitSurvey(
    String id,
    List<Map<String, String>> submissions,
  );
  Future<Either<Failure, List<Survey>>> listSurveys();
  Future<Either<Failure, List<SurveyResult>>> surveyResult(String surveyId);
}
