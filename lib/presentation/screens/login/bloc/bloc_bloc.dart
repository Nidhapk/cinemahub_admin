import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/bloc/bloc_state.dart';

class SignInBloc extends Bloc<SignInEvent, SigInState> {
  SignInBloc() : super(SigInInitial()) {
    on<SignInRequested>(signinRequest);
    on<AdminExistEvent>(adminExist);
  }

  Future<void> adminExist(
      AdminExistEvent event, Emitter<SigInState> emit) async {
    try {
      final isExist = await UserAuthRepository().checkAdminExists();
      emit(AdminExistSuccess(isExist));
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}

Future<void> signinRequest(
    SignInRequested event, Emitter<SigInState> emit) async {
  emit(SigInButtonPressed());

  try {
    await UserAuthRepository().loginAdmin(event.email, event.password);
    // await UserAuthRepository()
    //     .sigin( event.email, event.password);

    emit(SigInSuccess());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email' || e.code == 'invalid-credential') {
      emit(
        const SigInFailure(message: 'Invalid email or password'),
      );
    } else if (e.code == 'network-request-failed') {
      emit(
        const SigInFailure(message: 'Network error : Try again later'),
      );
    } else {
      emit(
        const SigInFailure(message: 'An unexpected error occurred.'),
      );
    }
  } catch (e) {
    emit(
      SigInFailure(message: '$e'),
    );
  }
}
