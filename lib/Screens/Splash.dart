import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:academy/Screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashsmart/Screens/Home.dart';
import 'package:trashsmart/Screens/SignIn.dart';

import 'dashboard/dashboard.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<FirebaseApp> _initialization;
  final _scaffoldKeySplash = GlobalKey<ScaffoldState>();
  bool indicator = true;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
    _initialization.then((value) {
      _prefs.then((SharedPreferences prefs) {
        // log(prefs.getString('password') ?? 'i didnt work');
        var email = prefs.getString('email') ?? null;
        var password = prefs.getString('password') ?? null;
        if (password != null && email != null) {
          signIn(email, password);
        } else {
          new Timer(const Duration(seconds: 3), () {
            _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Container(
                // color: Colors.yellow,
                child: Text('Failed to sign in automatically'),
              ),
              duration: Duration(milliseconds: 2000),
            ));
            Timer(Duration(seconds: 2), () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                  (route) => false);
            });
          });
        }
      }).catchError((error) {
        new Timer(const Duration(seconds: 3), () {
          _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Container(
              // color: Colors.yellow,
              child: Text('Failed to sign in automatically'),
            ),
            duration: Duration(milliseconds: 2000),
          ));
          Timer(Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
                (route) => false);
          });
        });
      });
    });

    // new Timer(const Duration(seconds: 3), () {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => SignIn(),
    //       ));
    // });
  }

  void signIn(String email, String password) async {
    setState(() {
      indicator = true;
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get()
            .then((value) {
          setState(() {
            indicator = false;
          });
          if (value.docs.isNotEmpty) {
            value.docs.forEach((element) {
              // _loginCredentials();

              Timer(Duration(seconds: 2), () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashBoard(
                              id: element.id,
                            )),
                    (route) => false);
              });
              _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Container(
                  // color: Colors.yellow,
                  child: Text('Sign in successful, welcome back'),
                ),
                duration: Duration(milliseconds: 2000),
              ));
            });
          } else {
            Timer(Duration(seconds: 2), () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                  (route) => false);
            });
            _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Container(
                // color: Colors.yellow,
                child: Text('User cannot be found, create account'),
              ),
              duration: Duration(milliseconds: 2000),
            ));
          }
        }).catchError((onError) {
          _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Container(
              // color: Colors.yellow,
              child: Text('An error occurred, try again'),
            ),
            duration: Duration(milliseconds: 2000),
          ));
        });
        // Timer(Duration(seconds: 2), () {
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => DashBoard(),
        //       ),
        //       (route) => false);
        // });
        // _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
        //   backgroundColor: Colors.green,
        //   content: Container(
        //     // color: Colors.yellow,
        //     child: Text('Sign in successful, welcome back'),
        //   ),
        //   duration: Duration(milliseconds: 2000),
        // ));
      } else {}
    } on FirebaseAuthException catch (e) {
      setState(() {
        indicator = false;
      });
      Timer(Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ),
            (route) => false);
      });
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            // color: Colors.yellow,
            child: Text('No user found for that email. Create an account'),
          ),
          duration: Duration(milliseconds: 2000),
        ));
      } else if (e.code == 'wrong-password') {
        _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            // color: Colors.yellow,
            child: Text('Wrong password, try again'),
          ),
          duration: Duration(milliseconds: 2000),
        ));
      } else {
        _scaffoldKeySplash.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            // color: Colors.yellow,
            child: Text(e.code),
          ),
          duration: Duration(milliseconds: 2000),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Error Occurred");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            key: _scaffoldKeySplash,
            body: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              height: 180,
                              image: AssetImage(
                                'lib/assets/logo.png',
                              )),
                          indicator
                              ? Container(
                                  // margin: EdgeInsets.only(top: 15),
                                  width: 100,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.black,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Positioned(
                        // alignment: Alignment.topCenter,
                        bottom: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('By:'),
                            Text(
                              'TrashSmart',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(17, 105, 57, 1)),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: Container(
                width: 50, height: 50, child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
