import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/recipe/recipe_controller.dart';

class RecipePage extends GetView<RecipeController> {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.listMain.isEmpty) {
                return const CircularProgressIndicator();
              }
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: const Text("Chinh"),
                    alignment: Alignment.center,
                    color: Colors.red,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.listMain.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      var data = controller.listMain[i];
                      return GestureDetector(
                        child: Obx(() {
                          return Container(
                            color: controller.indexSelect.value == i
                                ? Colors.grey.withOpacity(0.4)
                                : Colors.transparent,
                            height: 55,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  data.cakeName ?? '',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        }),
                        onTap: () {
                          controller.onViewRecipeDetail(i);
                        },
                      );
                    },
                  ),
                ],
              );
            }),
            Obx(() {
              if (controller.listSub.isEmpty) {
                return const CircularProgressIndicator();
              }
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: const Text("Phu"),
                    alignment: Alignment.center,
                    color: Colors.red,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.listSub.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      var data = controller.listSub[i];
                      return Container(
                        color: Colors.transparent,
                        height: 55,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              data.cakeName ?? '',
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(flex: 1),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Obx(() {
                                if (data.isSelected.value) {
                                  return const Icon(Icons.check_circle,
                                      color: Colors.red);
                                }
                                return const Icon(Icons.circle_outlined,
                                    color: Colors.red);
                              }),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
