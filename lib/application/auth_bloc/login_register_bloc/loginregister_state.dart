part of 'loginregister_bloc.dart';

@immutable
abstract class LoginregisterState extends Equatable {
  const LoginregisterState();

  @override
  List<Object> get props => [];
}

class LoginregisterInitial extends LoginregisterState {
  const LoginregisterInitial();
}

class LoginregisterLoading extends LoginregisterState {
  const LoginregisterLoading();
}

class LoginregisterSuccess extends LoginregisterState {
  const LoginregisterSuccess();
}

class LoginregisterFailed extends LoginregisterState {
  final Failure failure;

  const LoginregisterFailed({@required this.failure}) : assert(failure != null);

  @override
  List<Object> get props => [failure];
}
