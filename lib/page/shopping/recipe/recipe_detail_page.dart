import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/shopping/recipe/recipe_detail_controller.dart';

class RecipeDetailPage extends GetView<RecipeDetailController> {
  const RecipeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if ((controller.recipeModel.value.cakeName ?? '').isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            const SizedBox(height: 20),
            Text(
                "Cong thuc banh ${controller.recipeModel.value.cakeName} bao gom:"),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Nguyen lieu lam cho:"),
                const Spacer(flex: 1),
                SizedBox(
                  width: 60,
                  child: TextField(
                    onChanged: (value) {
                      controller.onChangeQuantity(value);
                    },
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      labelText: "${controller.recipeModel.value.unit}",
                    ),
                  ),
                ),
                Text(" ${controller.recipeModel.value.ext}"),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 45,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Nguyen lieu",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "So luong",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Thanh tien",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount:
                    (controller.recipeModel.value.cakeIngredient ?? []).length,
                separatorBuilder: (c, i) {
                  return const Divider(height: 1);
                },
                itemBuilder: (c, i) {
                  var data =
                      (controller.recipeModel.value.cakeIngredient ?? [])[i];
                  if(data.id == -1){
                    return Container(
                      height: 45,
                      color: Colors.blue,
                      alignment: Alignment.centerLeft,
                      child: Text(data.name),
                    );
                  }
                  return Container(
                    height: 45,
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            data.name,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Obx(() {
                            return Text(
                              "${(controller.quantityUnit.value * (data.quantity ?? 0).toDouble()).toStringAsFixed(1)} ${data.ext}",
                              textAlign: TextAlign.center,
                            );
                          }),
                        ),
                        Expanded(
                          flex: 3,
                          child: Obx(() {
                            return Text(
                              AppCommon.singleton.formatCurrency((controller.quantityUnit.value * data.total)),
                              textAlign: TextAlign.center,
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 45,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Tổng",
                  ),
                  Obx((){
                    return Text(
                      AppCommon.singleton.formatCurrency(controller.totalMoney.value),
                      textAlign: TextAlign.center,
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
