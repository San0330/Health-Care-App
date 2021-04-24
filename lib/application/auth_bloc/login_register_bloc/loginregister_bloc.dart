import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/auth/i_auth_repository.dart';
import '../../../domain/core/failures.dart';
import '../../../utils/utils.dart';

part 'loginregister_event.dart';
part 'loginregister_state.dart';

@injectable
class LoginregisterBloc extends Bloc<LoginregisterEvent, LoginregisterState> {
  final IAuthRepository authRepository;

  final logger = getLogger("LoginregisterBloc");

  LoginregisterBloc({
    this.authRepository,
  }) : super(const LoginregisterInitial());

  @override
  Stream<LoginregisterState> mapEventToState(
    LoginregisterEvent event,
  ) async* {
    yield const LoginregisterLoading();

    Either<Failure, Unit> authFailureOrSuccess;

    if (event is LoginButtonPressed) {
      authFailureOrSuccess = await authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
    } else if (event is RegisterButtonPressed) {
      authFailureOrSuccess = await authRepository.register(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        name: event.name,
      );
    }

    yield authFailureOrSuccess.fold(
      (f) => LoginregisterFailed(failure: f),
      (s) {
        return const LoginregisterSuccess();
      },
    );
  }
}
