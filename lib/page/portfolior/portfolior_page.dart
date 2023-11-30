import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/portfolior/portfolior_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PortFoliorPage extends GetView<PortFoliorController> {
  const PortFoliorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("portfolior".tr),
    //   ),
    //   body: Column(
    //     children: [
    //       GestureDetector(
    //         onTap: (){
    //           launchUrl(Uri.parse(controller.linkin));
    //         },
    //         child: Container(
    //           alignment: Alignment.center,
    //           color: Colors.blueAccent,
    //           padding: EdgeInsets.all(15),
    //           child: Text("LinkedIn của tôi"),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("portfolior".tr),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: controller.controller,
            onPageChanged: (num) {
              controller.curr.value = num;
            },
            children: controller.listPage,
          ),
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(controller.listPage.length, (e){
                return Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    color: Colors.amber
                  ),
                  child: Text("${e + 1}"),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
