import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/recipe/model/ingredient.dart';
import 'package:loto/page/shopping/recipe/model/recipe.dart';

class RecipeDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeDetailController());
  }
}

class RecipeDetailController extends GetxController{

  final Rx<RecipeModel> recipeModel = RecipeModel().obs;
  final RxDouble quantityUnit = 1.0.obs;
  final RxDouble totalMoney = 0.0.obs;

  @override
  void onInit() {
    initArgument();
    super.onInit();
  }

  void initArgument(){
    if(Get.arguments == null) return;
    var data = Get.arguments as RecipeModel;
    quantityUnit.value = (data.unit ?? 1).toDouble();
    List<IngredientModel> masterData = AppCommon.singleton.listIngredientMaster;
    double valueMoney = 0;
    if(data.cakeIngredientSub.isNotEmpty){
      data.cakeIngredient?.addAll(data.cakeIngredientSub);
    }
    data.cakeIngredient?.forEach((e){
      if(e.id != -1){
        var item = masterData.firstWhereOrNull((element) => element.id == e.id);
        var percent = (item?.price ?? 0) / (item?.unit ?? 0);
        if(item != null){
          e.name = item.name ?? '';
          e.ext = item.ext ?? '';
          e.unit = item.unit ?? 0;
          e.total = percent * (e.quantity ?? 0);
          valueMoney += e.total;
        }
      }
    });

    recipeModel.value = data;
    totalMoney.value = valueMoney;
  }

  void onChangeQuantity(String value) {
    if(value == "" || value == "0") return;
    print(value);
    Future.delayed(const Duration(milliseconds: 300), (){
      double data = double.parse(value);
      quantityUnit.value = data;
      onUpdateTotal();
    });
  }

  void onUpdateTotal(){
    double valueMoney = 0;
    recipeModel.value.cakeIngredient?.forEach((e){
      valueMoney += (e.total * quantityUnit.value);
    });
    totalMoney.value = valueMoney;
  }

}