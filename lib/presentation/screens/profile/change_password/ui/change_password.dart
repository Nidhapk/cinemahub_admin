import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/methods/methods.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/change_password/ui/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/change_password/ui/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/change_password/ui/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_buttom.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_snackbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_textform.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final oldPasswordcontroller = TextEditingController();
    final newPasswordcontroller = TextEditingController();
    final confirmPasswordcontroller = TextEditingController();
    return Scaffold(
      body: BlocConsumer<ChangepasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is PasswordCheckedSuccessState) {
            bool isCorrect = state.isCorrect;
            isCorrect == false
                ? ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                      text: 'Incorrect current password',
                      icon: Icons.check_circle_outlined,
                      iconColor: Colors.red,
                      borderColor: Colors.red,
                    ),
                  )
                : context.read<ChangepasswordBloc>().add(PasswordChangedEvent(
                    confirmPasswordcontroller.text.trim()));
          } else if (state is PasswordchangedSuccesState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: 'Password has been changed successfully',
                icon: Icons.check_circle_outlined,
                iconColor: Colors.green,
                borderColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else if (state is PasswordchangederrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: state.error,
                icon: Icons.check_circle_outlined,
                iconColor: red,
                borderColor: red,
              ),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              CustomTextForm(
                  // keyboardType: TextInputType.number,
                  controller: oldPasswordcontroller,
                  hintText: 'Enter the current password',
                  labelText: 'Current password',
                  obscureText: false,
                  validator: (value) => securityCodeValidator(value)),
              CustomTextForm(
                  //keyboardType: TextInputType.number,
                  controller: newPasswordcontroller,
                  hintText: 'Enter new password',
                  labelText: 'New password',
                  obscureText: false,
                  validator: (value) => passwordValidator(value)),
              CustomTextForm(
                // keyboardType: TextInputType.number,
                controller: confirmPasswordcontroller,
                hintText: 'Confirm password',
                labelText: 'Confirm password',
                obscureText: false,
                validator: (value) => confirmPassValidator(
                  value,
                  newPasswordcontroller.text.trim(),
                ),
              ),
              CustomButton(
                onPressed: () {
                  context.read<ChangepasswordBloc>().add(
                        CheckcurrentPasswordEvent(
                          oldPasswordcontroller.text.trim(),
                        ),
                      );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
