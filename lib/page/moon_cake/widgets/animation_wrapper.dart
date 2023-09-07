import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:loto/page/moon_cake/page/moon_cake_detail_page.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({super.key,
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return MoonCakeDetailPage();
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}