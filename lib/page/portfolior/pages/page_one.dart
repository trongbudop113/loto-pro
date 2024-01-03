import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (context.isLargeTablet) {
      return _buildWeb();
    }
    if (context.isTablet) {
      return _buildMobile();
    }
    if (context.isPhone) {
      return _buildMobile();
    }

    return _buildWeb();
  }

  Widget _buildMobile(){
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              child: _loadImage(),
            ),
          ),
          _loadContent()
        ],
      ),
    );
  }

  Widget _buildWeb(){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _loadImage(),
        ),
        Expanded(
          flex: 1,
          child: _loadContent(),
        )
      ],
    );
  }

  Widget _loadContent(){
    TextStyle textStyle = GoogleFonts.oswald();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Container(
            width: Get.width,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text("XIN CHÀO", style: textStyle.copyWith(fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: Get.width,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text("I'M GÀO MẶT QUẠO", style: textStyle.copyWith(fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: Get.width,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text("LẬP TRÌNH VIÊN FLUTTER", style: textStyle.copyWith(fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadImage(){
    return Image.network(
      "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/portfolio%2F20231128_141339_451.jpg?alt=media&token=015d2ab5-7946-495f-bad5-675dee644839",
      fit: BoxFit.cover,
    );
  }
}
