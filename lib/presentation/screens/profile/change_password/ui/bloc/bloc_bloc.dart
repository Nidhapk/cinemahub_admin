import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/change_password/ui/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/change_password/ui/bloc/bloc_state.dart';

class ChangepasswordBloc
    extends Bloc<ChangepasswordEvents, ChangePasswordState> {
  ChangepasswordBloc()
      : super(
          const ChangePasswordInitialState(),
        ) {
    on<CheckcurrentPasswordEvent>(checkPassword);
    on<PasswordChangedEvent>(changePassword);
  }

  Future<void> checkPassword(CheckcurrentPasswordEvent event,
      Emitter<ChangePasswordState> emit) async {
    try {
      final bool =
          await UserAuthRepository().verifyAdminPassword(event.password);
      emit(PasswordCheckedSuccessState(bool));
    } catch (e) {
      emit(PasswordCheckedErrorState('error: $e'));
    }
  }

  Future<void> changePassword(
      PasswordChangedEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      await UserAuthRepository().updateAdminPassword(event.newPassword);
      emit(const PasswordchangedSuccesState());
    } catch (e) {
      emit(PasswordchangederrorState('Error:$e'));
    }
  }
}
