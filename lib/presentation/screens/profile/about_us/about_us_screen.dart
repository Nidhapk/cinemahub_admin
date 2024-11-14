import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(width * 0.05),
        children: [
          const Text(
            'CinemaHub',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const Text(
            'Verson 1.0',
            style: TextStyle(
                color: Color.fromARGB(255, 149, 148, 148),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: width * 0.05,
          ),
          const Text(
              'Welcome to the Admin Panel of CinemaHub, the dedicated platform designed for admin panel. CinemaHub Admin provides the details of movies, ensuring that every update reaches your audience efficiently and accurately.')
        ],
      ),
    );
  }
}
