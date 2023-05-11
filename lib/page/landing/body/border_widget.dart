import 'package:flutter/material.dart';

class BorderWidget extends StatelessWidget {
  final Color? color;
  final Widget? child;
  const BorderWidget({Key? key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(1, 1),
              blurRadius: 1,
              spreadRadius: 1
          )
        ]
      ),
      child: child ?? Container(),
    );
  }
}
