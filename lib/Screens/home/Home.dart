import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:trashsmart/Components/background_overlay.dart';
import 'package:trashsmart/Components/service_card.dart';

import 'home_viewmodel.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BackgroundOverlay(
                overlayWidget: buildTopWidget(context),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Our Services",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              renderServices(context)
            ],
          ),
        ),
      )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget renderServices(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ServiceCard(
              label: "Service 2",
              icon: Icon(
                Icons.lock_clock,
                size: 50,
              ),
              onPressed: () {}),
          ServiceCard(
              label: "Service 3",
              icon: Icon(
                Icons.schedule,
                size: 50,
              ),
              onPressed: () {}),
          ServiceCard(
              label: "Service 4",
              icon: Icon(
                Icons.shopping_basket,
                size: 50,
              ),
              onPressed: () {}),
          ServiceCard(
              label: "Service 1",
              icon: Icon(
                Icons.credit_card,
                size: 50,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget buildTopWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  IconButton(icon: Icon(Icons.person), onPressed: () {}),
                  Text("User")
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.settings), onPressed: () {})
          ],
        ),
      ],
    );
  }
}
