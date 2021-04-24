import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/survey/i_survey_repo.dart';
import '../../domain/survey/survey.dart';
import '../../domain/survey/survey_results.dart';
import '../core/connection_checker.dart';

@LazySingleton(as: ISurveyRepo)
class SurveyRepoImpl implements ISurveyRepo {
  final Dio dio;
  final INetworkInfo networkInfo;

  SurveyRepoImpl(this.dio, this.networkInfo);

  @override
  Future<Option<Failure>> createSurvey(Map<String, dynamic> survey) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      await dio.post("/survey", data: survey);

      return none();
    } catch (e) {
      return some(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, List<Survey>>> listSurveys() async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final response = await dio.get("/survey");

      final surveysData = response.data["data"] as List;

      final List<Survey> surveys = [];
      for (final dynamic s in surveysData) {
        surveys.add(Survey.fromJson(s as Map<String, dynamic>));
      }

      return right(surveys);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Option<Failure>> submitSurvey(
    String id,
    List<Map<String, String>> submissions,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      await dio.post("/survey/submit/$id", data: {
        "surveyId": id,
        "submission": submissions,
      });

      return none();
    } on DioError catch (_) {
      return some(Failure(message: Failure.SERVER_FAILURE_MSG));
    } catch (e) {
      return some(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, List<SurveyResult>>> surveyResult(
      String surveyId) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final response = await dio.get("/survey/details/$surveyId");

      final surveysData = response.data["data"] as List;

      final List<SurveyResult> surveyResults = [];
      for (final dynamic s in surveysData) {
        surveyResults.add(SurveyResult.fromJson(s as Map<String, dynamic>));
      }

      return right(surveyResults);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
