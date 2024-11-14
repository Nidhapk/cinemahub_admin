import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/splash/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/splash/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/splash/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/screens/verify_screen.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_alertbox.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashScreenbloc>().add(CheckLoginEvent());
    return BlocListener<SplashScreenbloc, SplashScreenStates>(
      listener: (context, state) {
        if (state is SplashScreenNavigateToHomeScreenState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (context) => false);
        } else if (state is SplashScreenNavigateToLoginScreenState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/signIn', (context) => false);
        } else if (state is SplashScreenEmailVerificationCheckState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    VerifyScreen(user: FirebaseAuth.instance.currentUser),
              ),
              (context) => false);
        }
      },
      child: Scaffold(
        body: BlocBuilder<SplashScreenbloc, SplashScreenStates>(
          builder: (context, state) {
            if (state is SplashScreenLoginCheckingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SplashScreenLoginCheckingErrorState) {
              return CustomAlertBox(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  title: 'Alert',
                  content: 'An error ocuured,Try again later',
                  confirmText: 'Ok');
            } else {
              return const Center(
                child: Text('WELCOME'),
              );
            }
          },
        ),
      ),
    );
  }
}
