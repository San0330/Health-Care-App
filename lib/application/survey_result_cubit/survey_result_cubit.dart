import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/survey/i_survey_repo.dart';
import '../../domain/survey/survey_results.dart';

part 'survey_result_state.dart';

@injectable
class SurveyResultCubit extends Cubit<SurveyResultState> {
  final ISurveyRepo _surveyRepo;

  SurveyResultCubit(
    this._surveyRepo,
  ) : super(SurveyResultLoading());

  Future loadData(String surveyId) async {
    emit(SurveyResultLoading());

    final surveyResultEither = await _surveyRepo.surveyResult(surveyId);

    surveyResultEither.fold(
      (l) => emit(SurveyResultError(l)),
      (r) => emit(SurveyResultLoaded(r)),
    );
  }
}
