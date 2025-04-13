import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/shopping/recipe/recipe_detail_controller.dart';

class RecipeDetailPage extends GetView<RecipeDetailController> {
  const RecipeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (value) async {
        Get.delete<RecipeDetailController>();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF7A00),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.delete<RecipeDetailController>();
              Get.back();
            },
          ),
          elevation: 0.5,
          title: const Text(
            "Chi tiết công thức",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: Obx(() {
          if ((controller.recipeModel.value.cakeName ?? '').isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF8E25),
              ),
            );
          }
          return Column(
            children: [
              _buildHeader(),
              _buildQuantityInput(),
              _buildTableHeader(),
              Expanded(child: _buildIngredientsList()),
              _buildTotal(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.cake, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              controller.recipeModel.value.cakeName ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Text(
            "Số lượng:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
          const Spacer(),
          Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFF8E25)),
            ),
            child: TextField(
              onChanged: controller.onChangeQuantity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFFF8E25),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: controller.recipeModel.value.unit.toString(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            controller.recipeModel.value.ext ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              "Nguyên liệu",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Số lượng",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Thành tiền",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: (controller.recipeModel.value.cakeIngredient ?? []).length,
      separatorBuilder: (c, i) => const Divider(height: 1),
      itemBuilder: (c, i) {
        var data = (controller.recipeModel.value.cakeIngredient ?? [])[i];
        if (data.id == -1) {
          return Container(
            height: 50,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              data.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        return Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Obx(() => Text(
                      "${(controller.quantityUnit.value * (data.quantity ?? 0).toDouble()).toStringAsFixed(1)} ${data.ext}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF666666),
                      ),
                    )),
              ),
              Expanded(
                flex: 3,
                child: Obx(() => Text(
                      AppCommon.singleton.formatCurrency(
                          (controller.quantityUnit.value * data.total)),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFFFF8E25),
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTotal() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF8E25).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Tổng tiền",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          Obx(() => Text(
                AppCommon.singleton.formatCurrency(controller.totalMoney.value),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8E25),
                ),
              )),
        ],
      ),
    );
  }
}
