part of 'loginregister_bloc.dart';

@immutable
abstract class LoginregisterEvent extends Equatable {
  const LoginregisterEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginregisterEvent {
  final String email;
  final String password;

  const LoginButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterButtonPressed extends LoginregisterEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterButtonPressed({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, confirmPassword];
}