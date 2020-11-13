import 'package:flutter/material.dart';

class BackgroundOverlay extends StatelessWidget {
  final Widget overlayWidget;
  const BackgroundOverlay({Key key, this.overlayWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTopWidget(context),
      ],
    );
  }

  Widget buildTopWidget(BuildContext context) {
    return new Stack(
      children: <Widget>[
        // The containers in the background
        new Column(
          children: <Widget>[
            new Container(
              // color: Colors.red,
              decoration: BoxDecoration(
                color: Color(0xFFB9D3C5),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50.0)),
              ),
              height: MediaQuery.of(context).size.height * .35,
            ),
          ],
        ),
        // The card widget with top padding,
        // incase if you wanted bottom padding to work,
        // set the `alignment` of container to Alignment.bottomCenter
        new Container(
            alignment: Alignment.topCenter,
            // padding: new EdgeInsets.only(
            //     top: MediaQuery.of(context).size.height * .58,
            //     right: 20.0,
            //     left: 20.0),
            child: this.overlayWidget)
      ],
    );
  }
}
