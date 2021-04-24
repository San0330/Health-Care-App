import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/diagnosis/conditions.dart';
import '../../domain/diagnosis/conditions_list.dart';
import '../../domain/diagnosis/diagnosis.dart';
import '../../domain/diagnosis/i_diagnosis_repo.dart';

part 'diagnosis_cubit_state.dart';

@injectable
class DiagnosisCubit extends Cubit<DiagnosisCubitState> {
  final IDiagnosisRepo diagnosisRepo;

  DiagnosisCubit(
    this.diagnosisRepo,
  ) : super(DiagnosisSearchState(const []));

  void addSymptom(Condition c) {
    final List<Condition> prevConditions = state.selectedConditions;

    final cond = prevConditions.isEmpty ? c.copyWith(source: 'initial') : c;

    final List<Condition> selectedConditions = [...prevConditions, cond];

    emit(DiagnosisSearchState(selectedConditions));
  }

  /// send conditions/symptoms to server and get back the results
  Future<void> submit({
    String sex = 'male',
    int age = 30,
  }) async {
    final diagnosisEither = await diagnosisRepo.getDiagnosis(
      sex,
      age,
      state.selectedConditions,
    );

    diagnosisEither.fold(
      (failure) =>
          emit(DiagnosisFailedState(failure, state.selectedConditions)),
      (diagnosis) =>
          emit(DiagnosisInterviewState(diagnosis, state.selectedConditions)),
    );
  }

  /// send conditions/symptoms to server and get back the results
  Future<void> yesNoBtnPressed({
    String sex = 'male',
    int age = 30,
    Condition c,
  }) async {
    final List<Condition> prevConditions = state.selectedConditions;
    final List<Condition> selectedConditions = [...prevConditions, c];

    final diagnosisEither = await diagnosisRepo.getDiagnosis(
      sex,
      age,
      selectedConditions,
    );

    diagnosisEither.fold(
      (failure) => emit(DiagnosisFailedState(failure, selectedConditions)),
      (diagnosis) =>
          emit(DiagnosisInterviewState(diagnosis, selectedConditions)),
    );
  }

  /// Check if the condition is already selected or not
  bool hasAlready(Condition c) =>
      state.selectedConditions
          .indexWhere((element) => element.name.contains(c.name)) !=
      -1;
}
