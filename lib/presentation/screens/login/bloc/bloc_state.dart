import 'package:equatable/equatable.dart';

abstract class SigInState extends Equatable {
  const SigInState();

  @override
  List<Object> get props => [];
}

class SigInInitial extends SigInState {}

class SigInButtonPressed extends SigInState {}

class SigInSuccess extends SigInState {}

class SigInFailure extends SigInState {
  final String message;

  const SigInFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AdminExistSuccess extends SigInState {
  final bool isExist;

  const AdminExistSuccess(this.isExist);

  @override
  List<Object> get props => [isExist];
}
