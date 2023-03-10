import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:fireblogs/screens/option_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    final user = auth.currentUser;
    if (user != null) {
      Future.delayed(Duration(seconds: 3), () {
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OptionScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
            '= MYWALL =',
            style: TextStyle(fontSize: 35, fontFamily: 'MultiR'),
      ),
      )
    );
  }
}
