import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends SignInEvent {
  final String email;
  final String password;
  final BuildContext context;

  const SignInRequested(this.email, this.password, this.context);

  @override
  List<Object> get props => [email, password];
}

class AdminExistEvent extends SignInEvent {
  const AdminExistEvent();

  @override
  List<Object> get props => [];
}
