import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/signUp/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/signUp/bloc/bloc_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<UserRegisterEvent>(signUpRequested);
  }

  Future<void> signUpRequested(
      UserRegisterEvent event, Emitter<SignUpState> emit) async {
    emit(
      SignUpInProgress(),
    );
    try {
      await FirebaseFirestore.instance
          .collection('admin')
          .add({'userName': event.userName, 'password': event.password,'securitycode':event.securityCode});

             // Set 'isLoggedIn' to true in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
      emit(
        SignUpSuccess(),
      );
    
    } on FirebaseAuthException catch (_) {
      // switch (e.code) {
      //   case 'email-already-in-use':
      //     emit(
      //       SignUpFailure(
      //           'The email address is already in use by another account.'),
      //     );
      //     break;
      //   case 'invalid-email':
      //     emit(
      //       SignUpFailure('The email address is not valid.'),
      //     );
      //     break;
      //   default:
      //     emit(
      //       SignUpFailure('An unknown error occurred: ${e.message}'),
      //     );
      //     break;
      // }

      rethrow;
    } on SocketException {
      emit(
        SignUpFailure(
            'No internet connection. Please check your network settings.'),
      );
    } on TimeoutException {
      emit(
        SignUpFailure('The request timed out. Please try again later.'),
      );
    } catch (e) {
      emit(
        SignUpFailure('An unexpected error occurred: $e'),
      );
    }
  }
}
