import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/doctors/doctors.dart';
import '../../domain/doctors/i_doctors_repo.dart';

part 'doctors_state.dart';

@injectable
class DoctorsCubit extends Cubit<DoctorsState> {
  final IDoctorsRepository repository;

  DoctorsCubit(this.repository) : super(DoctorsInitial());

  Future load() async {
    emit(DoctorsInitial());

    final doctorsModelEither = await repository.fetchDoctors();

    emit(
      doctorsModelEither.fold(
        (f) => DoctorsLoadingFailed(f),
        (r) => DoctorsLoaded(r),
      ),
    );
  }
}
