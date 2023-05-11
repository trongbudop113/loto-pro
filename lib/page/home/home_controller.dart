import 'package:get/get.dart';
import 'package:loto/page/home/models/item_model.dart';
import 'package:loto/page/select/models/select_paper.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {

  final RxList<SelectPaper> listData = <SelectPaper>[].obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getArgument(){
    var arguments = Get.arguments as List<SelectPaper>;
    listData.addAll(arguments);
  }


  void onTapNumber(int i, int j, int k){
    int number = listData[i].papers![j].items![k].number ?? 0;
    if(number == 0){
      return;
    }
    listData[i].papers![j].items![k].isCheck.value = !listData[i].papers![j].items![k].isCheck.value;

    int count = 0;
    for(ItemModel data in listData[i].papers![j].items ?? []){
      if((data.number ?? 0) > 0 && data.isCheck.value){
        count++;
      }
    }

    if(count == 4){
      print('wait wait wait wait');
      return;
    }

    if(count == 5){
      print('win win win win');
      return;
    }
  }

  void onRefreshData(){
    for(var parent in listData){
      for(ItemRowModel element in parent.papers ?? []){
        if(!(element.typeFull ?? false)){
          for(ItemModel child in element.items ?? []){
            child.isCheck.value = false;
          }
        }
      }
    }
  }

  RxBool get isHasData {
    return (listData.isNotEmpty).obs;
  }

  int convertColor(String color){
    return int.parse(color);
  }

  @override
  void onClose() {
    onRefreshData();
    super.onClose();
  }

}