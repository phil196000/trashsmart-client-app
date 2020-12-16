import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashsmart/Constants/colors.dart';
import 'package:trashsmart/DartAssets/ForgotImage.dart';

class ForgotPassword extends StatefulWidget {
  final scaffoldKeySignIn;

  const ForgotPassword({Key key, this.scaffoldKeySignIn}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool reset = false;
  Map<String, dynamic> emailError = {'visible': false, 'message': null};
  Map<String, dynamic> resetState = {'visible': false, 'message': ''};

  final _emailController = new TextEditingController();
  void forgotPassword(String email) {
    setState(() {
      reset = true;
    });
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      setState(() {
        reset = false;
        resetState = {
          'visible': true,
          'message': 'Password reset email sent, check your email'
        };
      });
    }).catchError((onError) {
      setState(() {
        reset = false;
        resetState = {'visible': true, 'message': 'Failed to send reset email'};
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 15, bottom: 10),
                        child: ForgotImage(),
                      ),
                      Positioned(
                          top: -10,
                          right: 0,
                          child: Container(
                            child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ))
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
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
                      errorText:
                          emailError['visible'] ? emailError['message'] : null,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: accent)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: accent)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)))),
                ),
              ),
              Visibility(
                  visible: resetState['visible'],
                  child: Text(
                    resetState['message'],
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.bold),
                  )),
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
                          _emailController.text.length > 6) {
                        setState(() {
                          emailError = {'visible': false, 'message': null};
                        });
                        forgotPassword(
                            _emailController.text.toLowerCase().trim());
                      } else {
                        setState(() {
                          emailError = {'visible': false, 'message': null};
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
                            'message': 'Email must be more that 7 characters'
                          };
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 57, vertical: 17),
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
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            visible: reset,
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ))),
    ]);
  }
}
