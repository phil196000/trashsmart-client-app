import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final Function onPress;

  CustomBackButton({Key key, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPress,
      child: SizedBox(
        width: 37.0,
        height: 37.0,
        child: Stack(
          children: <Widget>[
            Pinned.fromSize(
              bounds: Rect.fromLTWH(0.0, 0.0, 37.0, 37.0),
              size: Size(37.0, 37.0),
              pinLeft: true,
              pinRight: true,
              pinTop: true,
              pinBottom: true,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xff116939),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x89116939),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
            Pinned.fromSize(
              bounds: Rect.fromLTWH(14.9, 10.8, 7.6, 15.7),
              size: Size(37.0, 37.0),
              fixedWidth: true,
              fixedHeight: true,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 7.6, 7.9),
                    size: Size(7.6, 15.7),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    fixedHeight: true,
                    child: SvgPicture.string(
                      '<svg viewBox="93.5 50.5 7.6 7.9" ><path transform="translate(93.5, 50.5)" d="M 7.60498046875 0 L 0 7.86376953125" fill="none" stroke="#ffffff" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 7.9, 7.6, 7.9),
                    size: Size(7.6, 15.7),
                    pinLeft: true,
                    pinRight: true,
                    pinBottom: true,
                    fixedHeight: true,
                    child: SvgPicture.string(
                      '<svg viewBox="93.5 58.4 7.6 7.9" ><path transform="translate(93.5, 58.36)" d="M 7.60498046875 7.86376953125 L 0 0" fill="none" stroke="#ffffff" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
