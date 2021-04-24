import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/prescription/i_prescription_repo.dart';

part 'prescribtion_state.dart';

@injectable
class PrescribtionCubit extends Cubit<PrescribtionState> {
  IPrescriptionRepo prescriptionRepo;

  PrescribtionCubit(this.prescriptionRepo) : super(const PrescribtionInitial());

  Future uploadPrescriptionImage({bool fromGallery = true}) async {
    emit(const PrescribtionInitial());
    
    final data = await prescriptionRepo.uploadPrescriptions(fromGallery: fromGallery);

    data.fold(
      () => emit(const PrescribtionUploadSuccess()),
      (_) => emit(const PrescribtionUploadFailed()),
    );
  }
}
