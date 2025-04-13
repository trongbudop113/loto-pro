import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/recipe/layout/edit_recipe_layout.dart';
import 'package:loto/page/shopping/recipe/model/ingredient.dart';
import 'package:loto/page/shopping/recipe/model/recipe.dart';
import 'package:loto/page_config.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeController(), fenix: true);
  }
}

class RecipeController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxList<RecipeModel> listMain = <RecipeModel>[].obs;
  final RxList<RecipeModel> listSub = <RecipeModel>[].obs;
  final TextEditingController recipeNameController = TextEditingController();

  final RxInt indexSelect = (-1).obs;
  final RxBool isEmptyPage = false.obs;

  Future<void> streamGetRecipe() async {
    CollectionReference roomRef = firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Recipes.name)
        .collection("Cakes");

    var a = await roomRef.where("type", isEqualTo: 1).get();
    var list = a.docChanges.map<RecipeModel>((e) => RecipeModel.fromJson(e.doc.data() as Map<String, dynamic>)).toList();
    listMain.addAll(list);
  }

  Future<void> streamGetRecipe2() async {
    CollectionReference roomRef = firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Recipes.name)
        .collection("Cakes");

    var a = await roomRef.where("type", isEqualTo: 2).get();
    var list = a.docChanges.map<RecipeModel>((e) => RecipeModel.fromJson(e.doc.data() as Map<String, dynamic>)).toList();
    listSub.addAll(list);
  }

  RecipeModel covertData(Map<String, dynamic> data) {
    return RecipeModel.fromJson(data);
  }

  Future<void> onViewRecipeDetail(int index) async {
    var relatedList = listMain[index].relate ?? [];

    if(indexSelect.value != -1 && indexSelect.value == index) {
      for (var e in listSub) {
        e.isSelected.value = false;
      }
      indexSelect.value = -1;
      return;
    }

    if(indexSelect.value != index){
      listMain[index].cakeIngredientSub.clear();
      if(relatedList.isNotEmpty){
        for (var e in listSub) {
          e.isSelected.value = false;
          if(relatedList.contains(e.cakeID)){
            e.isSelected.value = true;

            var cakeIng = CakeIngredient.setDefault(e.cakeName ?? '');
            listMain[index].cakeIngredientSub.add(cakeIng);
            e.cakeIngredient?.forEach((child){
              child.quantity = (child.quantity ?? 0) / (e.unit ?? 0);
            });
            listMain[index].cakeIngredientSub.addAll(e.cakeIngredient ?? []);
          }
        }
      }
      indexSelect.value = index;
      await 1.delay();
      Get.toNamed(PageConfig.RECIPE_DETAIL, arguments: listMain[index]);
    }
  }

  @override
  void onInit() {
    initFirst();
    super.onInit();
  }

  Future<void> initFirst() async {
    var isPass = await checkPermissionAccess();
    isEmptyPage.value = isPass;
    if(isPass){
      await initMasterData();
      await streamGetRecipe();
      await streamGetRecipe2();
    }
  }

  Future<bool> checkPermissionAccess() async {
    final bool isAuthenticated = AppCommon.singleton.isLogin;

    if (!isAuthenticated) {
      await 0.5.delay();
      await Get.toNamed(PageConfig.LOGIN);
    }
    final currentUser = AppCommon.singleton.userLoginData;

    if (!(currentUser.isAdmin ?? false)) {
      Get.snackbar(
        'Thông báo',
        'Bạn không có quyền truy cập trang này',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return currentUser.isAdmin ?? false;
  }

  Future<void> initMasterData() async {
    try {
      if (AppCommon.singleton.listIngredientMaster.isNotEmpty) return;
      CollectionReference roomRef = firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Ingredients.name)
          .collection("1");
      var res = await roomRef.get();
      List<IngredientModel> list = [];
      for (var e in res.docChanges) {
        IngredientModel model =
            IngredientModel.fromJson(e.doc.data() as Map<String, dynamic>);
        list.add(model);
      }

      AppCommon.singleton.listIngredientMaster.addAll(list);
    } catch (e) {
      e.printInfo(info: " loi init master data ");
    }
  }

  void showAddRecipeDialog(BuildContext context) {
    Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: EditRecipeLayout(controller: this),
        )
    );
  }

  void addNewRecipe() {
    Get.back();
  }
}
