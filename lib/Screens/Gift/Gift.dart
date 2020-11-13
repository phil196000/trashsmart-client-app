import 'package:flutter/material.dart';
import 'package:trashsmart/Components/BackButton.dart';
import 'package:trashsmart/Components/DarkGreen.dart';
import 'package:trashsmart/Components/background_overlay.dart';
import 'package:trashsmart/Constants/colors.dart';

class Gift extends StatefulWidget {
  @override
  _GiftState createState() => _GiftState();
}

class _GiftState extends State<Gift> {
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
                      text: 'Gift',
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
                padding: EdgeInsets.only(bottom: 200, top: 50),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 60,
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DarkGreen(text: 'Code: 5g45hjs'),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Container(
                                        child: DarkGreen(
                                            text: "Copy",
                                            weight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 60,
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DarkGreen(text: 'Code: 5g45hjs'),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Container(
                                        child: DarkGreen(
                                            text: "Copy",
                                            weight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 60,
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DarkGreen(text: 'Code: 5g45hjs'),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Container(
                                        child: DarkGreen(
                                            text: "Copy",
                                            weight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 60,
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DarkGreen(text: 'Code: 5g45hjs'),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Container(
                                        child: DarkGreen(
                                            text: "Copy",
                                            weight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 60,
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DarkGreen(text: 'Code: 5g45hjs'),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Container(
                                        child: DarkGreen(
                                            text: "Copy",
                                            weight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
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
