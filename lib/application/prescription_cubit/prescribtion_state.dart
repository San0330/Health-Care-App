part of 'prescribtion_cubit.dart';

abstract class PrescribtionState extends Equatable {
  const PrescribtionState();

  @override
  List<Object> get props => [];
}

class PrescribtionInitial extends PrescribtionState {
  const PrescribtionInitial();
}

class PrescribtionUploadSuccess extends PrescribtionState {
  const PrescribtionUploadSuccess();
}

class PrescribtionUploadFailed extends PrescribtionState {
  const PrescribtionUploadFailed();
}
