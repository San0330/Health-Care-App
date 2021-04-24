import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/survey/i_survey_repo.dart';

part 'survey_cud_state.dart';

@injectable
class SurveyCudCubit extends Cubit<SurveyCUDCubitState> {
  final ISurveyRepo repo;

  SurveyCudCubit(
    this.repo,
  ) : super(SurveyCUDCubitState.initial());

  Future createSurvey(Map<String, dynamic> survey) async {
    emit(state.copyWith(isLoading: true));

    final createSurveyOption = await repo.createSurvey(survey);

    emit(state.copyWith(isLoading: false, failure: createSurveyOption));
  }

  Future submitSurvey(String id, List<Map<String, String>> submissions) async {
    emit(state.copyWith(isLoading: true));

    final submitSurveyOption = await repo.submitSurvey(id, submissions);    

    emit(state.copyWith(isLoading: false, failure: submitSurveyOption));
  }
}
