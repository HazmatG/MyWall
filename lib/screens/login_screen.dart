import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:fireblogs/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fireblogs/components/button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController recorveryEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('NICE TO SEE YOU AGAIN', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Text('LOG IN TO CONTINUE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  return value!.isEmpty ? 'This field is required' : null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: Colors.orange,
                    ),
                    hintText: 'Enter your email...',
                    labelText: 'Email',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  return value!.isEmpty ? 'This field is required' : null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      color: Colors.orange,
                    ),
                    hintText: 'Enter your password...',
                    labelText: 'Password',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                  title: 'Login',
                  onpress: () {
                    if (_formkey.currentState!.validate()) {
                      auth
                          .signInWithEmailAndPassword(
                              email: emailController.text.toString().trim(),
                              password:
                                  passwordController.text.toString().trim())
                          .then((value) {
                        showToast('You have signed in');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }).catchError((err) {
                        showToast(err.toString());
                      });
                    } else {
                      showToast('404 bad error');
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterScreen()));
              }, child: Text('Not registered yet?'))
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.blue,
      fontSize: 16.0,
    );
  }
}
