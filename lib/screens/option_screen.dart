import 'package:fireblogs/components/button.dart';
import 'package:fireblogs/screens/login_screen.dart';
import 'package:fireblogs/screens/register_screen.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('= MYWALL =', style: TextStyle(fontFamily: 'MultiR', fontSize: 45)),
            ),
            Text(
              'We offer you a great alternative to other blogging services',
              style: TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 120,
            ),
            MyButton(
                title: 'Register',
                onpress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen()));
                }),
            SizedBox(
              height: 15,
            ),
            MyButton(
                title: 'Login',
                onpress: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
