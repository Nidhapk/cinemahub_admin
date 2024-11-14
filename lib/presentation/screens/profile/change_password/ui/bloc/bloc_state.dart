import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  @override
  List<Object> get props => [];
}

class ChangePasswordInitialState extends ChangePasswordState {
  const ChangePasswordInitialState();
  @override
  List<Object> get props => [];
}

class PasswordCheckedSuccessState extends ChangePasswordState {
  final bool isCorrect;
  const PasswordCheckedSuccessState(this.isCorrect);
  @override
  List<Object> get props => [isCorrect];
}

class PasswordCheckedErrorState extends ChangePasswordState {
  final String error;
  const PasswordCheckedErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class PasswordchangedSuccesState extends ChangePasswordState {
  const PasswordchangedSuccesState();
  @override
  List<Object> get props => [];
}

class PasswordchangederrorState extends ChangePasswordState {
  final String error;
  const PasswordchangederrorState(this.error);
  @override
  List<Object> get props => [error];
}
