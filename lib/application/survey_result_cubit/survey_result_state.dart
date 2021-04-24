part of 'survey_result_cubit.dart';

abstract class SurveyResultState extends Equatable {
  const SurveyResultState();

  @override
  List<Object> get props => [];
}

class SurveyResultLoading extends SurveyResultState {}

class SurveyResultLoaded extends SurveyResultState {
  final List<SurveyResult> surveyResult;

  const SurveyResultLoaded(this.surveyResult);

  @override
  List<Object> get props => [surveyResult];
}

class SurveyResultError extends SurveyResultState {
  final Failure failure;

  const SurveyResultError(this.failure);

  @override
  List<Object> get props => [failure];
}
