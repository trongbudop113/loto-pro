import 'package:flutter/material.dart';
import 'package:loto/page/landing/blocks/block_left.dart';
import 'package:loto/page/landing/blocks/block_right.dart';
import 'package:loto/page/landing/landing_controller.dart';

class MyTabletBody extends StatelessWidget {
  final LandingController controller;
  const MyTabletBody({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.bgColor,
      appBar: AppBar(
        title: Text('T A B L E T'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // youtube video
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.deepPurple[400],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlockLeft(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlockRight(),
                    ),
                  ),
                ],
              ),

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
