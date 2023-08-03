import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loto/page/landing/blocks/block_banner.dart';
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
      backgroundColor: controller.bgColor,
      appBar: AppBar(
        title: Text('M O B I L E'),
        actions: const [
          AvatarWidget()
        ],
      ),
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.deepPurple[300],
                      height: 120,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
