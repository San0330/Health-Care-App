import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../domain/auth/i_auth_repository.dart';
import '../../domain/auth/user.dart';
import '../../injection.dart';
import '../../utils/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final logger = getLogger("AuthBloc");

  final IAuthRepository authRepository;

  AuthBloc({this.authRepository}) : super(const AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckAuth) {
      final userOptions = await authRepository.getSignedInUser();
      String token;

      yield userOptions.fold(
        () => const Unauthenticated(),
        (user) {
          token = user.token;

          final decodedJwt = JwtDecoder.decode(token);

          final currentDate = DateTime.now();
          final expDate = DateTime.fromMillisecondsSinceEpoch(
            (decodedJwt['exp'] as int) * 1000,
            isUtc: true,
          );

          if (expDate.isBefore(currentDate)) {
            logger.i("token expired");
            add(const Signout());
            return const Unauthenticated();
          }

          getIt<Dio>().interceptors.add(
                InterceptorsWrapper(
                  onRequest: (Options options) {
                    if (token != null) {
                      options.headers["Authorization"] = "Bearer $token";
                    }
                    return options;
                  },
                  onError: (DioError error) {
                    logger.e(error);
                  },
                ),
              );

          Timer(
            Duration(
              seconds: expDate.difference(currentDate).inSeconds,
            ),
            () {
              logger.i("token expired");
              add(const Signout());
            },
          );

          return Authenticated(
            authenticatedUser: user,
          );
        },
      );
    } else if (event is Signout) {
      await authRepository.signOut();

      yield const Unauthenticated();
    }
  }
}
