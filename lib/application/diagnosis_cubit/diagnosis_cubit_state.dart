part of 'diagnosis_cubit.dart';

class DiagnosisCubitState extends Equatable {
  final List<Condition> selectedConditions;

  const DiagnosisCubitState(this.selectedConditions);

  @override
  List<Object> get props => [];
}

class DiagnosisLoadingState extends DiagnosisCubitState {
  const DiagnosisLoadingState(List<Condition> selectedConditions)
      : super(selectedConditions);
}

class DiagnosisFailedState extends DiagnosisCubitState {
  final Failure failure;

  const DiagnosisFailedState(
    this.failure,
    List<Condition> selectedConditions,
  ) : super(selectedConditions);
}  

class DiagnosisSearchState extends DiagnosisCubitState {
  /// Get all the possible conditions
  /// stored in a file as List<Map> instead of making api request to get it...
  /// shown to user, to select his/her condition/symptom
  final List<Condition> conditions =
      conditionsListRaw.map((e) => Condition.fromMap(e)).toList();

  DiagnosisSearchState(List<Condition> selectedConditions)
      : super(selectedConditions);

  @override
  List<Object> get props => [selectedConditions];
}

class DiagnosisInterviewState extends DiagnosisCubitState {
  final Diagnosis diagnosis;

  const DiagnosisInterviewState(
    this.diagnosis,
    List<Condition> selectedConditions,
  ) : super(selectedConditions);

  @override
  List<Object> get props => [diagnosis];
}
