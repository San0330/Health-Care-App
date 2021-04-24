import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/profile/i_profile_repo.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final IProfileRepository repository;

  ProfileCubit(
    this.repository,
  ) : super(ProfileInitial());

  Future updateProfile({
    @required String name,
    @required String email,
    @required String gender,
    @required String contact,
    @required String citizenId,
    @required String dob,
  }) async {
    emit(ProfileInitial());

    final user = await repository.updateProfile(
      name: name,
      email: email,
      gender: gender,
      contact: contact,
      citizenId: citizenId,
      dob: dob,
    );

    user.fold(
      (l) => emit(ProfileUpdateFailed()),
      (r) => emit(ProfileUpdateSuccess()),
    );
  }

  Future updateImage({bool fromGallery = true}) async {
    emit(ProfileInitial());

    final user = await repository.updateImage(fromGallery: fromGallery);

    user.fold(
      (l) => emit(ProfileUpdateFailed()),
      (r) => emit(ProfileUpdateSuccess()),
    );
  }

  Future updateLocation() async {
    emit(ProfileInitial());

    final user = await repository.updateLocation();

    user.fold(
      (l) => emit(ProfileUpdateFailed()),
      (r) => emit(ProfileUpdateSuccess()),
    );
  }
}
