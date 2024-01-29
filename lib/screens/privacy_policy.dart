import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(232, 5, 122, 247),
              Color.fromARGB(255, 255, 255, 255)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Text('''
    
    Privacy Policy
    
    Last Updated: 29/01/2024
    
    Thank you for using Rhythmix! This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you use our music app.
    
    Information We Collect:
    
    Storage Access:
    We request access to your device's storage to fetch and play music files stored on your device.
    How We Use Your Information:
    
    Storage Access:
    We use the storage access permission solely to fetch and play music files from your device. We do not store, share, or process this information for any other purpose.
    Data Security:
    
    We prioritize the security of your information and employ industry-standard measures to protect it from unauthorized access, disclosure, alteration, and destruction.
    
    Data Sharing:
    
    We do not share your personal information, including the music files from your device, with third parties. Your data is used exclusively for the purpose of providing you with a seamless music experience.
    
    Third-Party Services:
    
    Rhythmix may integrate with third-party services for additional features or content. Please review the privacy policies of these third-party services, as they may have their own terms and conditions regarding data collection and usage.
    
    Children's Privacy:
    
    Rhythmix is not intended for individuals under the age of 13. We do not knowingly collect personal information from children. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us so that we can take appropriate action.
    
    Changes to this Privacy Policy:
    
    We reserve the right to update our Privacy Policy periodically. Please review this policy regularly for any changes. Your continued use of Rhythmix after any modifications to the Privacy Policy will constitute your acknowledgment of the changes and your consent to abide and be bound by the modified Privacy Policy.
    
    Contact Us:
    
    If you have any questions or concerns regarding this Privacy Policy, please contact us at [hashimmuhammad838@gamil.com].
    
    ''',style: TextStyle(),),
      ),
    ),
    ));
  }
}