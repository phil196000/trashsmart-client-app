import 'dart:async';
import 'dart:developer';

// import 'package:academy/Screens/SignUp.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trashsmart/Components/Stepper.dart';
import 'package:trashsmart/Constants/colors.dart';

import 'package:trashsmart/DartAssets/SignUpImage.dart';
import 'package:trashsmart/Screens/dashboard/dashboard.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _passwordController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _fullNameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String email;
  String password;
  String token;
  Map<String, dynamic> emailError = {'visible': false, 'message': null};
  Map<String, dynamic> netWorkError = {'visible': false, 'message': ''};

  bool passwordError = false;
  bool fullNameError = false;
  bool visible = true;
  bool indicator = false;
  @override
  void initState() {
    super.initState();
  }

  void createAccount(String email, String password, String fullname) async {
    setState(() {
      indicator = true;
    });
    DateTime now = new DateTime.now();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        FirebaseFirestore.instance.collection('users').doc().set({
          'full_name': fullname,
          'email': email,
          'created_at': now,
          'subscribed': false,
          'role': 'user',
          'image_url': ''
        }).then((value) {
          // log('success');
          setState(() {
            indicator = false;
          });
          _loginCredentials();
          Timer(Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBoard(),
                ),
                (route) => false);
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Container(
              // color: Colors.yellow,
              child: Text('Account created successfully'),
            ),
            duration: Duration(milliseconds: 2000),
          ));
        }).catchError((error) {
          setState(() {
            indicator = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Container(
              // color: Colors.yellow,
              child: Text('$error'),
            ),
            duration: Duration(milliseconds: 2000),
          ));
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        indicator = false;
      });
      if (e.code == 'weak-password') {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            // color: Colors.yellow,
            child: Text('The password provided is too weak.'),
          ),
          duration: Duration(milliseconds: 2000),
        ));
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            // color: Colors.yellow,
            child: Text('The account already exists for that email.'),
          ),
          duration: Duration(milliseconds: 2000),
        ));
      }
    } catch (e) {
      print(e);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Container(
          // color: Colors.yellow,
          child: Text(e),
        ),
        duration: Duration(milliseconds: 2000),
      ));
    }
  }

  Future<void> _loginCredentials() async {
    final SharedPreferences prefs = await _prefs;
    final String counter = (prefs.getString('email') ?? 'Hello');
    prefs
        .setString(
          "email",
          _emailController.text.toLowerCase().trim(),
        )
        .then((value) => prefs
            .setString(
              "password",
              _passwordController.text,
            )
            .then((value) => log('success')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                  flex: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 45),
                    child: Column(
                      children: [
                        SignUpImage(),
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
                            controller: _fullNameController,
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
                                labelText: 'Full Name',
                                errorText: fullNameError
                                    ? 'Full Name must be more than 3 characters'
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
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: RaisedButton(
                                color: primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  if (_fullNameController.text.length > 2 &&
                                      _emailController.text.contains('.') &&
                                      _emailController.text.contains('@') &&
                                      _emailController.text.length > 6 &&
                                      _passwordController.text.length > 7) {
                                    setState(() {
                                      fullNameError = false;
                                      emailError = {
                                        'visible': false,
                                        'message': null
                                      };
                                      passwordError = false;
                                    });
                                    createAccount(
                                        _emailController.text
                                            .toLowerCase()
                                            .trim(),
                                        _passwordController.text,
                                        _fullNameController.text.trim());
                                  } else {
                                    setState(() {
                                      fullNameError = false;
                                      emailError = {
                                        'visible': false,
                                        'message': null
                                      };
                                      passwordError = false;
                                    });
                                  }
                                  setState(() {
                                    if (_fullNameController.text.length < 3) {
                                      fullNameError = true;
                                    } else {}
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

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => DashBoard(),
                                  //     ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 17),
                                  width: 130,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Create',
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
                              ),
                            ))
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        child: Stack(
                          overflow: Overflow.visible,
                          // alignment: Alignment.center,
                          children: [
                            RotatedBox(
                              quarterTurns: 6,
                              child: SvgPicture.string(
                                '<svg viewBox="-40.7 -0.1 415.7 46.1" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 375.0, 50.91)" d="M 148.0453491210938 4.9149169921875 L 415.740478515625 51 L 0 51 L 148.0453491210938 4.9149169921875 Z" fill="#000000" fill-opacity="0.15" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                            Positioned(
                                bottom: 10,
                                left: 15,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: IconButton(
                                      color: Colors.white,
                                      iconSize: 20,
                                      icon: Icon(Icons.chevron_left),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ))
                            // Positioned(
                            //     bottom: 10,
                            //     left: MediaQuery.of(context).size.width * 0.3,
                            //     child: Container(
                            //       width: 70,
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           AnimatedOpacity(
                            //             opacity: 1,
                            //             duration: Duration(milliseconds: 500),
                            //             child: SizedBox(
                            //               width: 15,
                            //               height: 15,
                            //               child: StepperIcon(),
                            //             ),
                            //           ),
                            //           SvgPicture.string(
                            //             '<svg viewBox="133.5 797.5 23.0 1.0" ><path transform="translate(133.5, 797.5)" d="M 0 0 L 23 0" fill="none" stroke="#000000" stroke-width="1" stroke-dasharray="5 5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            //             allowDrawingOutsideViewBox: true,
                            //             fit: BoxFit.fill,
                            //           ),
                            //           AnimatedOpacity(
                            //             opacity: 1,
                            //             duration: Duration(milliseconds: 500),
                            //             child: SizedBox(
                            //               width: 15,
                            //               height: 15,
                            //               child: StepperIcon(),
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     ))
                          ],
                        ),
                        top: 0,
                      )
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
