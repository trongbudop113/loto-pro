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

  Future<void> getArgument() async {
    var data = randomize(49, 1, 50);
    int i = 0;
    timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
      if(i >= data.length){
        t.cancel();
        return;
      }
      print('[${data[i]}]');
      i++;
    });
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

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

}