import 'package:equatable/equatable.dart';

abstract class ForgetPassEvent extends Equatable {
  const ForgetPassEvent();

  @override
  List<Object?> get props => [];
}

class ResetPasswordEvent extends ForgetPassEvent {
  final String newPassword;

  const ResetPasswordEvent({required this.newPassword});

  @override
  List<Object?> get props => [newPassword];
}

class CheckSecurityCodeEvent extends ForgetPassEvent {
  final String securityCode;
  const CheckSecurityCodeEvent(this.securityCode);
  @override
  List<Object?> get props => [securityCode];
}
