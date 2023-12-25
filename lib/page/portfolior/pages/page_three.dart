import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = GoogleFonts.oswald();

    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.yellow,
            height: 90,
            child: Text(
              "Education",
              style: textStyle.copyWith(
                  fontSize: 25
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            color: Colors.yellow,
            height: 90,
            child: Text(
              "Experience",
              style: textStyle.copyWith(
                  fontSize: 25
              ),
            ),
          )
        ],
      ),
    );
  }
}
