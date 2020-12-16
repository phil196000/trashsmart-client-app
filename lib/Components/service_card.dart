import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPressed;
  final Color color;
  const ServiceCard(
      {Key key, this.label, this.icon, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: this.color, borderRadius: BorderRadius.circular(10)),
          width: 127,
          height: 122,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [icon, Text(label)],
          ),
        ),
      ),
    );
  }
}
