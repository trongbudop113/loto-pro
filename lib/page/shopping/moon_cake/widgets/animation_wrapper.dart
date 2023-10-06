import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/page/moon_cake_detail_page.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({super.key,
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.controller,
    required this.widgetKey
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;
  final MoonCakeController controller;
  final GlobalKey widgetKey;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return MoonCakeDetailPage(
          controller: controller,
          childKey: widgetKey,
        );
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}