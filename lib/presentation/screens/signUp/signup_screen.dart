// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/methods/methods.dart';
import 'package:onlinebooking_adminside/presentation/screens/signUp/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/signUp/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/signUp/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_snackbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_adminside/presentation/widgets/rowone.dart';
import 'package:onlinebooking_adminside/presentation/widgets/sizedbox_one.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final securityCodeController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(false);
    ValueNotifier<bool> obscureTextNotifier2 = ValueNotifier<bool>(false);

    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: 'User registered successfully',
                icon: Icons.check_circle_outline,
                iconColor: green,
                borderColor: green,
              ),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/splash', (context) => false);
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: state.error,
                icon: Icons.error_outline,
                iconColor: red,
                borderColor: red,
              ),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/splash', (context) => false);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBoxOne(),
                CustomTextForm(
                  controller: emailController,
                  hintText: 'enter your email',
                  labelText: 'email',
                  obscureText: false,
                  validator: emailValidator,
                ),
                const SizedBoxOne(),
                ValueListenableBuilder(
                  valueListenable: obscureTextNotifier,
                  builder: (context, value, _) {
                    return CustomTextForm(
                      controller: passwordController,
                      hintText: 'Enter your password',
                      labelText: 'password',
                      obscureText: obscureTextNotifier.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureTextNotifier.value =
                              !obscureTextNotifier.value;
                        },
                        icon: Icon(
                          value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 19,
                        ),
                      ),
                      validator: passwordValidator,
                    );
                  },
                ),
                const SizedBoxOne(),
                ValueListenableBuilder(
                  valueListenable: obscureTextNotifier2,
                  builder: (context, value, _) {
                    return CustomTextForm(
                      controller: confirmPasswordController,
                      hintText: 'Enter your password',
                      labelText: 'password',
                      obscureText: obscureTextNotifier2.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureTextNotifier2.value =
                              !obscureTextNotifier2.value;
                        },
                        icon: Icon(
                          value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 19,
                        ),
                      ),
                      validator: (value) => confirmPassValidator(
                        value,
                        passwordController.text.trim(),
                      ),
                    );
                  },
                ),
                const SizedBoxOne(),
                CustomTextForm(
                  keyboardType: TextInputType.number,
                  controller: securityCodeController,
                  hintText: 'enter your securityCode',
                  labelText: 'securityCode',
                  obscureText: false,
                  validator: (value) => securityCodeValidator(value),
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<SignUpBloc>().add(
                              UserRegisterEvent(
                                emailController.text.trim(),
                                passwordController.text.trim(),securityCodeController.text.trim()
                              ),
                            );
                      }
                    },
                    child: const Text('Sign up'),
                  ),
                ),
                const SizedBoxOne(),
                RowOne(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signIn', (context) => false);
                    },
                    text: 'Sign in',
                    textTwo: 'Already  have an account ?  ')
              ],
            ),
          );
        },
      ),
    );
  }
}
