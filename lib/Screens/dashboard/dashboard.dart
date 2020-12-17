import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trashsmart/Screens/Gift/Gift.dart';
import 'package:trashsmart/Screens/Profile/Profile.dart';
import 'package:trashsmart/Screens/dashboard/home/Home.dart';
import 'package:trashsmart/Screens/dashboard/home/user_dashboard.dart';

import 'dashboard_viewmodel.dart';

class DashBoard extends StatefulWidget {
  final String id;
  DashBoard({Key key, this.id}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(id);
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<DashBoard> {
  int _selectedIndex = 0;
  final String id;
  _MyStatefulWidgetState(this.id);
  Widget _widgetOptions(item) {
    List dashboard = [
      UserDashboard(
        id: this.id,
      ),
      Gift(),
      Profile(
        id: this.id,
      )
    ];
    Widget screen = dashboard.elementAt(item);
    return screen;
  }
  // List<Widget> _widgetOptions = <Widget>[
  //   Home(),
  //   Gift(),
  //   Profile(
  //     id: this.id,
  //   )
  // ];

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
          child: _widgetOptions(_selectedIndex),
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
