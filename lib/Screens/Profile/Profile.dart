import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashsmart/Components/BackButton.dart';
import 'package:trashsmart/Components/DarkGreen.dart';
import 'package:trashsmart/Components/background_overlay.dart';
import 'package:trashsmart/Constants/colors.dart';

class Profile extends StatefulWidget {
  final String id;

  const Profile({Key key, this.id}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _passwordController;
  TextEditingController _phoneNumberController;
  TextEditingController _emailController;
  TextEditingController _fullnameController;
  String email;
  String password;
  String token;
  bool edit = false;
  Map<String, dynamic> emailError = {'visible': false, 'message': null};
  Map<String, dynamic> netWorkError = {'visible': false, 'message': ''};
  Map<String, dynamic> userData = {
    'full_name': '',
    'email': '',
    'created_at': '',
    'subscribed': false,
    'image_url': ''
  };
  bool passwordError = false;
  bool visible = true;
  bool indicator = false;
  @override
  void initState() {
    super.initState();
    log(this.widget.id);
    getUser();
  }

  void getUser() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('users').doc(this.widget.id).get().then((value) {
      if (value.exists) {
        _emailController = TextEditingController(text: value.data()['email']);
        _fullnameController =
            TextEditingController(text: value.data()['full_name']);
        _phoneNumberController =
            TextEditingController(text: value.data()['phone_number']);
        log(value.data().toString());
        this.setState(() {
          userData = value.data();
        });
      }
    }).catchError((onError) {});
  }

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
                          width: 170,
                          height: 170,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(170),
                            child: userData['image_url'].contains('firebase')
                                ? Image.network(userData['image_url'])
                                : Image.asset('lib/assets/logo.png'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextField(
                            enabled: edit,
                            controller: _fullnameController,
                            style: TextStyle(
                              color: primary,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  width: 150,
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
                            enabled: edit,
                            controller: _phoneNumberController,
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
                            enabled: edit,
                            controller: _emailController,
                            style: TextStyle(
                              color: primary,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  width: 120,
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
