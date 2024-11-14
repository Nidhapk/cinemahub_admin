import 'package:equatable/equatable.dart';

abstract class SplashScreenStates extends Equatable {
  const SplashScreenStates();

  @override
  List<Object> get props => [];
}

final class SplashScreenInitialState extends SplashScreenStates {}

class SplashScreenLoginCheckingState extends SplashScreenStates {}

class SplashScreenLoginCheckingErrorState extends SplashScreenStates {
  final String message;
  const SplashScreenLoginCheckingErrorState(this.message);
}

class SplashScreenEmailVerificationCheckState extends SplashScreenStates {}

class SplashScreenSendEmailVerificationState extends SplashScreenStates {}

class SplashScreenNavigateToHomeScreenState extends SplashScreenStates {
  const SplashScreenNavigateToHomeScreenState();
  @override
  List<Object> get props => [];
}

class SplashScreenNavigateToLoginScreenState extends SplashScreenStates {
  SplashScreenNavigateToLoginScreenState();
  @override
  List<Object> get props => [];
}