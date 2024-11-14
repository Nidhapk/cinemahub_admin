import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/methods/methods.dart';
import 'package:onlinebooking_adminside/presentation/screens/forget_password/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/forget_password/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/forget_password/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_snackbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_adminside/presentation/widgets/sizedbox_one.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPassController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
      body: BlocListener<ForgetPassBloc, ForgetPassState>(
        listener: (context, state) {
          if (state is SecurityCcodeCodeSuccessState) {
            bool isCorrect = state.status;
            if (isCorrect == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  text: 'Incorrect securitycode',
                  icon: Icons.check_circle_outlined,
                  iconColor: Colors.red,
                  borderColor: Colors.red,
                ),
              );
            } else {
              context.read<ForgetPassBloc>().add(ResetPasswordEvent(
                  newPassword: passwordController.text.trim()));
            }
          } else if (state is ForgetPassEmailSendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: 'password has been successfully reseted',
                icon: Icons.check_circle_outlined,
                iconColor: Colors.green,
                borderColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else if (state is ForgetPassEmailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: state.error,
                icon: Icons.error_outline_outlined,
                iconColor: Colors.red,
                borderColor: Colors.red,
              ),
            );
          }
        },
        child: Form(
          key: ForgetPassScreen.formKey,
          child: ListView(
            children: [
              const SizedBoxOne(),
              const Text(
                'Write the security code ',
                textAlign: TextAlign.center,
              ),
              const SizedBoxOne(),
              CustomTextForm(
                  keyboardType: TextInputType.number,
                  controller: emailController,
                  hintText: 'Enter the security code',
                  labelText: 'security code',
                  obscureText: false,
                  validator: (value) => securityCodeValidator(value)
                  //return null;

                  ),
              const SizedBox(
                height: 20,
              ),
              CustomTextForm(
                // keyboardType: TextInputType.number,
                controller: passwordController,
                hintText: 'Enter new passowrd',
                labelText: 'password',
                obscureText: false,
                validator: (value) => passwordValidator(value),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextForm(
                //  keyboardType: TextInputType.number,
                controller: confirmPassController,
                hintText: 'confirm password',
                labelText: 'confirm password',
                obscureText: false,
                validator: (value) =>
                    confirmPassValidator(value, passwordController.text.trim()),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                child: ElevatedButton(
                  onPressed: () {
                    if (ForgetPassScreen.formKey.currentState!.validate()) {
                      context.read<ForgetPassBloc>().add(
                            CheckSecurityCodeEvent(
                              emailController.text.trim(),
                            ),
                          );
                    }
                  },
                  child: const Text('Send'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
