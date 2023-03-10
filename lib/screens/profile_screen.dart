import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:fireblogs/screens/option_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: Icon(Icons.person, size: 150,)
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email: ${auth.currentUser!.email.toString()}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      auth.signOut().then((value) {
                        showToast("You have been signed out");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OptionScreen()));
                      }).catchError((error) {});
                    },
                    child: Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                          child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.orangeAccent,
          onTap: (index) {
            if (index == 0)
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            else
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfileScreen()));
          },
          items: [
            Icon(Icons.menu),
            Icon(Icons.person),
          ],
        ));
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }
}
