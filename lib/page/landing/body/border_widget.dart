import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page_config.dart';

class BorderWidget extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  const BorderWidget({Key? key, this.child, this.color, this.margin, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.only(bottom: 10),
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
      ),
    );
  }
}

