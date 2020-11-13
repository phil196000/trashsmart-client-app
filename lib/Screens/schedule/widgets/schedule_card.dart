import 'package:flutter/material.dart';
import 'package:trashsmart/Constants/app_theme.dart';

class ScheduleCard extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPressed;
  const ScheduleCard({Key key, this.label, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // height: 122,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '20-11-2020 at 8:00 am ',
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
              Row(
                children: [
                  Text(
                    'Kentikrono,Nsenie',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey.withOpacity(0.8)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'One-time pickup',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey.withOpacity(0.8)),
                  )
                ],
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
        ),
      ),
    );
  }
}