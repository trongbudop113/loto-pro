import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loto/page/portfolior/portfolior_controller.dart';

class PageMain extends StatelessWidget {
  final PortFoliorController portFoliorController;
  const PageMain({Key? key, required this.portFoliorController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (context.isLargeTablet) {
      return _buildWeb(context);
    }
    if (context.isTablet) {
      return _buildMobile(context);
    }
    if (context.isPhone) {
      return _buildMobile(context);
    }

    return _buildWeb(context);
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 50),
          child: _widget1(),
        ),
        Spacer(
          flex: 1,
        ),
        _widget2(context)
      ],
    );
  }

  Widget _buildWeb(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(left: 50, right: 20),
            child: _widget1(),
          ),
        ),
        Expanded(
          flex: 1,
          child: _widget2(context),
        )
      ],
    );
  }

  Widget _widget1() {
    TextStyle textStyle = GoogleFonts.oswald();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Get.width,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "PORT-",
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: Get.width,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "FOLIO",
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget _widget2(BuildContext context) {
    TextStyle textStyle = GoogleFonts.oswald();
    return Container(
      width: Get.width,
      height: context.isLargeTablet ? null : Get.width * .5,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: Get.width * .5,
              height: Get.width * .5,
              color: Colors.blueAccent,
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            child: Container(
              width: Get.width * .8,
              height: 55,
              color: Colors.yellow,
              child: GestureDetector(
                onTap: () {
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
                            color: Colors.black, fontSize: 30, height: 1),
                      ),
                      SizedBox(
                        width: 5,
                      ),
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
                  child: Text(
                    "2023",
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
