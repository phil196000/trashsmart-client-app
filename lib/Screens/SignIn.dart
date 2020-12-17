import 'dart:async';
import 'dart:developer';

// import 'package:academy/Screens/SignUp.dart';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashsmart/Components/DarkGreen.dart';
import 'package:trashsmart/Constants/colors.dart';
import 'package:trashsmart/DartAssets/LoginImage.dart';
import 'package:trashsmart/Screens/ForgotPassword.dart';
import 'package:trashsmart/Screens/SignUp.dart';
import 'package:trashsmart/Screens/dashboard/dashboard.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _passwordController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _scaffoldKeySignIn = GlobalKey<ScaffoldState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String email;
  String password;
  String token;
  Map<String, dynamic> emailError = {'visible': false, 'message': null};
  Map<String, dynamic> netWorkError = {'visible': false, 'message': ''};
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool passwordError = false;
  bool visible = true;
  bool indicator = false;
  @override
  void initState() {
    super.initState();
  }

  void signIn(String email, String password) async {
    setState(() {
      indicator = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        setState(() {
          indicator = false;
        });
        // _loginCredentials();
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
              _loginCredentials();

              Timer(Duration(seconds: 2), () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashBoard(
                              id: element.id,
                            )),
                    (route) => false);
              });
              _scaffoldKeySignIn.currentState.showSnackBar(SnackBar(
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
            _scaffoldKeySignIn.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Container(
                // color: Colors.yellow,
                child: Text('User cannot be found, create account'),
              ),
              duration: Duration(milliseconds: 2000),
            ));
          }
        }).catchError((onError) {
          _scaffoldKeySignIn.currentState.showSnackBar(SnackBar(
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
        //         builder: (context) => DashBoard(id: ,),
        //       ),
        //       (route) => false);
        // });
        // _scaffoldKeySignIn.currentState.showSnackBar(SnackBar(
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
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _scaffoldKeySignIn.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            // color: Colors.yellow,
            child: Text('No user found for that email. Create an account'),
          ),
          duration: Duration(milliseconds: 2000),
        ));
      } else if (e.code == 'wrong-password') {
        _scaffoldKeySignIn.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            // color: Colors.yellow,
            child: Text('Wrong password, try again'),
          ),
          duration: Duration(milliseconds: 2000),
        ));
      } else {
        _scaffoldKeySignIn.currentState.showSnackBar(SnackBar(
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

  Future<void> _loginCredentials() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    final String counter = (_prefs.getString('email') ?? 'Hello');
    _prefs
        .setString(
          "email",
          _emailController.text.toLowerCase().trim(),
        )
        .then((value) => _prefs
            .setString(
              "password",
              _passwordController.text,
            )
            .then((value) => log('success')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeySignIn,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        child: SvgPicture.string(
                          '<svg viewBox="-40.7 -0.1 415.7 46.1" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 375.0, 50.91)" d="M 148.0453491210938 4.9149169921875 L 415.740478515625 51 L 0 51 L 148.0453491210938 4.9149169921875 Z" fill="#000000" fill-opacity="0.15" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                        ),
                        top: 0,
                      )
                    ],
                  )),
              Expanded(
                  flex: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        LoginImage(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: Text(
                              'Welcome, sign in to access \nour services',
                              style: TextStyle(
                                  color: primary, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            // onEditingComplete: () {},
                            // onSubmitted: (value) {},
                            controller: _emailController,
                            // onChanged: (value) {
                            //   this.setState(() {
                            //     email = value;
                            //   });
                            // },
                            style: TextStyle(
                              color: primary,
                            ),
                            decoration: InputDecoration(
                                labelStyle: TextStyle(color: primary),
                                contentPadding: EdgeInsets.only(
                                    left: 30, right: 30, top: 20, bottom: 20),
                                labelText: 'Email',
                                errorText: emailError['visible']
                                    ? emailError['message']
                                    : null,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: accent)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: accent)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: visible,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(color: primary),
                                contentPadding: EdgeInsets.only(
                                    left: 30, right: 30, top: 20, bottom: 20),
                                errorText: passwordError
                                    ? 'Password must be 8 characters or more'
                                    : null,
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      visible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    color: primary,
                                    onPressed: () {
                                      this.setState(() {
                                        visible = !visible;
                                      });
                                    }),
                                labelText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: accent)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: accent)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)))),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50))),
                                  enableDrag: false,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      child: ForgotPassword(
                                        scaffoldKeySignIn: _scaffoldKeySignIn,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: primary),
                                ),
                              )),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              color: primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => DashBoard(),
                                //     ));
                                if (_emailController.text.contains('.') &&
                                    _emailController.text.contains('@') &&
                                    _emailController.text.length > 6 &&
                                    _passwordController.text.length > 7) {
                                  setState(() {
                                    emailError = {
                                      'visible': false,
                                      'message': null
                                    };
                                    passwordError = false;
                                  });
                                  signIn(
                                      _emailController.text
                                          .toLowerCase()
                                          .trim(),
                                      _passwordController.text);
                                } else {
                                  setState(() {
                                    emailError = {
                                      'visible': false,
                                      'message': null
                                    };
                                    passwordError = false;
                                  });
                                }
                                setState(() {
                                  if (!_emailController.text.contains('.')) {
                                    emailError = {
                                      'visible': true,
                                      'message': 'Email must contain .'
                                    };
                                  }
                                  if (!_emailController.text.contains('@')) {
                                    emailError = {
                                      'visible': true,
                                      'message': 'Email must contain @'
                                    };
                                  }

                                  if (_emailController.text.length < 7) {
                                    emailError = {
                                      'visible': true,
                                      'message':
                                          'Email must be more that 7 characters'
                                    };
                                  }
                                  if (_passwordController.text.length < 8) {
                                    passwordError = true;
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 57, vertical: 17),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Visibility(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10),
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                      visible: indicator,
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 35.0,
                          height: 35.0,
                          child: Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 35.0, 35.0),
                                size: Size(35.0, 35.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xff116939),
                                  ),
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(12.0, 12.0, 12.0, 12.0),
                                size: Size(35.0, 35.0),
                                fixedWidth: true,
                                fixedHeight: true,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              // firestore.collection('users').doc().set({
                              //   'name': 'Philemon Gumah',
                              //   'email': 'gumah@gmail.com',
                              // }).then((value) {
                              //   log('success');
                              // }).catchError((error) => log('error'));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ));
                            },
                            child: Container(
                              child: DarkGreen(
                                  text: "Don't have an account? Create one",
                                  weight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
