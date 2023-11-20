import 'package:flutter/foundation.dart' show kIsWeb;
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

class MyMobileBody extends StatelessWidget {
  final LandingController controller;
  const MyMobileBody({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // youtube video
              const BlockBanner(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: BlockLeft(layout: LayoutEnum.mobile),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: BlockRight(layout: LayoutEnum.mobile),
              ),

              const BlockGame(),
              const SizedBox(height: 10),
              // comment section & recommended videos
              blockBody(),
              const SizedBox(height: 20),
              BlockFooter()
            ],
          ),
        ),
      ),
    );
  }

  Widget blockBody(){
    if(kIsWeb){
      return SizedBox();
    }

    return BlockBody();
  }
}
