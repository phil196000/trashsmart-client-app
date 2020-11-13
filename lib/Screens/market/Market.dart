import 'package:flutter/material.dart';
import 'package:trashsmart/Components/background_overlay.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          BackgroundOverlay(),
          Column(
            children: [
              Row(
                children: [],
              )
            ],
          )
        ],
      )),
    );
  }
}
