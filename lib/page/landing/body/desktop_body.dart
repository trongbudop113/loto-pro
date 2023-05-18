import 'package:flutter/material.dart';
import 'package:loto/page/landing/blocks/block_left.dart';
import 'package:loto/page/landing/blocks/block_right.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';

class MyDesktopBody extends StatelessWidget {
  final LandingController controller;
  const MyDesktopBody({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.bgColor,
      appBar: AppBar(
        title: Text('D E S K T O P'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlockLeft(),
                ),
              ),

              // First column
              Expanded(
                flex: 7,
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

                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text("Trò Chơi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 8,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return BorderWidget(
                              child: Icon(Icons.add, size: 50),
                            );
                          },
                        ),
                      ),
                    ),

                    ListView.builder(
                      itemCount: 8,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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

              // second column
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlockRight(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
