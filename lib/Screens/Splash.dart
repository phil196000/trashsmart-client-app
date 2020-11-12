import 'dart:async';

// import 'package:academy/Screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:trashsmart/Screens/SignIn.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    new Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Image(image: AssetImage('lib/assets/logo.png')),
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
}
