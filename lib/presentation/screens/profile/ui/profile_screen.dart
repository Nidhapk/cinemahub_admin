import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/screens/drawer.dart';
import 'package:onlinebooking_adminside/presentation/screens/forget_password/forget_pass.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/about_us/about_us_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/change_password/ui/change_password.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/widget/ontap_container.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_mainappbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKeyyy = GlobalKey<ScaffoldState>();
    //final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKeyyy,
      appBar: HomeAppBar(
        title: 'Profile',
        onPressed: () {
          scaffoldKeyyy.currentState?.openDrawer();
        },
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          onTapContainer(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()));
              },
              context: context,
              title: 'Change password',
              icon: Icons.lock_reset_outlined,
              color: green),
          onTapContainer(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
              context: context,
              title: 'About us',
              icon: Icons.info_outline,
              color: Colors.indigo),
          onTapContainer(
              onTap: () {},
              context: context,
              title: 'Privacy policy',
              icon: Icons.privacy_tip_rounded,
              color: const Color.fromARGB(255, 132, 127, 127)),
          onTapContainer(
              onTap: () {},
              context: context,
              title: 'LogOut',
              icon: Icons.logout_sharp,
              color: const Color.fromARGB(255, 209, 89, 80))
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
