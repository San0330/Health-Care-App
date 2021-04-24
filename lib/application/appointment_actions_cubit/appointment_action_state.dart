part of 'appointment_action_cubit.dart';

abstract class AppointmentActionState extends Equatable {
  const AppointmentActionState();

  @override
  List<Object> get props => [];
}

class AppointmentActionInitial extends AppointmentActionState {}

class AppointmentActionCreated extends AppointmentActionState {}

class AppointmentActionDeleted extends AppointmentActionState {}

class AppointmentFetched extends AppointmentActionState {
  final Appointments appointments;

  const AppointmentFetched(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AppointmentActionFailed extends AppointmentActionState {
  final Failure failure;

  const AppointmentActionFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
