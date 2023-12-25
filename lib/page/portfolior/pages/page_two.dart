import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = GoogleFonts.oswald();

    return Scaffold(
      body: Column(
        children: [
          Text(
            "I'm Gào Mặt Quạo, Lập Trình Viên Flutter",
            style: textStyle,
          ),
          Container(
            width: Get.width,
            height: Get.width,
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _itemRowBlock(
                          title: "4+",
                          content: "Years Experience"
                        ),
                      ),
                      Container(
                        height: 1,
                        width: (Get.width / 2) - 40,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: _itemRowBlock(
                            title: "200+",
                            content: "Happy Client"
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 1,
                  height: Get.width - 40,
                  alignment: Alignment.center,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _itemRowBlock(
                            title: "10+",
                            content: "Project Done"
                        ),
                      ),
                      Container(
                        height: 1,
                        width: (Get.width / 2) - 40,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: _itemRowBlock(
                            title: "10+",
                            content: "Follower"
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "What I Do?",
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Widget _itemRowBlock({required String title, required String content}){

    TextStyle textStyle = GoogleFonts.oswald();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: textStyle.copyWith(
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(
          content,
          style: textStyle.copyWith(
              fontSize: 30,
          ),
        )
      ],
    );
  }
}
