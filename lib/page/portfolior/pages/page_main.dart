import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loto/page/portfolior/portfolior_controller.dart';

class  PageMain extends StatelessWidget {
  final PortFoliorController portFoliorController;
  const PageMain({Key? key, required this.portFoliorController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = GoogleFonts.oswald();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 50),
            width: Get.width,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text("PORT-", style: textStyle.copyWith(fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            width: Get.width,
            padding: EdgeInsets.only(right: 50),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text("FOLIO", style: textStyle.copyWith(fontWeight: FontWeight.bold),),
            ),
          ),
          Spacer(flex: 1,),
          Container(
            width: Get.width,
            height: Get.width * .5,
            child: Stack(
              children: [
                Container(
                  width: Get.width * .5,
                  height: Get.width * .5,
                  color: Colors.blueAccent,
                ),

                Positioned(
                  top: 50,
                  right: 0,
                  child: Container(
                    width: Get.width * .8,
                    height: 55,
                    color: Colors.yellow,
                    child: GestureDetector(
                      onTap: (){
                        portFoliorController.onTapNext();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Xem Ngay",
                              style: textStyle.copyWith(
                                color: Colors.black,
                                fontSize: 30,
                                height: 1
                              ),
                            ),
                            SizedBox(width: 5,),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 120,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text("2023", style: textStyle.copyWith(fontWeight: FontWeight.bold),),
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
