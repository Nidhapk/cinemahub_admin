abstract class SignUpEvent {}

class UserRegisterEvent extends SignUpEvent {
  final String userName;
  final String password;
  final String securityCode;

  UserRegisterEvent(this.userName, this.password,this.securityCode);
}
