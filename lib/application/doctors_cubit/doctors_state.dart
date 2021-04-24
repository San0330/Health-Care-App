part of 'doctors_cubit.dart';

abstract class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

class DoctorsInitial extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final Doctors doctors;

  const DoctorsLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}

class DoctorsLoadingFailed extends DoctorsState {
  final Failure failure;

  const DoctorsLoadingFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
