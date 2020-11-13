import 'package:flutter/material.dart';
import 'package:trashsmart/Constants/colors.dart';

class DarkGreen extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final double size;
  DarkGreen({Key key, @required this.text, this.weight, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.text,
        style: TextStyle(
            color: primary, fontWeight: this.weight, fontSize: this.size),
      ),
    );
  }
}
