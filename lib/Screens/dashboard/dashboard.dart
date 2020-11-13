import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trashsmart/Screens/Gift/Gift.dart';
import 'package:trashsmart/Screens/Profile/Profile.dart';
import 'package:trashsmart/Screens/home/home.dart';

import 'dashboard_viewmodel.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<DashBoard> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[Home(), Gift(), Profile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashBoardViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
      viewModelBuilder: () => DashBoardViewModel(),
    );
  }
}
