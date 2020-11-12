import 'package:flutter/material.dart';
import 'package:trashsmart/Constants/colors.dart';

class DarkGreen extends StatelessWidget {
  final String text;
  final FontWeight weight;
  DarkGreen({Key key, @required this.text, this.weight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.text,
        style: TextStyle(color: primary, fontWeight: this.weight),
      ),
    );
  }
}
