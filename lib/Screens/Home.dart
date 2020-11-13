import 'dart:async';

// import 'package:academy/Screens/SignUp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:trashsmart/Components/Stepper.dart';
import 'package:trashsmart/Constants/colors.dart';

import 'package:trashsmart/DartAssets/SignUpImage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _passwordController = new TextEditingController();
  final _emailController = new TextEditingController();
  String email;
  String password;
  String token;
  Map<String, dynamic> emailError = {'visible': false, 'message': null};
  Map<String, dynamic> netWorkError = {'visible': false, 'message': ''};

  bool passwordError = false;
  bool visible = true;
  bool indicator = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                onPressed: () {},
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
                                        visible: false,
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
