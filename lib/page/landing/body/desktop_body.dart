import 'package:flutter/material.dart';
import 'package:loto/page/landing/blocks/block_banner.dart';
import 'package:loto/page/landing/blocks/block_body.dart';
import 'package:loto/page/landing/blocks/block_footer.dart';
import 'package:loto/page/landing/blocks/block_game.dart';
import 'package:loto/page/landing/blocks/block_left.dart';
import 'package:loto/page/landing/blocks/block_right.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/responsive/dimensions.dart';

class MyDesktopBody extends StatelessWidget {
  final LandingController controller;
  const MyDesktopBody({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width > 1200 ? 1200 : MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlockLeft(layout: LayoutEnum.desktop),
                        ),
                      ),

                      // First column
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            // youtube video
                            const BlockBanner(),

                            const BlockGame(),

                            BlockBody()
                          ],
                        ),
                      ),

                      // second column
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlockRight(layout: LayoutEnum.desktop),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlockFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}