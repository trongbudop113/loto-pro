import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/recipe/recipe_controller.dart';

class RecipePage extends GetView<RecipeController> {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Công thức",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF7A00),
        elevation: 0.5,
        actions: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.showAddRecipeDialog(context),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFFFF8E25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.showAddIngredientDialog(context),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFFFF8E25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Obx((){
        if(controller.isEmptyPage.value){
          return _buildEmpty();
        }
        return _buildBody();
      }),
    );
  }

  Widget _buildBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMainRecipes(),
          const SizedBox(height: 24),
          _buildSubRecipes(),
        ],
      ),
    );
  }

  Widget _buildEmpty(){
    return Center(
      child: Image.network(
        "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fshops%2Fbaker.png?alt=media&token=813947d9-ba2e-465c-8498-e973f5972a8f",
        width: 180,
        height: 180,
        fit: BoxFit.contain,
      )
    );
  }

  Widget _buildMainRecipes() {
    return Obx(() {
      if (controller.listMain.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(
              color: Color(0xFFFF8E25),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.restaurant_menu, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  "Công thức chính",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.listMain.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) {
              var data = controller.listMain[i];
              return Obx(() {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => controller.onViewRecipeDetail(i),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: controller.indexSelect.value == i
                            ? const Color(0xFFFF8E25).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.indexSelect.value == i
                              ? const Color(0xFFFF8E25)
                              : Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cake,
                            color: controller.indexSelect.value == i
                                ? const Color(0xFFFF8E25)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              data.cakeName ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: controller.indexSelect.value == i
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: controller.indexSelect.value == i
                                    ? const Color(0xFFFF8E25)
                                    : const Color(0xFF333333),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              controller.onRemoveRecipe(data);
                            },
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      );
    });
  }

  Widget _buildSubRecipes() {
    return Obx(() {
      if (controller.listSub.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(
              color: Color(0xFFFF8E25),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.restaurant, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  "Công thức phụ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.listSub.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) {
              var data = controller.listSub[i];
              return Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.cake_outlined, color: Colors.grey),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          data.cakeName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      Obx(() => Icon(
                        data.isSelected.value
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: const Color(0xFFFF8E25),
                        size: 24,
                      )),

                      const SizedBox(width: 10),
                      InkWell(
                        onTap: (){
                          controller.onRemoveRecipe(data);
                        },
                        child: const Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
