import 'package:flutter/material.dart';
import 'package:trashsmart/Constants/app_theme.dart';

class MarketCard extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPressed;
  const MarketCard({Key key, this.label, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        // height: 122,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.network(
                    "https://image.made-in-china.com/202f0j00nTkReCKqEVpM/100L-120L-240L-Pedal-Type-Foot-Control-Plastic-Outdoor-Dustbin-Waste-Bin.jpg"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '20ltr Bin ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey.withOpacity(0.8)),
                      ),
                      Text('GHC450', style: AppTheme.body2),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 5,
                    indent: 5,
                    endIndent: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
