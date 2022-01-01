part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StartRegister extends AuthEvent{
  final String mail;
  final String password;
  final bool seller;
  const StartRegister(this.mail,this.password,this.seller);
}
class ValidateRegisterForm extends AuthEvent{
  final bool validate;
  const ValidateRegisterForm({this.validate=false});
}
class StartLogin extends AuthEvent{
  final String mail;
  final String password;
  const StartLogin(this.mail,this.password);
}
class LoginWithGoogle extends AuthEvent{}
class ResetPassword extends AuthEvent{
 final String email;
  const ResetPassword(this.email);
}
class CheckForLogin extends AuthEvent{}
class SignOut extends AuthEvent{}
