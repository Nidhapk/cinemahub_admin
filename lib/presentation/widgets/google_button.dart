import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/data/repository/user_auth_repository.dart';

class CustomGoogleButton extends StatelessWidget {
  const CustomGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ElevatedButton(
        onPressed: () async {
          await UserAuthRepository().signInWithGoogle().then((value) =>
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/splash', (context) => false));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/search.png',
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 30,
            ),
            const Text('Sign in with Google'),
          ],
        ),
      ),
    );
  }
}
