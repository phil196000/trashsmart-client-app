import 'package:flutter/material.dart';
import 'package:trashsmart/Constants/app_theme.dart';

class MarketCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final String description;
  final void Function() onPressed;
  const MarketCard(
      {Key key,
      this.name,
      this.price,
      this.image,
      this.description,
      this.onPressed})
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                height: 120,
                child: Image.network(
                  this.image,
                ),
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
                        this.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey.withOpacity(0.8)),
                      ),
                      Text('GHC' + this.price.toString(),
                          style: AppTheme.body2),
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
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
