import 'package:flutter/material.dart';

class DividedContainer extends StatelessWidget {
  DividedContainer({
    Key key,
    this.child,
    this.width = double.infinity,
    this.height = 100.0,
    this.alignment,
  }) : super(key: key);

  final Widget child;
  final double width;
  final double height;
  final String alignment;

  MainAxisAlignment getAlignment() {
    switch (alignment) {
      case 'center':
        return MainAxisAlignment.center;
      case 'left':
        return MainAxisAlignment.start;
      case 'right': 
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: getAlignment(),
        children: <Widget>[
          child
        ],
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          color: Colors.grey,
          width: 1
        ))
      ),
    );
  }
}