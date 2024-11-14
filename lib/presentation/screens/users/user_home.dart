import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/screens/drawer.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_mainappbar.dart';

class usersHomeScreen extends StatelessWidget {
  const usersHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKeyy = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: appBackgroundColor,
      key: scaffoldKeyy,
      appBar: HomeAppBar(
        title: 'Users',
        onPressed: () {
          scaffoldKeyy.currentState?.openDrawer();
        },
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 139, 138, 141)
                          .withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: const Offset(2, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Container(
                        width: 30,
                        height: 4,
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4 / 2),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.block,
                          color: red,
                          size: 10,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Blocked',
                          style: TextStyle(
                              color: red,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        SizedBox(
                          width: 148,
                        ),
                        Text(
                          'Registered on 01 Apr 24',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )
                      ],
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text(
                        'User name',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'abc@gmail.com',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    Divider(
                      height: 0,
                      thickness: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 240.0),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'View Details',
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          )),
                    )
                  ],
                ),
              ),
            );
          }),
      drawer: const CustomDrawer(),
    );
  }
}
