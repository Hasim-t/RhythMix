import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(130, 53, 102, 186),

      body: SafeArea(
        child: Column(
        children: [
             Container(
              height: 60,
              color: const Color.fromARGB(130, 53, 102, 186),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                     decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)
                     ),
                     child: Image.asset('asset/policy.jpg'),
                  ),
                     SizedBox(
                      width: 12,
                     ),
                  Text('privacy policy',style: TextStyle(fontSize: 24,))
                ],
              ),
            ),
            Divider(color: Colors.black,height: 0),
             Container(
              height: 60,
              color: const Color.fromARGB(130, 53, 102, 186),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                     decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)
                     ),
                     child: Image.asset('asset/rate.jpg'),
                  ),
                     SizedBox(
                      width: 12,
                     ),
                  Text('Rate us',style: TextStyle(fontSize: 24,))
                ],
              ),
            ),
             Divider(color: Colors.black,height: 0),
             Container(
              height: 60,
              color: const Color.fromARGB(130, 53, 102, 186),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                     decoration: BoxDecoration(
                     
                      borderRadius: BorderRadius.circular(30)
                     ),
                     child: Image.asset('asset/terms and contition.png'),
                  ),
                     SizedBox(
                      width: 12,
                     ),
                  Text('terms and conditions',style: TextStyle(fontSize: 24,))
                ],
              ),
            ),
             Divider(color: Colors.black,height: 0),
             Container(
              height: 60,
              color: const Color.fromARGB(130, 53, 102, 186),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                     decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)
                     ),
                     child: Image.asset('asset/recorder.jpg'),
                  ),
                     SizedBox(
                      width: 12,
                     ),
                  Text('Audio recorder',style: TextStyle(fontSize: 24,))
                ],
              ),
            ),
             Divider(color: Colors.black,height: 0),
             Container(
              height: 60,
              color:  Color.fromARGB(130, 53, 102, 186),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                     decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)
                     ),
                     child: Image.asset('asset/aboutus.jpg'),
                  ),
                     SizedBox(
                      width: 12,
                     ),
                  Text('About us',style: TextStyle(fontSize: 24,))
                ],
              ),
            ),
        ],
        ),
      ),
    );
  }
}