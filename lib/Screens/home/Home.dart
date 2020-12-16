import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:trashsmart/Components/background_overlay.dart';
import 'package:trashsmart/Components/service_card.dart';
import 'package:trashsmart/Constants/colors.dart';
import 'package:trashsmart/Screens/SignIn.dart';
import 'package:trashsmart/Screens/market/market_store.dart';
import 'package:trashsmart/Screens/schedule/schedule_home_screen.dart';

import 'home_viewmodel.dart';

class Home extends StatelessWidget {
  final String id;
  Home({Key key, this.id}) : super(key: key);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _logout(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    // final String counter = (prefs.getString('email') ?? 'Hello');
    prefs.clear().then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignIn(),
        ),
        (route) => false));
  }

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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        children: <Widget>[
          // ServiceCard(
          //     label: "Request",
          //     icon: Icon(
          //       Icons.lock_clock,
          //       size: 50,
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => ScheduleHomeScreen(),
          //           ));
          //     }),
          ServiceCard(
              label: "Schedule",
              color: primary,
              icon: Icon(
                Icons.schedule,
                size: 50,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleHomeScreen(),
                    ));
              }),
          ServiceCard(
              label: "Buy Items",
              color: accent,
              icon: Icon(
                Icons.shopping_basket,
                size: 50,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MarketStore(),
                    ));
              }),
          ServiceCard(
              label: "Payment",
              icon: Icon(
                Icons.credit_card,
                size: 50,
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ScheduleHomeScreen(),
                //     ));
              }),
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
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Hello,'), Text("Welcome")],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 15),
              child: IconButton(
                  icon: Icon(Icons.logout), onPressed: () => _logout(context)),
            )
          ],
        ),
      ],
    );
  }
}
