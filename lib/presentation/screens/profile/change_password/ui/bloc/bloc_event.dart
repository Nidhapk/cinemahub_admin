import 'package:equatable/equatable.dart';

abstract class ChangepasswordEvents extends Equatable {
  const ChangepasswordEvents();
  @override
  List<Object> get props => [];
}

class CheckcurrentPasswordEvent extends ChangepasswordEvents {
  final String password;
  const CheckcurrentPasswordEvent(this.password);
  @override
  List<Object> get props => [password];
}

class PasswordChangedEvent extends ChangepasswordEvents {
  final String newPassword;
  const PasswordChangedEvent(this.newPassword);
   @override
  List<Object> get props => [newPassword];
}

