import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/survey/i_survey_repo.dart';
import '../../domain/survey/survey.dart';

part 'survey_state.dart';

@injectable
class SurveyCubit extends Cubit<SurveycubitState> {
  final ISurveyRepo surveyRepo;

  SurveyCubit(
    this.surveyRepo,
  ) : super(SurveycubitLoading());

  Future loadData() async {
    emit(SurveycubitLoading());

    final surveyOptions = await surveyRepo.listSurveys();

    surveyOptions.fold(
      (l) => emit(SurveycubitFailed(l)),
      (r) => emit(SurveycubitLoaded(surveys: r)),
    );
  }
}
