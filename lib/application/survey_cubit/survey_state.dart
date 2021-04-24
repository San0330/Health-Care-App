part of 'survey_cubit.dart';

abstract class SurveycubitState extends Equatable {
  const SurveycubitState();

  @override
  List<Object> get props => [];
}

class SurveycubitLoading extends SurveycubitState {}

class SurveycubitLoaded extends SurveycubitState {
  final List<Survey> surveys;

  const SurveycubitLoaded({
    this.surveys,
  });

  @override
  List<Object> get props => [surveys];
}

class SurveycubitFailed extends SurveycubitState {
  final Failure failure;

  const SurveycubitFailed(
    this.failure,
  );

  @override
  List<Object> get props => [failure];
}
