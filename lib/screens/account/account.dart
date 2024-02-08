import 'package:flutter/material.dart';
import 'package:rhythmix/screens/account/about.dart';
import 'package:rhythmix/screens/account/privacy_policy.dart';
import 'package:rhythmix/screens/account/terms.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatelessWidget {
  const Account({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            buildMenuItem(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Privacy();
                }));
              },
              icon: 'asset/policy.jpg',
              title: 'Privacy Policy',
            ),
            buildMenuItem(
              onTap: () async {
                final String email = 'hashimmuhammad838@gmail.com';
                final String subject = 'Feedback for Rhythmix App';
                final String emailUrl = 'mailto:$email?subject=$subject';

                try {
                  await launch(emailUrl);
                } catch (e) {
                  // Handle error
                  print('Could not launch email: $e');
                }
              },
              icon: 'asset/rate.jpg',
              title: 'Feedback',
            ),
            buildMenuItem(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Terms();
                }));
              },
              icon: 'asset/terms and contition.png',
              title: 'Terms and Conditions',
            ),
            buildMenuItem(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return about();
                }));
              },
              icon: 'asset/aboutus.jpg',
              title: 'About Us',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required VoidCallback onTap,
    required String icon,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(
          height: 60,
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(icon),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
