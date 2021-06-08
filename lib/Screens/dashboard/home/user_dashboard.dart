import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashsmart/Screens/SignIn.dart';
import 'package:trashsmart/Screens/market/market_store.dart';
import 'package:trashsmart/Screens/schedule/schedule_home_screen.dart';
import 'Custom_Icons.dart';
import 'data.dart';

class UserDashboard extends StatefulWidget {
  final String id;

  const UserDashboard({Key key, this.id}) : super(key: key);
  @override
  _MyAppDashboard createState() => new _MyAppDashboard(id);
}

class _MyAppDashboard extends State<UserDashboard> {
  int _currentIndex = 0;
  final String id;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _MyAppDashboard(this.id); //move this to viewmodel later

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

  Widget _buildGradientContainer(double width, double height) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: width * .8,
        height: height / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFFfbfcfd), Color(0xFFf2f3f8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.5, 1.0]
        )),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Positioned(
      top: 40.0,
      left: 20.0,
      right: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(CustomIcons.menu, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(double height) {
    return Positioned(
      top: height * .2,
      left: 30.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Fre Borla",
              style: TextStyle(fontSize: 28.0, fontFamily: "Montserrat-Bold")),
          Text("Powered by Trash Smart",
              style: TextStyle(fontSize: 16.0, fontFamily: "Montserrat-Medium"))
        ],
      ),
    );
  }

  Widget dashBoardItem(BuildContext context, int index, String heading,
      String subheading, Function callback) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: EdgeInsets.only(left: 35.0, bottom: 60.0),
        child: SizedBox(
          width: 200.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 45.0),
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          (index % 2 == 0) ? Colors.white : Color(0xFF2a2d3f),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 10.0),
                            blurRadius: 10.0)
                      ],
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    "https://edsurge.imgix.net/uploads/post/image/12136/2019-1555705073.jpg",
                    width: 172.5,
                    height: 199.0,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(heading,
                            style: TextStyle(
                                fontSize: 19.0,
                                fontFamily: "Montserrat-Bold",
                                color: (index % 2 == 0)
                                    ? Color(0xFF2a2d3f)
                                    : Colors.white)),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(subheading,
                            style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Montserrat-Medium",
                                color: (index % 2 == 0)
                                    ? Color(0xFF2a2d3f)
                                    : Colors.white)),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFf2f3f8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;

          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildGradientContainer(width, height),
              _buildAppBar(context),
              _buildTitle(height),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: height * .6,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      dashBoardItem(
                        context,
                        0,
                        "Schedule",
                        "see all schedules",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleHomeScreen(),
                          ),
                        ),
                      ),
                      dashBoardItem(
                        context,
                        1,
                        "Products",
                        "check out our products",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarketStore(),
                          ),
                        ),
                      ),
                      dashBoardItem(
                        context,
                        2,
                        "Payments",
                        "payment plans",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleHomeScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
      //   bottomNavigationBar: BottomNavigationBar(
      //     selectedItemColor: Colors.black,
      //     onTap: (index) {
      //       setState(() {
      //         _currentIndex = index;
      //       });
      //     },
      //     currentIndex: _currentIndex,
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.panorama_horizontal),
      //           title: Container(
      //             height: 0.0,
      //           )),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.bookmark_border),
      //           title: Container(
      //             height: 0.0,
      //           ))
      //     ],
      //   ),
      //   floatingActionButton: Container(
      //     width: 65.0,
      //     height: 65.0,
      //     decoration: BoxDecoration(
      //         color: Color(0xFFfa7b58),
      //         shape: BoxShape.circle,
      //         boxShadow: [
      //           BoxShadow(
      //               color: Color(0xFFf78a6c).withOpacity(.6),
      //               offset: Offset(0.0, 10.0),
      //               blurRadius: 10.0)
      //         ]),
      //     child: RawMaterialButton(
      //       shape: CircleBorder(),
      //       child: Icon(
      //         Icons.add,
      //         size: 35.0,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {},
      //     ),
      //   ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
