import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/recipe/recipe_controller.dart';

class EditIngredientLayout extends StatelessWidget {
  final RecipeController controller;
  const EditIngredientLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildNameField(),
          const SizedBox(height: 24),
          _buildPriceField(),
          const SizedBox(height: 24),
          _buildUnitFields(),
          const SizedBox(height: 24),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      "Thêm nguyên liệu mới",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF333333),
      ),
    );
  }

  Widget _buildNameField() {
    return _buildTextField(
      controller: controller.ingredientForm.name,
      labelText: "Tên",
    );
  }

  Widget _buildPriceField() {
    return _buildTextField(
      controller: controller.ingredientForm.price,
      labelText: "Giá",
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
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
    );
  }

  Widget _buildUnitFields() {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: _buildTextField(
            controller: controller.ingredientForm.unit,
            labelText: "Đơn vị",
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: _buildTextField(
            controller: controller.ingredientForm.ext,
            hintText: "ml",
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildCancelButton(),
        const SizedBox(width: 16),
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () => Get.back(),
      child: const Text(
        "Hủy",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          controller.addNewIngredient(context);
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
    );
  }
}
