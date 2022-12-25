import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/screens/addblog_screen.dart';
import 'package:fireblogs/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _onclicked = true;

  final firecollection =
      FirebaseFirestore.instance.collection('Blogs').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: firecollection,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Internal Server Error'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            //color: Colors.teal
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Image(
                                  height: 100,
                                  width: double.infinity,
                                  image: NetworkImage(
                                      snapshot.data!.docs[index]["imgUrl"]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data!.docs[index]["title"],
                                  style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontSize: 19),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data!.docs[index]["desc"],
                                  style: TextStyle(
                                      color: Colors.teal, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(onPressed: () {
                                      setState(() {
                                        _onclicked = !_onclicked;
                                      });
                                    }, icon: Icon((_onclicked == false) ? Icons.thumb_up : Icons.thumb_up_outlined)),
                                    SizedBox(width: 90),
                                    Text(
                                      snapshot.data!.docs[index]["time"],
                                      style: TextStyle(
                                          color: Colors.blueAccent, fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddBlogScreen()));
            },
            child: Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.orangeAccent,
          index: 0,
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
      backgroundColor: Colors.white,
      textColor: Colors.red,
      fontSize: 16.0,
    );
  }

  deletedata() async {

  }
}
