import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPressed;
  const ScheduleCard({Key key, this.label, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: 127,
            height: 122,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
