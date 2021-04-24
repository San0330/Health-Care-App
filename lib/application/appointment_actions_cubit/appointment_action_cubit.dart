import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/appointment/appointments.dart';
import '../../domain/appointment/i_appointment_repo.dart';
import '../../domain/core/failures.dart';
import '../../domain/doctors/working_hours.dart';

part 'appointment_action_state.dart';

@injectable
class AppointmentActionCubit extends Cubit<AppointmentActionState> {
  final IAppointmentRepository repository;

  AppointmentActionCubit(
    this.repository,
  ) : super(AppointmentActionInitial());

  Future createAppointment(
    String doctorid,
    String problem,
    String contact,
    String date,
    WorkingHours wh,
  ) async {
    emit(AppointmentActionInitial());

    final appointmentOptions = await repository.createAppointment(
      doctorid,
      problem,
      contact,
      date,
      wh.start,
      wh.end,
    );

    appointmentOptions.fold(
      () => emit(AppointmentActionCreated()),
      (a) => emit(AppointmentActionFailed(a)),
    );
  }

  Future fetchAppointment() async {
    emit(AppointmentActionInitial());

    final appointmentEither = await repository.getAppointments();

    appointmentEither.fold(
      (l) => emit(AppointmentActionFailed(l)),
      (r) => emit(AppointmentFetched(r)),
    );
  }

  Future fetchDocAppointment() async {
    emit(AppointmentActionInitial());

    final appointmentEither = await repository.getDocAppointments();

    appointmentEither.fold(
      (l) => emit(AppointmentActionFailed(l)),
      (r) => emit(AppointmentFetched(r)),
    );
  }

  Future deleteAppointment(String id) async{
     emit(AppointmentActionInitial());

    final appointmentOption = await repository.deleteAppointment(id);     

    appointmentOption.fold(
      () => emit(AppointmentActionDeleted()),
      (r) => emit(AppointmentActionFailed(r)),
    );
  }
}
