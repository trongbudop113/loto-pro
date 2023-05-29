import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/caro_chess/caro_chess_controller.dart';

class CaroChessPage extends GetView<CaroChessController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            controller.getArgument();
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.amber,
            child: Text(controller.text),
          ),
        ),
      ),
    );
  }
}