import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/constants/constants.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/tab_bar_screen/ui/tab_bar_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/login_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/ui/profile_screen.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_alertbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Image.asset(
            fit: BoxFit.contain,
            'assets/cinemhub_logo.png',
            height: height * 0.05,
            width: width * 0.5,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Text(
              'ADMIN PANEL',
              style: TextStyle(
                fontSize: width * 0.032,
                letterSpacing: width * 0.015,
                //wordSpacing: width * 0.016
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Divider(
            height: 0,
            color: Color.fromARGB(255, 248, 246, 246),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: Image.asset(
                  item.path,
                  height: 18,
                ),
                title: Text(item.title),
                onTap: () {
                  switch (item.title) {
                    // case 'Dashborad':
                    //   Navigator.of(context).pushNamed(
                    //     '/splash',
                    //   );
                    //   break;
                    case 'Movies':
                      context.read<MovieBloc>().add(FetchAllMoviesEvent());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TabBarScreen()));
                      // Navigator.of(context).pushNamed(
                      //   '/movieHome',
                      // );
                      break;
                    case 'Theatres':
                      Navigator.of(context).pushNamed(
                        '/theatreHome',
                      );
                      break;
                    // case 'Users':
                    //   Navigator.of(context).pushNamed(
                    //     '/userHome',
                    //   );
                    //   break;
                    case 'Profile':
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                      break;
                    case 'Logout':
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertBox(
                          title: 'Logout',
                          content:
                              'Are you sure you want to logout from this account ?',
                          confirmText: 'Ok',
                          onPressed: () async {
                            // await UserAuthRepository().signOut().then(
                            //       (value) => Navigator.of(context)
                            //           .pushNamedAndRemoveUntil(
                            //               '/splash', (context) => false),
                            //     );
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', false);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (context) => false);
                          },
                        ),
                      );

                      break;
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
