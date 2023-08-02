import 'package:flutter/material.dart';
import 'dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  final Widget tabletBody;

  const ResponsiveLayout({super.key, required this.mobileBody, required this.desktopBody, required this.tabletBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return mobileBody;
        } else if(constraints.maxWidth > mobileWidth && constraints.maxWidth < tabletWidth){
          return tabletBody;
        }else {
          return desktopBody;
        }
      },
    );
  }
}
