import 'package:flutter/material.dart';
import 'package:rhythmix/screens/about.dart';
import 'package:rhythmix/screens/privacy_policy.dart';
import 'package:rhythmix/screens/terms.dart';
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
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Privacy();
                }));
              },
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
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset('asset/policy.jpg'),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text('privacy policy',
                        style: TextStyle(
                          fontSize: 24,
                        ))
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black, height: 0),
            InkWell(
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
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset('asset/rate.jpg'),
              ),
                 
                  SizedBox(
                    width: 12,
                  ),
                  Text('feedback',
                      style: TextStyle(
                        fontSize: 24,
                      ))
                ],
              ),
            )),
            Divider(color: Colors.black, height: 0),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Terms();
                }));
              },
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset('asset/terms and contition.png'),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text('terms and conditions',
                        style: TextStyle(
                          fontSize: 24,
                        ))
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black, height: 0),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return about();
                }));
              },
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
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset('asset/aboutus.jpg'),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text('About us',
                        style: TextStyle(
                          fontSize: 24,
                        )),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black, height: 0),
          ],
        ),
      ),
    );
  }
}
