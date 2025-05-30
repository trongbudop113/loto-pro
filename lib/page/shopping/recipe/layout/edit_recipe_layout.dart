import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/recipe/model/ingredient_form.dart';
import 'package:loto/page/shopping/recipe/model/recipe.dart';
import 'package:loto/page/shopping/recipe/model/recipe_form.dart';
import 'package:loto/page/shopping/recipe/model/recipe_type.dart';
import 'package:loto/page/shopping/recipe/recipe_controller.dart';

class EditRecipeLayout extends StatelessWidget {
  final RecipeController controller;
  const EditRecipeLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 800),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(height: 32),
            _buildBasicInfo(),
            const SizedBox(height: 32),
            _buildIngredientSection(),
            const SizedBox(height: 32),
            _buildRecipeTypeSection(),
            const SizedBox(height: 32),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Thông tin cơ bản",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        _buildNameField(),
        const SizedBox(height: 16),
        _buildUnitFields(),
      ],
    );
  }

  Widget _buildIngredientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nguyên liệu",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        _buildListIngredient(),
      ],
    );
  }

  Widget _buildRecipeTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Loại công thức",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        _buildTypeDropdown(),
        const SizedBox(height: 16),
        _buildListRecipeSub(),
      ],
    );
  }

  // Cải thiện UI cho danh sách nguyên liệu
  Widget _buildListIngredient() {
    return GetBuilder(
      init: controller,
      id: "updateListIngredient",
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recipeForm.cakeIngredient.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (c, i) => _buildIngredientRow(i),
              ),
              _buildAddIngredientButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIngredientRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFF8E25),
            radius: 12,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GetBuilder(
              init: controller,
              id: "updateIngredientItem$index",
              builder: (_) => _buildIngredientItem(
                controller.recipeForm.cakeIngredient[index],
                onSelect: (e) {
                  controller.recipeForm.cakeIngredient[index] = e;
                  controller.updateStateByKey('updateIngredientItem$index');
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: _buildTextField(
              controller: controller.recipeForm.cakeIngredient[index].quantity,
              hintText: 'Số lượng',
              labelText: ""
            ),
          ),
          IconButton(
            onPressed: () => controller.onRemoveIngredientForm(index),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildAddIngredientButton() {
    return TextButton(
      onPressed: controller.onAddIngredientForm,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, color: Color(0xFFFF8E25)),
          SizedBox(width: 8),
          Text(
            "Thêm nguyên liệu",
            style: TextStyle(color: Color(0xFFFF8E25)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
      return const Text(
        "Thêm công thức mới",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      );
    }
  
    Widget _buildNameField() {
      return _buildTextField(
        controller: controller.recipeForm.cakeName,
        labelText: "Tên công thức",
        hintText: "Nhập tên công thức",
      );
    }
  
    Widget _buildUnitFields() {
      return Row(
        children: [
          Expanded(
            child: _buildTextField(
              controller: controller.recipeForm.unit,
              labelText: "Số lượng",
              hintText: "VD: 100",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: _buildTextField(
              controller: controller.recipeForm.ext,
              labelText: "Đơn vị",
              hintText: "VD: gram, ml,...",
            ),
          ),
        ],
      );
    }
  
    Widget _buildTextField({
      required TextEditingController controller,
      required String labelText,
      String? hintText,
    }) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF8E25), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      );
    }
  
    Widget _buildTypeDropdown() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade50,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<RecipeType>(
            value: controller.recipeForm.recipeType,
            isExpanded: true,
            items: controller.recipeForm.listType.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type.typeName ?? ''),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.recipeForm.recipeType = value!;
                controller.updateStateByKey('updateRecipeType');
              }
            },
          ),
        ),
      );
    }
  
    Widget _buildActionButtons(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              "Hủy",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: (){
              controller.addNewRecipe(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: const Color(0xFFFF8E25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            child: const Text(
              "Lưu",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }

  Widget _buildIngredientItem(
      CakeIngredientForm formValue, {
        required Function(CakeIngredientForm value) onSelect,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CakeIngredientForm>(
          value: formValue,
          isExpanded: true,
          items: controller.recipeForm.listIngredientPick.map((ingredient) {
            return DropdownMenuItem(
              value: ingredient,
              child: Text(ingredient.name),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onSelect(value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildListRecipeSub() {
    return GetBuilder(
      init: controller,
      id: "updateListRecipeSub",
      builder: (context) {
        return Visibility(
          visible: controller.recipeForm.recipeType.typeID == 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    if (controller.recipeForm.listSub.length == i) {
                      return _buildAddRecipeSubButton();
                    }
                    return _buildRecipeSubRow(i);
                  },
                  separatorBuilder: (c, i) => const Divider(height: 1),
                  itemCount: controller.recipeForm.listSub.length + 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecipeSubRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFF8E25),
            radius: 12,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GetBuilder(
              init: controller,
              id: "updateRecipeSubItem$index",
              builder: (_) => _buildRecipeSubItem(
                controller.recipeForm.listSub[index],
                onSelect: (e) {
                  controller.recipeForm.listSub[index] = e;
                  controller.updateStateByKey('updateRecipeSubItem$index');
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () => controller.onRemoveRecipeSubForm(index),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRecipeSubButton() {
    return TextButton(
      onPressed: controller.onAddRecipeSub,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, color: Color(0xFFFF8E25)),
          SizedBox(width: 8),
          Text(
            "Thêm công thức con",
            style: TextStyle(color: Color(0xFFFF8E25)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeSubItem(
      RecipeModel formValue, {
        required Function(RecipeModel value) onSelect,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<RecipeModel>(
          value: formValue,
          isExpanded: true,
          items: controller.recipeForm.listSubPick.map((recipe) {
            return DropdownMenuItem(
              value: recipe,
              child: Text(recipe.cakeName ?? ''),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onSelect(value);
            }
          },
        ),
      ),
    );
  }
}
