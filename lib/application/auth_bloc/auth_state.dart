part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class Authenticated extends AuthState {
  final User authenticatedUser;

  const Authenticated({
    @required this.authenticatedUser,
  });

  @override
  List<Object> get props => [authenticatedUser];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}
