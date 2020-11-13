import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPressed;
  const ServiceCard({Key key, this.label, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Container(
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
