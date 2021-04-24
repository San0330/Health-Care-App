part of 'survey_cud_cubit.dart';

class SurveyCUDCubitState extends Equatable {
  const SurveyCUDCubitState({
    this.isLoading,
    this.failure,
  });

  final bool isLoading;
  final Option<Failure> failure;

  @override
  List<Object> get props => [];

  SurveyCUDCubitState copyWith({
    bool isLoading,
    Option<Failure> failure,
  }) {
    return SurveyCUDCubitState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  factory SurveyCUDCubitState.initial() {
    return SurveyCUDCubitState(
      isLoading: false,
      failure: none(),
    );
  }
}
