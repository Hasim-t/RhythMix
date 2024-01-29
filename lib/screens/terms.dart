import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

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
    Terms and Conditions

Last Updated: [Date]

Welcome to Rhythmix!

These Terms and Conditions ("Terms") govern your use of the Rhythmix mobile application ("App"). By using the App, you agree to comply with and be bound by these Terms. If you do not agree with these Terms, please refrain from using the App.

1. Acceptance of Terms
   By using Rhythmix, you agree to these Terms, our Privacy Policy, and any additional terms provided within the App.

2. Storage Access
   Rhythmix requires access to your device's storage to fetch and play music files stored on your device. By using the App, you grant us permission to access your storage for this purpose.

3. User Responsibilities
   You are responsible for maintaining the confidentiality of your account and password. You agree to provide accurate and current information when using the App. You also agree not to engage in any illegal or unauthorized activities while using the App.

4. Intellectual Property
   All content and materials available in the App, including but not limited to text, graphics, logos, and images, are the property of Rhythmix and are protected by intellectual property laws. You may not use, reproduce, modify, or distribute any content from the App without our prior written consent.

5. Limitation of Liability
   Rhythmix is provided "as is" without any warranty of any kind. We are not liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use or inability to use the App.

6. Changes to Terms
   We reserve the right to update or modify these Terms at any time without prior notice. It is your responsibility to review the Terms periodically for changes. Your continued use of the App after changes to the Terms constitutes acceptance of those changes.

7. Governing Law
   These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction]. Any disputes arising under or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts located in [Your Jurisdiction].

If you have any questions or concerns regarding these Terms and Conditions, please contact us at [Your Contact Email].

Thank you for using Rhythmix!

   
    ''',style: TextStyle(),),
      ),
    ),
    ));
  }
}