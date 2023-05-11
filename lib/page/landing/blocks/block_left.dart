import 'package:flutter/material.dart';
import 'package:loto/page/landing/body/border_widget.dart';

class BlockLeft extends StatelessWidget {
  const BlockLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 500,
      //color: Colors.amber,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: BorderWidget(
              color: Colors.amber,
              child: Container(),
            ),
          ),
          SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 2,
            child: Row(
              children: [
                Expanded(
                  child: BorderWidget(
                    color: Colors.greenAccent,
                    child: Container(),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: BorderWidget(
                    color: Colors.black,
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          AspectRatio(
              aspectRatio: 2,
              child: BorderWidget(
                color: Colors.white,
                child: Container(),
              )
          ),
          SizedBox(height: 16),
          AspectRatio(
              aspectRatio: 2,
              child: BorderWidget(
                color: Colors.white,
                child: Container(),
              )
          )
        ],
      ),
    );
  }
}