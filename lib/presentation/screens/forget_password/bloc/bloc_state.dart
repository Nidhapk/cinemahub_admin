import 'package:equatable/equatable.dart';

abstract class ForgetPassState extends Equatable {
  const ForgetPassState();

  @override
  List<Object?> get props => [];
}

class ForgetPassInitial extends ForgetPassState {}

class ForgetPassLoading extends ForgetPassState {}

class ForgetPassEmailSendSuccess extends ForgetPassState {}

class ForgetPassEmailFailure extends ForgetPassState {
  final String error;

  const ForgetPassEmailFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SecurityCcodeCodeSuccessState extends ForgetPassState {
  final bool status;
 const  SecurityCcodeCodeSuccessState(this.status);
   @override
  List<Object?> get props => [status];
}
class SecurityCcodeCodeErrorState extends ForgetPassState {
  final String error;
 const  SecurityCcodeCodeErrorState(this.error);
   @override
  List<Object?> get props => [error];
}