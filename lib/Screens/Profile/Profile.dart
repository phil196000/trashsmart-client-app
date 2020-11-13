import 'package:flutter/material.dart';
import 'package:trashsmart/Components/BackButton.dart';
import 'package:trashsmart/Components/DarkGreen.dart';
import 'package:trashsmart/Components/background_overlay.dart';
import 'package:trashsmart/Constants/colors.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _passwordController = new TextEditingController();
  final _emailController = new TextEditingController();
  String email;
  String password;
  String token;
  bool edit = false;
  Map<String, dynamic> emailError = {'visible': false, 'message': null};
  Map<String, dynamic> netWorkError = {'visible': false, 'message': ''};

  bool passwordError = false;
  bool visible = true;
  bool indicator = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          BackgroundOverlay(),
          Column(
            children: [
              Container(
                // width: 35,
                margin: EdgeInsets.only(left: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: edit,
                      child: IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.close),
                          onPressed: () {
                            this.setState(() {
                              edit = !edit;
                            });
                          }),
                    ),
                    DarkGreen(
                      text: 'Profile',
                      weight: FontWeight.bold,
                      size: 20,
                    ),
                    Visibility(
                      visible: edit,
                      child: IconButton(
                          color: primary,
                          icon: Icon(Icons.check),
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 200),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: primary,
                            child: Text(
                              'PG',
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(
                              color: primary,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  width: 200,
                                  padding: EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: DarkGreen(text: 'Full Name'),
                                ),
                                labelStyle: TextStyle(color: primary),
                                contentPadding: EdgeInsets.only(
                                    left: 25, right: 10, top: 20, bottom: 20),
                                // labelText: 'Email',
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
                          margin: EdgeInsets.only(top: 15),
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(
                              color: primary,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  width: 200,
                                  padding: EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: DarkGreen(text: 'Phone Number'),
                                ),
                                labelStyle: TextStyle(color: primary),
                                contentPadding: EdgeInsets.only(
                                    left: 25, right: 10, top: 20, bottom: 20),
                                // labelText: 'Email',
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
                          margin: EdgeInsets.only(top: 15),
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(
                              color: primary,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  width: 200,
                                  padding: EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: DarkGreen(text: 'Email'),
                                ),
                                labelStyle: TextStyle(color: primary),
                                contentPadding: EdgeInsets.only(
                                    left: 25, right: 10, top: 20, bottom: 20),
                                // labelText: 'Email',
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
                        Visibility(
                          visible: edit,
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: visible,
                              decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: 200,
                                    padding: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    child: DarkGreen(text: 'Password'),
                                  ),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)))),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: !edit,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    color: primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () {
                                      this.setState(() {
                                        edit = !edit;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 57, vertical: 17),
                                      child: Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ))
                      ],
                    )),
              ))
            ],
          )
        ],
      )),
    );
  }
}
