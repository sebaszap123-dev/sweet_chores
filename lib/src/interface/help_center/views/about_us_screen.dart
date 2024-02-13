import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'We are a couple from Mexico passionate about technology and creativity. I, as a software engineering student, bring technical expertise to our projects, while my girlfriend, with her innate vision and creativity, adds the artistic touch as a UI designer.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our Story',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Our journey began with a shared love for apps and a desire to create something of our own. While I'm completing my software engineering degree, my girlfriend's creativity knows no bounds, despite not having formal training in UI design. Together, we aspire to build more apps, invest in courses to enhance our skills, and strive for excellence in our daily work.",
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "We aim to establish our own brand and line of diverse apps, driven by our passion and commitment to continuous improvement. While app development is our hobby, we are dedicated to delivering high-quality products and value user feedback. We're excited to embark on this journey and welcome any questions or suggestions from our users!",
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
