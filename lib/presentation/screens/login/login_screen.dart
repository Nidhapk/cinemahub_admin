import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/methods/methods.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_snackbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_adminside/presentation/widgets/rowone.dart';
import 'package:onlinebooking_adminside/presentation/widgets/sizedbox_one.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context.read<SignInBloc>().add(const AdminExistEvent());
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(true);
    return Scaffold(
      body: BlocListener<SignInBloc, SigInState>(
        listener: (context, state) {
          if (state is SigInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: 'Successfully loged in',
                icon: Icons.check_circle_outline,
                iconColor: green,
                borderColor: green,
              ),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/splash', (context) => false);
          } else if (state is SigInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                text: state.message,
                icon: Icons.error_outline,
                iconColor: red,
                borderColor: red,
              ),
            );
          }
        },
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Center(
                child: Text(
                  'Sign In',
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
                        obscureTextNotifier.value = !obscureTextNotifier.value;
                      },
                      icon: Icon(
                        value
                            ? Icons.visibility_off_outlined
                            : Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                        size: 19,
                      ),
                    ),
                    validator: passwordValidator,
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.6),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/forgetPass');
                  },
                  child: const Text(
                    'Forget password ? ',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: indigo,
                        fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SignInBloc>().add(
                            SignInRequested(emailController.text.trim(),
                                passwordController.text.trim(), context),
                          );
                    }
                  },
                  child: const Text('Sign in'),
                ),
              ),
              const SizedBoxOne(),
              // const CustomDivider(),
              const SizedBoxOne(),
              // const CustomGoogleButton(),
              const SizedBoxOne(),
              BlocBuilder<SignInBloc, SigInState>(
                builder: (context, state) {
                  if (state is AdminExistSuccess) {
                    bool isAdminExist = state.isExist;
                    if (isAdminExist == false) {
                      return RowOne(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/signUp', (context) => false);
                          },
                          text: 'Sign up',
                          textTwo: 'Don\'t have an account ?  ');
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return SizedBox.fromSize();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
