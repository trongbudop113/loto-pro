import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/recipe/recipe_controller.dart';

class EditRecipeLayout extends StatelessWidget {
  final RecipeController controller;
  const EditRecipeLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thêm công thức mới",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controller.recipeNameController,
            decoration: InputDecoration(
              labelText: "Tên bánh",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFFF8E25),
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Obx(() => Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.grey.shade400),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: DropdownButton<String>(
          //     value: controller.selectedIngredient.value,
          //     isExpanded: true,
          //     underline: const SizedBox(),
          //     items: controller.ingredients.map((ingredient) {
          //       return DropdownMenuItem(
          //         value: ingredient,
          //         child: Text(ingredient),
          //       );
          //     }).toList(),
          //     onChanged: (value) {
          //       selectedIngredient.value = value!;
          //     },
          //   ),
          // )),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "Hủy",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    controller.addNewRecipe();
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Thêm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
