import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/page/shopping/about_us/entity/category_recipe.dart';
import 'package:loto/page/shopping/home_main/home_main_controller.dart';
import 'package:loto/page/shopping/shop_product/model_data/top_categories_res.dart';
import 'package:loto/page/shopping/shop_product/shop_product_controller.dart';

class CategoryRecipeModel extends BaseModel{

  CategoryRecipeModel(){
    onStart();
  }

  final RxList<LsCategory> listCategory = <LsCategory>[].obs;

  ShopProductController? shopProductController;

  void setListCategory(List<LsCategory> lsCategory){
    listCategory.addAll(lsCategory);
  }

  void onTapCategory(LsCategory item){
    int index = listCategory.indexWhere((e) => e.categoryId == item.categoryId);
    Get.find<ShopProductController>().searchArticleModel.onSelectCategory(index);
    Get.find<HomeMainController>().onChangeTap(2);
  }

  @override
  void onStart(){

  }

  @override
  void onFinish() {

  }

  void onTapDetail(CategoryRecipe listCategory) {

  }

}