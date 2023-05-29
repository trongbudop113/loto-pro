import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

class CaroChessBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CaroChessController());
  }
}

class CaroChessController extends GetxController {

  final String text = "aaaaa";

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getArgument(){
    var data = randomize(49, 1, 50);
  }

  Timer? timer;

  List<int> randomize(int count, int min, int max)
  {
    Random r = Random();
    List<int> result = [];
    if (count < max)
    {
      while(result.length <= count){
        int number = r.nextInt(max);
        if (!result.contains(number))
        {
          result.add(number);
        }
      }
    }
    else
    {
      print("Select another boundaries or number count");
    }
    return result;
  }

}